import Spatial

/// A translate modifier.
public struct TranslateModifier {

    /// The vector to translate by.
    public let vector: Vector3

    /// Creates a new translate modifier.
    public init(_ vector: Vector3) {
        self.vector = vector
    }
}

extension TranslateModifier : ShapeModifier {
    public typealias Body = Never
}