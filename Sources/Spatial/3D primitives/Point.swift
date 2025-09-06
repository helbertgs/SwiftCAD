import Foundation

/// A point in a 3D coordinate system.
@frozen public struct Point : Codable, Equatable, Hashable, Sendable {

    // MARK: - Inspecting a point’s properties

    /// The x-coordinate value.
    public let x: Double

    /// The y-coordinate value.
    public let y: Double

    /// The z-coordinate value.
    public let z: Double

    // MARK: - 3D point constants

    /// Returns a point with all coordinates set to zero.
    public static var zero: Point {
        Point(x: 0, y: 0, z: 0)
    }

    /// Returns a point with all coordinates set to one.
    public static var one: Point {
        Point(x: 1, y: 1, z: 1)
    }

    // MARK: - Creating a 3D point

    /// Creates a new 3D point.
    /// 
    /// - Parameters:
    ///   - x: The x-coordinate value.
    ///   - y: The y-coordinate value.
    ///   - z: The z-coordinate value.
    @inlinable public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Creates a new 3D point from the specified floating-point values.
    /// 
    /// - Parameters:
    ///   - x: A floating-point value that specifies the x-coordinate.
    ///   - y: A floating-point value that specifies the y-coordinate.
    ///   - z: A floating-point value that specifies the z-coordinate.
    @inlinable public init<T>(x: T, y: T, z: T) where T : BinaryFloatingPoint {
        self.x = Double(x)
        self.y = Double(y)
        self.z = Double(z)
    }

    /// Creates a new 3D point from the specified 2D size.
    /// 
    /// - Parameters:
    ///   - size: A 2D size that specifies the width and height.
    @inlinable public init(_ size: Size) {
        self.x = size.width
        self.y = size.height
        self.z = size.depth
    }

    /// Creates a new 3D point from the specified 3D vector.
    ///
    /// - Parameters:
    ///   - vector: A 3D vector that specifies the x, y, and z coordinates.
    @inlinable public init(_ vector: Vector3) {
        self.x = vector.x
        self.y = vector.y
        self.z = vector.z
    }

    // MARK: - Checking characteristics

    /// The squared magnitude of the point.
    public var magnitudeSquared: Double {
        x * x + y * y + z * z
    }

    /// Calculates the distance from this point to another point.
    /// 
    /// - Parameter other: The other point to measure the distance to.
    /// - Returns: The distance between the two points.
    /// - Complexity: O(1)
    public func distance(to other: Point) -> Double {
        let dx = other.x - self.x
        let dy = other.y - self.y
        let dz = other.z - self.z

        return (dx * dx + dy * dy + dz * dz).squareRoot()
    }
}

extension Point : AdditiveArithmetic {

    // MARK: - Applying arithmetic operations

    /// Multiplies a point by a scalar value.
    ///
    /// - Parameters:
    ///   - lhs: The point to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Returns: A new point representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func * (lhs: Point, rhs: Double) -> Point {
        Point(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }

    /// Multiplies a point by a scalar value in place.
    ///
    /// - Parameters:
    ///   - lhs: The point to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Complexity: O(1)
    @inlinable public static func *= (lhs: inout Point, rhs: Double) {
        lhs = lhs * rhs
    }

    /// Adds two points.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side point.
    ///   - rhs: The right-hand-side point.
    /// - Returns: A new point representing the element-wise sum of the two points.
    /// - Complexity: O(1)
    @inlinable public static func + (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    /// Adds two points together.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side point.
    ///   - rhs: The right-hand-side point.
    /// - Complexity: O(1)
    @inlinable public static func += (lhs: inout Point, rhs: Point) {
        lhs = lhs + rhs
    }

    /// Subtracts two points.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side point.
    ///   - rhs: The right-hand-side point.
    /// - Returns: A new point representing the element-wise difference of the two points.
    /// - Complexity: O(1)
    @inlinable public static func - (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    /// Subtracts two points.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side point.
    ///   - rhs: The right-hand-side point.
    /// - Returns: A new point representing the element-wise difference of the two points.
    /// - Complexity: O(1)
    @inlinable public static func -= (lhs: inout Point, rhs: Point) {
        lhs = lhs - rhs
    }

    /// Divides a point by a scalar value.
    ///
    /// - Parameters:
    ///   - lhs: The point to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Returns: A new point representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func / (lhs: Point, rhs: Double) -> Point {
        Point(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }

    /// Divides a point by a scalar value in place.
    ///
    /// - Parameters:
    ///   - lhs: The point to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Complexity: O(1)
    @inlinable public static func /= (lhs: inout Point, rhs: Double) {
        lhs = lhs / rhs
    }
}

extension Point : Primitive {

    /// Returns the entity that results from applying an affine transform.
    ///
    /// - Parameter transform: The affine transform that the function applies to the Spatial primitive.
    public func applying(_ transform: AffineTransform) -> Point {
        .zero
    }

    /// Returns the entity that results from applying a projective transform.
    ///
    /// - Parameter transform: The projective transform that the function applies to the Spatial primitive.
    public func applying(_ transform: ProjectiveTransform) -> Point {
        .zero
    }

    /// Returns a Boolean value that indicates whether the primitive is infinite.
    public var isFinite: Bool {
        x.isFinite && y.isFinite && z.isFinite
    }

    /// Returns a Boolean value that indicates whether the primitive contains any NaN values.
    public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN
    }

    /// Returns a Boolean value that indicates whether the primitive is zero.
    public var isZero: Bool {
        x == 0 && y == 0 && z == 0
    }

    /// A primitive with infinite values.
    public static var infinity: Point {
        Point(x: .infinity, y: .infinity, z: .infinity)
    }
}

extension Point : Scalable {

    /// Scales the entity by the given size.
    /// 
    /// - Parameter size: The size to scale the entity by.
    public mutating func scale(by size: Size) {
        self = Point(x: x * size.width, y: y * size.height, z: z * size.depth)
    }

    /// Scales the entity by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    public mutating func scaleBy(x: Double, y: Double) {
        self = Point(x: x * self.x, y: y * self.y, z: self.z)
    }

    /// Returns a new entity scaled by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    public func scaledBy(x: Double, y: Double) -> Point {
        Point(x: x * self.x, y: y * self.y, z: self.z)
    }

    /// Scales the entity by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    ///   - z: The factor to scale the entity's z dimension by.
    public mutating func scaleBy(x: Double, y: Double, z: Double) {
        self = Point(x: x * self.x, y: y * self.y, z: z * self.z)
    }

    /// Returns a new entity scaled by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    ///   - z: The factor to scale the entity's z dimension by.
    public func scaledBy(x: Double, y: Double, z: Double) -> Point {
        Point(x: x * self.x, y: y * self.y, z: z * self.z)
    }

    /// Uniformly scales the entity by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    public mutating func uniformlyScale(by scale: Double) {
        self = Point(x: x * scale, y: y * scale, z: z * scale)
    }

    /// Returns a new entity uniformly scaled by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    public func uniformlyScaled(by scale: Double) -> Point {
        Point(x: x * scale, y: y * scale, z: z * scale)
    }
}

extension Point : Rotatable {

    /// Rotates the point by the specified quaternion.
    ///
    /// - Parameter quaternion: The quaternion representing the rotation.
    public mutating func rotate(by quaternion: Quaternion) {
        let vector = Vector3(self).rotated(by: quaternion)
        self = Point(vector)
    }

    /// Returns a new point rotated by the specified quaternion.
    ///
    /// - Parameter rotation: The quaternion representing the rotation.
    public func rotated(by rotation: Quaternion) -> Point {
        var copy = self
        copy.rotate(by: rotation)
        return copy
    }
}
