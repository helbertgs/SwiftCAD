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

    // MARK: - Type properties

    /// A vector that contains the values 0, 0, 1.
    public static let forward: Vector3 = .init(x: 0, y: 0, z: 1)

    /// A vector that contains the values 1, 0, 0.
    public static let right: Vector3 = .init(x: 1, y: 0, z: 0)

    /// A vector that contains the values 0, 1, 0.
    public static let up: Vector3 = .init(x: 0, y: 1, z: 0)

    // MARK: - Creating a 3D vector

    /// Creates a new 3D vector.
    /// 
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

    /// Creates a new 3D vector from the specified size.
    /// 
    /// - Parameter size: A size that specifies the dimensions.
    @inlinable public init(size: Size) {
        self.x = size.width
        self.y = size.height
        self.z = size.depth
    }

    /// Creates a new 3D vector from the specified 3D point.
    ///
    /// - Parameters:
    ///   - point: A 3D point that specifies the x, y, and z coordinates.
    @inlinable public init(_ point: Point) {
        self.x = point.x
        self.y = point.y
        self.z = point.z
    }

    // MARK: - Geometry functions
    
    /// Returns the cross product of the vector and the specified vector.
    ///
    /// - Parameter other: The second vector.
    public func cross(_ other: Vector3) -> Vector3 {
        .zero
    }
    
    /// Returns the dot product of the vector and the specified vector.
    ///
    /// - Parameter other: The second vector.
    public func dot(_ other: Vector3) -> Double {
        0
    }
    
    /// The length of the vector.
    public var length: Double {
        sqrt(x * x + y * y + z * z)
    }

    /// The square of the length of the vector.
    public var lengthSquared: Double {
        0
    }
    
    /// Normalizes the mutable vector.
    public mutating func normalize() {
    }
    
    /// A new vector that represents the normalized copy of the current vector.
    public var normalized: Vector3 {
        length > 0 ? self * (1 / length) : self
    }
    
    /// Returns the vector projected onto the specified vector.
    ///
    /// - Parameter other: The second vector.
    public func projected(_ other: Vector3) -> Vector3 {
        .zero
    }
    
    /// Returns the reflection direction of the incident vector and a specified unit normal vector.
    ///
    /// - Parameter normal: The unit normal vector.
    public func reflected(_ normal: Vector3) -> Vector3 {
        .zero
    }

    // MARK: - Transforming a vector

    /// Returns the entity that results from applying an affine transform.
    ///
    /// - Parameter transform: The affine transform that the function applies to the Spatial primitive.
    public func applying(_ transform: AffineTransform) -> Vector3 {
        .zero
    }

    /// Returns the entity that results from applying a projective transform.
    ///
    /// - Parameter transform: The projective transform that the function applies to the Spatial primitive.
    public func applying(_ transform: ProjectiveTransform) -> Vector3 {
        .zero
    }
}

extension Vector3 : AdditiveArithmetic {

    // MARK: - Applying arithmetic operations

    /// Multiplies a size by a scalar value.
    ///
    /// - Parameters:
    ///   - lhs: The size to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Returns: A new size representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func * (lhs: Vector3, rhs: Double) -> Vector3 {
        Vector3(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }

    /// Multiplies a vector by a scalar value in place.
    ///
    /// - Parameters:
    ///   - lhs: The vector to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Complexity: O(1)
    @inlinable public static func *= (lhs: inout Vector3, rhs: Double) {
        lhs = lhs * rhs
    }

    /// Adds two vectors.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise sum of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func + (lhs: Vector3, rhs: Vector3) -> Vector3 {
        return Vector3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    /// Adds two vectors together.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Complexity: O(1)
    @inlinable public static func += (lhs: inout Vector3, rhs: Vector3) {
        lhs = lhs + rhs
    }

    /// Subtracts two vectors.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise difference of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func - (lhs: Vector3, rhs: Vector3) -> Vector3 {
        return Vector3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    /// Subtracts two vectors.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side vector.
    ///   - rhs: The right-hand-side vector.
    /// - Returns: A new vector representing the element-wise difference of the two vectors.
    /// - Complexity: O(1)
    @inlinable public static func -= (lhs: inout Vector3, rhs: Vector3) {
        lhs = lhs - rhs
    }

    /// Divides a vector by a scalar value.
    ///
    /// - Parameters:
    ///   - lhs: The vector to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Returns: A new vector representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func / (lhs: Vector3, rhs: Double) -> Vector3 {
        Vector3(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }

    /// Divides a vector by a scalar value in place.
    ///
    /// - Parameters:
    ///   - lhs: The vector to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Complexity: O(1)
    @inlinable public static func /= (lhs: inout Vector3, rhs: Double) {
        lhs = lhs / rhs
    }
}

extension Vector3 : Primitive {

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
    public static var infinity: Vector3 {
        Vector3(x: .infinity, y: .infinity, z: .infinity)
    }
}

extension Vector3 : Scalable {

    /// Scales the entity by the given size.
    /// 
    /// - Parameter size: The size to scale the entity by.
    public mutating func scale(by size: Size) {
        self = Vector3(x: x * size.width, y: y * size.height, z: z * size.depth)
    }

    /// Scales the entity by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    public mutating func scaleBy(x: Double, y: Double) {
        self = Vector3(x: x * self.x, y: y * self.y, z: self.z)
    }

    /// Returns a new entity scaled by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    public func scaledBy(x: Double, y: Double) -> Vector3 {
        Vector3(x: x * self.x, y: y * self.y, z: self.z)
    }

    /// Scales the entity by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    ///   - z: The factor to scale the entity's z dimension by.
    public mutating func scaleBy(x: Double, y: Double, z: Double) {
        self = Vector3(x: x * self.x, y: y * self.y, z: z * self.z)
    }

    /// Returns a new entity scaled by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    ///   - z: The factor to scale the entity's z dimension by.
    public func scaledBy(x: Double, y: Double, z: Double) -> Vector3 {
        Vector3(x: x * self.x, y: y * self.y, z: z * self.z)
    }

    /// Uniformly scales the entity by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    public mutating func uniformlyScale(by scale: Double) {
        self = Vector3(x: x * scale, y: y * scale, z: z * scale)
    }

    /// Returns a new entity uniformly scaled by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    public func uniformlyScaled(by scale: Double) -> Vector3 {
        Vector3(x: x * scale, y: y * scale, z: z * scale)
    }
}

extension Vector3 : Rotatable {

    /// Rotates the point by the specified quaternion.
    ///
    /// - Parameter quaternion: The quaternion representing the rotation.
    public mutating func rotate(by quaternion: Quaternion) {
        // If quaternion is identity, no change needed.
        if quaternion.isIdentity { return }

        // Compute norm and normalize quaternion to ensure a pure rotation.
        let qx = quaternion.x
        let qy = quaternion.y
        let qz = quaternion.z
        let qw = quaternion.w

        let norm = sqrt(qx * qx + qy * qy + qz * qz + qw * qw)
        guard norm.isFinite && norm != 0 else { return }

        let ix = qx / norm
        let iy = qy / norm
        let iz = qz / norm
        let iw = qw / norm

        // Apply rotation: v' = v + 2*qw*(q_vec x v) + 2*(q_vec x (q_vec x v))
        // Compute t = 2 * (q_vec x v)
        let vx = x
        let vy = y
        let vz = z

        let tx = 2.0 * (iy * vz - iz * vy)
        let ty = 2.0 * (iz * vx - ix * vz)
        let tz = 2.0 * (ix * vy - iy * vx)

        // Compute cross(q_vec, t)
        let cx = iy * tz - iz * ty
        let cy = iz * tx - ix * tz
        let cz = ix * ty - iy * tx

        // Final rotated vector
        let rx = vx + iw * tx + cx
        let ry = vy + iw * ty + cy
        let rz = vz + iw * tz + cz

        self = Vector3(x: rx, y: ry, z: rz)
    }

    /// Returns a new point rotated by the specified quaternion.
    ///
    /// - Parameter rotation: The quaternion representing the rotation.
    public func rotated(by rotation: Quaternion) -> Vector3 {
        var copy = self
        copy.rotate(by: rotation)
        return copy
    }
}

extension Vector3 : Translatable {

    /// Translates the entity by the given vector.
    /// 
    /// - Parameter vector: The vector that defines the translation.
    public mutating func translate(by vector: Vector3) {
        self = Vector3(x: x + vector.x, y: y + vector.y, z: z + vector.z)
    }

    /// Returns a new entity translated by the given vector.
    /// 
    /// - Parameter vector: The vector that defines the translation.
    public func translated(by vector: Vector3) -> Vector3 {
        var copy = self
        copy.translate(by: vector)
        return copy
    }
}
