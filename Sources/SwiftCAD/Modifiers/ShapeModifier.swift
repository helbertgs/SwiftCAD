import Foundation

/// Creating a shape modifier
public protocol ShapeModifier {

    // MARK: - Creating a shape modifier

    /// The type of shape representing the body.
    associatedtype Body : Shape

    /// The content view type passed to body().
    typealias Content = _ShapeModifier_Content<Self>

    /// Gets the current body of the caller.
    /// 
    /// content is a proxy for the shape that will have the modifier represented by Self applied to it.
    func body(content: Self.Content) -> Self.Body

    /// Creates a new shape from the given graph value and inputs.
    /// 
    /// - Parameters:
    ///   - modifier: The graph value representing the shape modifier.
    ///   - inputs: The inputs for the shape.
    ///   - body: A closure that takes a graph and inputs, and returns the outputs of the shape.
    /// - Returns: The outputs of the shape.
    static func _makeShape(_ modifier: _GraphValue<Self>, inputs: _ShapeInputs, body: @escaping (_Graph, _ShapeInputs) -> _ShapeOutputs) -> _ShapeOutputs
}

extension ShapeModifier {

    /// Concatenates the current shape modifier with another shape modifier.
    /// 
    /// - Parameter modifier: The shape modifier to concatenate.
    /// - Returns: A modified content that represents the concatenation of the two shape modifiers.
    public func concat<T>(_ modifier: T) -> ModifiedContent<Self, T> where T : ShapeModifier {
        .init(content: self, modifier: modifier)
    }
}

extension ShapeModifier {

    /// Creates a new shape from the given graph value and inputs.
    /// 
    /// - Parameters:
    ///   - modifier: The graph value representing the shape modifier.
    ///   - inputs: The inputs for the shape.
    ///   - body: A closure that takes a graph and inputs, and returns the outputs of the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ modifier: _GraphValue<Self>, inputs: _ShapeInputs, body: @escaping (_Graph, _ShapeInputs) -> _ShapeOutputs) -> _ShapeOutputs {
        guard Self.Body.self != Never.self else {
            var outputs = body(.init(modifier.value), inputs)
            outputs.modifiers.append(modifier.value)

            return outputs  
        }

        let content = Self.Content(content: modifier.value)
        let shape = modifier.value.body(content: content)
        let graph = _Graph(shape)

        return body(graph, inputs)
    }
}

extension ShapeModifier where Body == Never {

    /// Gets the current body of the caller.
    /// 
    /// content is a proxy for the shape that will have the modifier represented by Self applied to it.
    public func body(content: Self.Content) -> Never {
        fatalError("body() has not been implemented")
    }
}   
