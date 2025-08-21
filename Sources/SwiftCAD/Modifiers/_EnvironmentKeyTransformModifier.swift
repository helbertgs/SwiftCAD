import Foundation

/// A modifier that transforms a value in the environment.
public struct _EnvironmentKeyTransformModifier<Value> /*: SwiftUICore.ViewModifier, SwiftUICore._GraphInputsModifier */ {

    /// The key path to the environment value.
    public var keyPath: WritableKeyPath<EnvironmentValues, Value>

    /// The transformation to apply to the environment value.
    public var transform: (inout Value) -> Void

    /// Creates a new environment key transform modifier.
    /// 
    /// - Parameters:
    ///   - keyPath: The key path to the environment value.
    ///   - transform: The transformation to apply to the environment value.
    @inlinable public init(keyPath: WritableKeyPath<EnvironmentValues, Value>, transform: @escaping (inout Value) -> Void) {
        self.keyPath = keyPath
        self.transform = transform
    }
}

extension _EnvironmentKeyTransformModifier : ShapeModifier {

    /// Gets the current body of the caller.
    /// 
    /// content is a proxy for the shape that will have the modifier represented by Self applied to it.
    public func body(content: Self.Content) -> Never {
        fatalError("body() has not been implemented")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// 
    /// - Parameters:
    ///   - modifier: The graph value representing the shape modifier.
    ///   - inputs: The inputs for the shape.
    ///   - body: A closure that takes a graph and inputs, and returns the outputs of the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ modifier: _GraphValue<_EnvironmentKeyTransformModifier<Value>>, inputs: _ShapeInputs, body: @escaping (_Graph, _ShapeInputs) -> _ShapeOutputs) -> _ShapeOutputs {
        var inputs = inputs
        modifier.value.transform(&inputs.environmentValues[keyPath: modifier.value.keyPath])

        return body(_Graph(modifier.value), inputs)
    } 
}
