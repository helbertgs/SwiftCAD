import Foundation

/// A shape that represents the union of two or more shapes.
public struct Union<Content> {

    /// The content of the union shape, which is a shape conforming to the `Shape` protocol.
    public let content: Content

    /// Creates a new union shape with the specified content.
    /// 
    /// - Parameter content: The content of the union shape.
    public init(@ShapeBuilder _ content: () -> Content) {
        self.content = content()
    } 
}

extension Union : Shape where Content : Shape {

    /// The body of the shape.
    public var body : Never {
        fatalError("This should never be called")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<Union<Content>>, inputs: _ShapeInputs) -> _ShapeOutputs {
        Content._makeShape(.init(shape.value.content), inputs: inputs)
    }
}