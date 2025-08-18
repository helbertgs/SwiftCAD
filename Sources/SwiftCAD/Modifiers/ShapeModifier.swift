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