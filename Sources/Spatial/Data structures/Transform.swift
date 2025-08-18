import Foundation

/// A structure representing a 3D transformation.
public struct Transform {

    /// The translation component of the transformation.
    public var translation: Vector3

    /// The rotation component of the transformation.
    public var rotation: Quaternion

    /// The scale component of the transformation.
    public var scale: Vector3

    /// Initializes a new transformation with the given translation, rotation, and scale.
    /// 
    /// - Parameters:
    ///   - translation: The translation component of the transformation.
    ///   - rotation: The rotation component of the transformation.
    ///   - scale: The scale component of the transformation.
    public init(translation: Vector3, rotation: Quaternion, scale: Vector3) {
        self.translation = translation
        self.rotation = rotation
        self.scale = scale
    }
}