import Foundation

/// An empty modifier.
public struct EmptyModifier {

    /// Creates a new empty modifier.
    public init() { }
}

extension EmptyModifier : ShapeModifier {
    public typealias Body = Never
}