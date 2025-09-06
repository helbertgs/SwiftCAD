import Foundation

/// A structure representing a quaternion for 3D rotations.
@frozen public struct Quaternion : Codable, Equatable, Hashable, Sendable {

    // MARK: - Inspecting a quaternion's properties

    /// The x component of the quaternion.
    public let x: Double

    /// The y component of the quaternion.
    public let y: Double

    /// The z component of the quaternion.
    public let z: Double

    /// The w component of the quaternion.
    public let w: Double

    // MARK: - Checking characteristics

    /// A Boolean value indicating whether the quaternion is the identity quaternion.
    public var isIdentity: Bool {
        x == 0 && y == 0 && z == 0 && w == 1
    }

    /// A quaternion representing the identity rotation.
    public static var identity: Quaternion {
        Quaternion(x: 0, y: 0, z: 0, w: 1)
    }

    // MARK: - Creating a quaternion

    /// Initializes a quaternion with the given components.
    /// 
    /// - Parameters:
    ///   - x: The x component.
    ///   - y: The y component.
    ///   - z: The z component.
    ///   - w: The w component.
    @inlinable public init(x: Double, y: Double, z: Double, w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    /// Creates a new 3D vector from the specified floating-point values.
    /// 
    /// - Parameters:
    ///   - x: A floating-point value that specifies the x-coordinate.
    ///   - y: A floating-point value that specifies the y-coordinate.
    ///   - z: A floating-point value that specifies the z-coordinate.
    ///   - w: A floating-point value that specifies the w-coordinate.
    @inlinable public init<T>(x: T, y: T, z: T, w: T) where T : BinaryFloatingPoint {
        self.x = Double(x)
        self.y = Double(y)
        self.z = Double(z)
        self.w = Double(w)
    }

    /// Creates a quaternion representing a rotation around the given axis by the given angle.
    /// 
    /// - Parameters:
    ///   - axis: Rotation axis (does not need to be normalized).
    ///   - angle: The rotation angle.
    @inlinable public init(axis: Vector3, angle: Angle) {
        let half = angle.radians / 2.0
        let s = Foundation.sin(half)

        let lx = axis.x
        let ly = axis.y
        let lz = axis.z
        let len = Foundation.sqrt(lx * lx + ly * ly + lz * lz)
        guard len.isFinite && len != 0 else {
            self = Quaternion.identity
            return
        }

        let nx = lx / len
        let ny = ly / len
        let nz = lz / len

        self.init(x: nx * s, y: ny * s, z: nz * s, w: Foundation.cos(half))
    }

    /// Convenience initializer accepting radians directly.
    /// 
    /// - Parameters:
    ///   - axis: The rotation axis (does not need to be normalized).
    ///   - radians: The rotation angle in radians.
    @inlinable public init(axis: Vector3, radians: Double) {
        self.init(axis: axis, angle: Angle.radians(radians))
    }

    /// Convenience initializer accepting radians directly.
    /// 
    /// - Parameters:
    ///   - axis: The rotation axis (does not need to be normalized).
    ///   - degrees: The rotation angle in degrees.
    @inlinable public init(axis: Vector3, degrees: Double) {
        self.init(axis: axis, angle: Angle.degrees(degrees))
    }

    /// Returns the conjugate of the quaternion.
    /// 
    /// - Complexity: O(1)
    @inlinable public func conjugated() -> Quaternion {
        Quaternion(x: -x, y: -y, z: -z, w: w)
    }

    /// Returns the inverse of the quaternion.
    /// For unit quaternions the inverse equals the conjugate.
    /// 
    /// - Complexity: O(1)
    @inlinable public func inverted() -> Quaternion {
        let n = x * x + y * y + z * z + w * w
        guard n.isFinite && n != 0 else { return Quaternion.zero }
        let c = conjugated()
        return Quaternion(x: c.x / n, y: c.y / n, z: c.z / n, w: c.w / n)
    }

    /// Returns a normalized quaternion (unit length). If zero, returns identity.
    public var normalized: Quaternion {
        let n = Foundation.sqrt(x * x + y * y + z * z + w * w)
        guard n.isFinite && n != 0 else { return Quaternion.identity }

        return Quaternion(x: x / n, y: y / n, z: z / n, w: w / n)
    }
}

extension Quaternion : Primitive {

    /// Returns the entity that results from applying an affine transform.
    ///
    /// - Parameter transform: The affine transform that the function applies to the Spatial primitive.
    public func applying(_ transform: AffineTransform) -> Quaternion {
        .zero
    }

    /// Returns the entity that results from applying a projective transform.
    ///
    /// - Parameter transform: The projective transform that the function applies to the Spatial primitive.
    public func applying(_ transform: ProjectiveTransform) -> Quaternion {
        .zero
    }

    /// Returns a Boolean value that indicates whether the quaternion is finite.
    public var isFinite: Bool {
        x.isFinite && y.isFinite && z.isFinite && w.isFinite
    }

    /// Returns a Boolean value that indicates whether the quaternion contains any NaN values.
    public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }

    /// Returns a Boolean value that indicates whether the quaternion is zero.
    public var isZero: Bool {
        x == 0 && y == 0 && z == 0 && w == 0
    }

    /// A quaternion with infinite values.
    public static var infinity: Quaternion {
        Quaternion(x: Double.infinity, y: Double.infinity, z: Double.infinity, w: Double.infinity)
    }

    /// A quaternion with zero values.
    public static var zero: Quaternion {
        Quaternion(x: 0, y: 0, z: 0, w: 0)
    }
}
