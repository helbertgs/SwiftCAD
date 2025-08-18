import Foundation

/// A structure representing a 3D vector.
public struct Vector3 {

    /// The x-coordinate of the vector.
    public let x: Double

    /// The y-coordinate of the vector.
    public let y: Double

    /// The z-coordinate of the vector.
    public let z: Double

    /// Creates a new 3D vector.
    /// - Parameters:
    ///   - x: The x-coordinate of the vector
    ///   - y: The y-coordinate of the vector
    ///   - z: The z-coordinate of the vector
    public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}