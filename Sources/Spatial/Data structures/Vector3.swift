import Foundation

/// A structure representing a 3D vector.
@frozen public struct Vector3 : Codable, Equatable, Hashable, Sendable {

    // MARK: - Inspecting a vector’s properties

    /// The x-coordinate of the vector.
    public let x: Double

    /// The y-coordinate of the vector.
    public let y: Double

    /// The z-coordinate of the vector.
    public let z: Double

    // MARK: - 3D vector constants

    /// Returns a vector with all components set to zero.
    public static var zero: Vector3 {
        Vector3(x: 0, y: 0, z: 0)
    }

    /// Returns a vector with all components set to one.
    public static var one: Vector3 {
        Vector3(x: 1, y: 1, z: 1)
    }

    /// Creates a new 3D vector.
    /// - Parameters:
    ///   - x: The x-coordinate of the vector
    ///   - y: The y-coordinate of the vector
    ///   - z: The z-coordinate of the vector
    @inlinable public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Creates a new 3D vector from the specified floating-point values.
    /// - Parameters:
    ///   - x: A floating-point value that specifies the x-coordinate.
    ///   - y: A floating-point value that specifies the y-coordinate.
    ///   - z: A floating-point value that specifies the z-coordinate.
    @inlinable public init<T>(x: T, y: T, z: T) where T : BinaryFloatingPoint {
        self.x = Double(x)
        self.y = Double(y)
        self.z = Double(z)
    }

    /// Creates a new 3D vector from the specified size.
    /// - Parameter size: A size that specifies the dimensions.
    @inlinable public init(size: Size) {
        self.x = size.width
        self.y = size.height
        self.z = size.depth
    }
}

extension Vector3 : AdditiveArithmetic {

    // MARK: - Applying arithmetic operations

    /// Multiplies a size by a scalar value.
    /// - Parameters:
    ///   - lhs: The size to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Returns: A new size representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func * (lhs: Vector3, rhs: Double) -> Vector3 {
        Vector3(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }

    /// Multiplies a vector by a scalar value in place.
    /// - Parameters:
    ///   - lhs: The vector to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Complexity: O(1)
    @inlinable public static func *= (lhs: inout Vector3, rhs: Double) {
        lhs = lhs * rhs
    }

    /// Adds two vectors.
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise sum of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func + (lhs: Vector3, rhs: Vector3) -> Vector3 {
        return Vector3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    /// Adds two vectors together.
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Complexity: O(1)
    @inlinable public static func += (lhs: inout Vector3, rhs: Vector3) {
        lhs = lhs + rhs
    }

    /// Subtracts two vectors.
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise difference of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func - (lhs: Vector3, rhs: Vector3) -> Vector3 {
        return Vector3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    /// Subtracts two vectors.
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise difference of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func -= (lhs: inout Vector3, rhs: Vector3) {
        lhs = lhs - rhs
    }

    /// Divides a vector by a scalar value.
    /// - Parameters:
    ///   - lhs: The vector to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Returns: A new vector representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func / (lhs: Vector3, rhs: Double) -> Vector3 {
        Vector3(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }

    /// Divides a vector by a scalar value in place.
    /// - Parameters:
    ///   - lhs: The vector to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Complexity: O(1)
    @inlinable public static func /= (lhs: inout Vector3, rhs: Double) {
        lhs = lhs / rhs
    }
}