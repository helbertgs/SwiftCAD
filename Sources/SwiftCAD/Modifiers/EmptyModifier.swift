import Foundation

/// An empty modifier.
public struct EmptyModifier : ShapeModifier {

    /// Creates a new empty modifier.
    public init() { }

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
    public static func _makeShape(_ modifier: _GraphValue<EmptyModifier>, inputs: _ShapeInputs, body: @escaping (_Graph, _ShapeInputs) -> _ShapeOutputs) -> _ShapeOutputs {
        .init()
    }
}

public struct CustomModifier : ShapeModifier {

    /// Creates a new custom modifier.
    public init() { }

    /// Gets the current body of the caller.
    /// 
    /// content is a proxy for the shape that will have the modifier represented by Self applied to it.
    public func body(content: Content) -> some Shape {
        content
            .disabled(true)
    }
}

extension Shape {
    public func custom() -> some Shape {
        ModifiedContent(content: self, modifier: CustomModifier())
    }
}