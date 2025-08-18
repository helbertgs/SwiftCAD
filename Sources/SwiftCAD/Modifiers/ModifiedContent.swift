import Foundation

/// A structure that represents a modified content.
public struct ModifiedContent<Content, Modifier> {

    /// The content to be modified.
    private let content: Content

    /// The modifier to be applied to the content.
    private let modifier: Modifier

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
    public var body: Never {
        fatalError("body has not been implemented")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<ModifiedContent<Content, Modifier>>, inputs: _ShapeInputs) -> _ShapeOutputs {
        .init()
    }
}

extension ModifiedContent : ShapeModifier where Modifier : ShapeModifier, Modifier : ShapeModifier {

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
    public static func _makeShape(_ modifier: _GraphValue<ModifiedContent<Content, Modifier>>, inputs: _ShapeInputs, body: @escaping (_Graph, _ShapeInputs) -> _ShapeOutputs) -> _ShapeOutputs {
        .init()
    }
}