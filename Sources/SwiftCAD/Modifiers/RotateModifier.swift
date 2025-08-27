import Spatial

/// A Rotate modifier.
public struct RotateModifier {

    /// The quaternion to Rotate by.
    public let quaternion: Quaternion

    /// Creates a new Rotate modifier.
    public init(_ quaternion: Quaternion) {
        self.quaternion = quaternion
    }
}

extension RotateModifier : ShapeModifier {
    public typealias Body = Never
}