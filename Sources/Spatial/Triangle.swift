import Foundation

/// A structure representing a triangle in 3D space.
public struct Triangle {

    /// The first vertex of the triangle.
    public let a: Vector3

    /// The second vertex of the triangle.
    public let b: Vector3

    /// The third vertex of the triangle.
    public let c: Vector3

    /// Creates a new triangle.
    /// - Parameters:
    ///   - a: The first vertex of the triangle.
    ///   - b: The second vertex of the triangle.
    ///   - c: The third vertex of the triangle.
    public init(a: Vector3, b: Vector3, c: Vector3) {
        self.a = a
        self.b = b
        self.c = c
    }
}