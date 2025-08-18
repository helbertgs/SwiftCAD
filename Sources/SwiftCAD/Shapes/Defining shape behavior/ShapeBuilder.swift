import Foundation

/// A result builder for creating shapes.
@resultBuilder 
public struct ShapeBuilder {

    /// Builds a shape from a single content.
    /// 
    /// - Parameter content: The content to build the shape from.
    /// - Returns: A shape built from the content.
    public static func buildBlock<Content>(_ content: Content) -> Content where Content : Shape {
        content
    }

    /// Builds a shape from multiple contents.
    /// 
    /// - Parameter content: The contents to build the shape from.
    /// - Returns: A shape built from the contents.
    public static func buildBlock<each Content>(_ content: repeat each Content) -> _TupleShape<(repeat each Content)> where repeat each Content : Shape {
        _TupleShape((repeat each content))
    }
}