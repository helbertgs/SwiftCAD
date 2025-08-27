import Foundation

/// A structure that defines a tuple shape, which can contain any shape as its content.
@frozen public struct _TupleShape<Content> {

    /// The content of the tuple shape, which is a shape conforming to the `Shape` protocol.
    public var content: Content

    /// Initializes a new instance of `_TupleShape` with the provided content.
    /// - Parameter content: The content of the tuple shape.
    @inlinable public init(_ content: Content) {
        self.content = content
    }
}

extension _TupleShape : Shape {

    /// The body of the shape.
    public var body : Never {
        fatalError("This should never be called")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<_TupleShape>, inputs: _ShapeInputs) -> _ShapeOutputs {
        let mirror = Mirror(reflecting: shape.value.content)
        var outputs = _ShapeOutputs()
        outputs.type = Self.self
        outputs.content = shape.value

        for child in mirror.children {
            guard let shape = child.value as? any Shape else {
                continue
            }

            func build<T>(_ shape: T, inputs: _ShapeInputs) -> _ShapeOutputs where T : Shape {
                T._makeShape(_GraphValue(shape), inputs: inputs)
            }

            let output = build(shape, inputs: inputs)
            outputs.vertices.append(contentsOf: output.vertices)
            outputs.faces.append(contentsOf: output.faces)
            outputs.faces.append(contentsOf: output.faces)
            outputs.children.append(output)
        }

        return outputs
    }
}