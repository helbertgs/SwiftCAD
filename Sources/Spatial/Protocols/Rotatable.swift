import Foundation

/// A set of methods that defines the interface to rotate Spatial entities.
public protocol Rotatable {

    /// Rotates the object by the specified quaternion.
    /// - Parameter quaternion: The quaternion representing the rotation.
    mutating func rotate(by quaternion: Quaternion)

    /// Returns a new entity rotated by the specified quaternion.
    /// - Parameter rotation: The quaternion representing the rotation.
    func rotated(by rotation: Quaternion) -> Self
}