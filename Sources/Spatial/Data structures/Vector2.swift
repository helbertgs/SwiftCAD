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

    // MARK: - Creating a 2D vector

    /// Creates a new 2D vector.
    ///
    /// - Parameters:
    ///   - x: The x-coordinate of the vector
    ///   - y: The y-coordinate of the vector
    @inlinable public init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }

    /// Creates a new 2D vector from the specified floating-point values.
    ///
    /// - Parameters:
    ///   - x: A floating-point value that specifies the x-coordinate.
    ///   - y: A floating-point value that specifies the y-coordinate.
    @inlinable public init<T>(x: T, y: T) where T : BinaryFloatingPoint {
        self.x = Double(x)
        self.y = Double(y)
    }

    /// Creates a new 2D vector from the specified size.
    ///
    /// - Parameter size: A size that specifies the dimensions.
    @inlinable public init(size: Size) {
        self.x = size.width
        self.y = size.height
    }

    /// Creates a new 2D vector from the specified 3D vector.
    ///
    /// - Parameter vector3: A 3D vector that specifies the x, y, and z coordinates.
    @inlinable public init(_ vector3: Vector3) {
        self.x = vector3.x
        self.y = vector3.y
    }
}

extension Vector2 : AdditiveArithmetic {

    // MARK: - Applying arithmetic operations

    /// Multiplies a size by a scalar value.
    ///
    /// - Parameters:
    ///   - lhs: The size to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Returns: A new size representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func * (lhs: Vector2, rhs: Double) -> Vector2 {
        Vector2(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    /// Multiplies a vector by a scalar value in place.
    ///
    /// - Parameters:
    ///   - lhs: The vector to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Complexity: O(1)
    @inlinable public static func *= (lhs: inout Vector2, rhs: Double) {
        lhs = lhs * rhs
    }

    /// Adds two vectors.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise sum of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func + (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /// Adds two vectors together.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Complexity: O(1)
    @inlinable public static func += (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs + rhs
    }

    /// Subtracts two vectors.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise difference of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func - (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    /// Subtracts two vectors.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise difference of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func -= (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs - rhs
    }

    /// Divides a vector by a scalar value.
    ///
    /// - Parameters:
    ///   - lhs: The vector to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Returns: A new vector representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func / (lhs: Vector2, rhs: Double) -> Vector2 {
        Vector2(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    /// Divides a vector by a scalar value in place.
    ///
    /// - Parameters:
    ///   - lhs: The vector to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Complexity: O(1)
    @inlinable public static func /= (lhs: inout Vector2, rhs: Double) {
        lhs = lhs / rhs
    }
}

extension Vector2 : Primitive {

    /// Returns a Boolean value that indicates whether the vector is finite.
    public var isFinite: Bool {
        x.isFinite && y.isFinite
    }

    /// Returns a Boolean value that indicates whether the vector contains any NaN values.
    public var isNaN: Bool {
        x.isNaN || y.isNaN
    }

    /// Returns a Boolean value that indicates whether the vector is zero.
    public var isZero: Bool {
        x == 0 && y == 0
    }

    /// A vector with infinite values.
    public static var infinity: Vector2 {
        Vector2(x: .infinity, y: .infinity)
    }
}

extension Vector2 : Scalable {

    /// Scales the entity by the given size.
    /// 
    /// - Parameter size: The size to scale the entity by.
    public mutating func scale(by size: Size) {
        self = Vector2(x: x * size.width, y: y * size.height)
    }

    /// Scales the entity by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    public mutating func scaleBy(x: Double, y: Double) {
        self = Vector2(x: x * self.x, y: y * self.y)
    }

    /// Returns a new entity scaled by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    public func scaledBy(x: Double, y: Double) -> Vector2 {
        Vector2(x: x * self.x, y: y * self.y)
    }

    /// Scales the entity by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    ///   - z: The factor to scale the entity's z dimension by.
    public mutating func scaleBy(x: Double, y: Double, z: Double) {
        self = Vector2(x: x * self.x, y: y * self.y)
    }

    /// Returns a new entity scaled by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    ///   - z: The factor to scale the entity's z dimension by.
    public func scaledBy(x: Double, y: Double, z: Double) -> Vector2 {
        Vector2(x: x * self.x, y: y * self.y)
    }

    /// Uniformly scales the entity by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    public mutating func uniformlyScale(by scale: Double) {
        self = Vector2(x: x * scale, y: y * scale)
    }

    /// Returns a new entity uniformly scaled by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    public func uniformlyScaled(by scale: Double) -> Vector2 {
        Vector2(x: x * scale, y: y * scale)
    }
}

extension Vector2 : Rotatable {

    /// Rotates the point by the specified quaternion.
    ///
    /// - Parameter quaternion: The quaternion representing the rotation.
    public mutating func rotate(by quaternion: Quaternion) {
    }

    /// Returns a new point rotated by the specified quaternion.
    ///
    /// - Parameter rotation: The quaternion representing the rotation.
    public func rotated(by rotation: Quaternion) -> Vector2 {
        var copy = self
        copy.rotate(by: rotation)
        return copy
    }
}

extension Vector2 : Translatable {

    /// Translates the entity by the given vector.
    /// 
    /// - Parameter vector: The vector that defines the translation.
    public mutating func translate(by vector: Vector2) {
        self = Vector2(x: x + vector.x, y: y + vector.y)
    }

    /// Returns a new entity translated by the given vector.
    /// 
    /// - Parameter vector: The vector that defines the translation.
    public func translated(by vector: Vector2) -> Vector2 {
        var copy = self
        copy.translate(by: vector)
        return copy
    }

    /// Translates the entity by the given vector.
    /// 
    /// - Parameter vector: The vector that defines the translation.
    public mutating func translate(by vector: Vector3) {
        self = Vector2(x: x + vector.x, y: y + vector.y)
    }

    /// Returns a new entity translated by the given vector.
    /// 
    /// - Parameter vector: The vector that defines the translation.
    public func translated(by vector: Vector3) -> Vector2 {
        var copy = self
        copy.translate(by: vector)
        return copy
    }
}