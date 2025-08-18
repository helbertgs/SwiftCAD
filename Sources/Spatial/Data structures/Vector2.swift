import Foundation

/// A structure representing a 2D vector.
@frozen public struct Vector2 : Codable, Equatable, Hashable, Sendable {

    // MARK: - Inspecting a vector’s properties

    /// The x-coordinate of the vector.
    public let x: Double

    /// The y-coordinate of the vector.
    public let y: Double

    // MARK: - 2D vector constants

    /// Returns a vector with all components set to zero.
    public static var zero: Vector2 {
        Vector2(x: 0, y: 0)
    }

    /// Returns a vector with all components set to one.
    public static var one: Vector2 {
        Vector2(x: 1, y: 1)
    }

    /// Creates a new 2D vector.
    /// - Parameters:
    ///   - x: The x-coordinate of the vector
    ///   - y: The y-coordinate of the vector
    @inlinable public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    /// Creates a new 2D vector from the specified floating-point values.
    /// - Parameters:
    ///   - x: A floating-point value that specifies the x-coordinate.
    ///   - y: A floating-point value that specifies the y-coordinate.
    @inlinable public init<T>(x: T, y: T) where T : BinaryFloatingPoint {
        self.x = Double(x)
        self.y = Double(y)
    }

    /// Creates a new 2D vector from the specified size.
    /// - Parameter size: A size that specifies the dimensions.
    @inlinable public init(size: Size) {
        self.x = size.width
        self.y = size.height
    }
}

extension Vector2 : AdditiveArithmetic {

    // MARK: - Applying arithmetic operations

    /// Multiplies a size by a scalar value.
    /// - Parameters:
    ///   - lhs: The size to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Returns: A new size representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func * (lhs: Vector2, rhs: Double) -> Vector2 {
        Vector2(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    /// Multiplies a vector by a scalar value in place.
    /// - Parameters:
    ///   - lhs: The vector to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Complexity: O(1)
    @inlinable public static func *= (lhs: inout Vector2, rhs: Double) {
        lhs = lhs * rhs
    }

    /// Adds two vectors.
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise sum of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func + (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /// Adds two vectors together.
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Complexity: O(1)
    @inlinable public static func += (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs + rhs
    }

    /// Subtracts two vectors.
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise difference of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func - (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    /// Subtracts two vectors.
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise difference of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func -= (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs - rhs
    }

    /// Divides a vector by a scalar value.
    /// - Parameters:
    ///   - lhs: The vector to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Returns: A new vector representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func / (lhs: Vector2, rhs: Double) -> Vector2 {
        Vector2(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    /// Divides a vector by a scalar value in place.
    /// - Parameters:
    ///   - lhs: The vector to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Complexity: O(1)
    @inlinable public static func /= (lhs: inout Vector2, rhs: Double) {
        lhs = lhs / rhs
    }
}