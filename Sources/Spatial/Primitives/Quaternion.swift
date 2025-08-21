import Foundation

/// A structure representing a quaternion for 3D rotations.
@frozen public struct Quaternion {

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
}

extension Quaternion : Primitive {

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