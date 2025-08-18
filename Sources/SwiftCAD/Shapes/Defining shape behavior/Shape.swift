import Foundation

/// A protocol that defines a geometric shape.
public protocol Shape {

    /// The type of the shape's body.
    associatedtype Body : Shape

    /// The body of the shape.
    @ShapeBuilder var body : Self.Body { get }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    static func _makeShape(_ shape: _GraphValue<Self>, inputs: _ShapeInputs) -> _ShapeOutputs
}