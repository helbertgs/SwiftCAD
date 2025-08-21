import Foundation

/// A structure that wraps the content of a shape modifier.
@frozen public struct _ShapeModifier_Content<Content> {

    /// The content shape type passed to body().
    public let content: Content

    /// Creates a shape modifier content wrapper.
    /// 
    /// - Parameter content: The content shape to be wrapped.
    @inlinable public init(content: Content) {
        self.content = content
    }
}

extension _ShapeModifier_Content : Shape where Content : ShapeModifier {

    /// The body of the shape.
    public var body : Never {
        fatalError("This should never be called")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<_ShapeModifier_Content<Content>>, inputs: _ShapeInputs) -> _ShapeOutputs {
        var outputs = _ShapeOutputs()

        let _ = Content
                    ._makeShape(
                        .init(shape.value.content),
                        inputs: inputs,
                        body: { graph, inp in
                            guard let shape = graph.root as? _GraphValue<any Shape> else {
                                return .init()
                            }

                            outputs = extract(shape.value, inputs: inp)
                            return .init()
                        }
                    )

        return outputs
    }

    private static func extract<T>(_ shape: T, inputs: _ShapeInputs) -> _ShapeOutputs where T : Shape  {
        T._makeShape(.init(shape), inputs: inputs)
    }
}
