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