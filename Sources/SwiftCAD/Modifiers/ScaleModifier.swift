import Spatial

/// A Rotate modifier.
public struct ScaleModifier {

    /// The size to scale by.
    public let size: Size

    /// Creates a new Scale modifier.
    public init(_ size: Size) {
        self.size = size
    }
}

extension ScaleModifier : ShapeModifier {
    public typealias Body = Never
}