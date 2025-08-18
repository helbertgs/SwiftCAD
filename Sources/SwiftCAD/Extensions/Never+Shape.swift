import Foundation

extension Never : Shape {

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<Never>, inputs: _ShapeInputs) -> _ShapeOutputs {
        .init()
    }
}