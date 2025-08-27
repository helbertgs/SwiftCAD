import Foundation

/// A structure that represents a modified content.
public struct ModifiedContent<Content, Modifier> {

    /// The content to be modified.
    public let content: Content

    /// The modifier to be applied to the content.
    public let modifier: Modifier

    /// Creates a new modified content.
    /// - Parameters:
    ///   - content: The content to be modified.
    ///   - modifier: The modifier to be applied to the content.    
    public init(content: Content, modifier: Modifier) {
        self.content = content
        self.modifier = modifier
    }
}

extension ModifiedContent : Shape where Content : Shape, Modifier : ShapeModifier {
    
    /// The body of the shape.
    public var body: Content {
        content
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<ModifiedContent<Content, Modifier>>, inputs: _ShapeInputs) -> _ShapeOutputs {
        let content = shape.value.content
        let modifier = shape.value.modifier

        var outputs = Content._makeShape(_GraphValue(content, generation: shape.generation + 1), inputs: inputs)
        outputs.modifiers.append(modifier)

        return outputs
    }
}
