import Foundation

/// A set of methods that defines the interface to rotate Spatial entities.
public protocol Rotatable {

    /// Rotates the object by the specified angle.
    /// - Parameter angle: The angle in radians to rotate the object.
    mutating func rotate(by angle: Double)

    /// Rotates the object by the specified quaternion.
    /// - Parameter quaternion: The quaternion representing the rotation.
    mutating func rotate(by quaternion: Quaternion)
}