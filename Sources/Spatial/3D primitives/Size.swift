import Foundation

/// A size that describes width, height, and depth in a 3D coordinate system.
@frozen public struct Size : Codable, Equatable, Hashable, Sendable {

    // MARK: - Inspecting a 3D size’s properties

    /// The width value.
    public let width: Double

    /// The height value.
    public let height: Double

    /// The depth value.
    public let depth: Double

    // MARK: - 3D size constants

    /// Returns a size with all dimensions set to zero.
    public static var zero: Size {
        Size(width: 0, height: 0, depth: 0)
    }

    /// Returns a size with all dimensions set to one.
    public static var one: Size {
        Size(width: 1, height: 1, depth: 1)
    }

    // MARK: - Creating a 3D size structure

    /// Creates a new size with the given dimensions.
    /// 
    /// - Parameters:
    ///   - width: The width of the size.
    ///   - height: The height of the size.
    ///   - depth: The depth of the size.
    public init(width: Double = 0, height: Double = 0, depth: Double = 0) {
        self.width = width
        self.height = height
        self.depth = depth
    }

    /// Creates a size structure from the specified floating-point values.
    /// 
    /// - Parameters:
    ///   - width: A floating-point value that specifies the width.
    ///   - height: A floating-point value that specifies the height.
    ///   - depth: A floating-point value that specifies the depth.
    public init<T>(width: T, height: T, depth: T) where T : BinaryFloatingPoint {
        self.width = Double(width)
        self.height = Double(height)
        self.depth = Double(depth)
    }

    /// Creates a size structure from the specified Spatial vector.
    /// 
    /// - Parameter vector: A vector that specifies the dimensions.
    public init(_ xyz: Vector3) {
        self.width = xyz.x
        self.height = xyz.y
        self.depth = xyz.z
    }
}

extension Size : AdditiveArithmetic {

    // MARK: - Applying arithmetic operations

    /// Multiplies a size by a scalar value.
    /// 
    /// - Parameters:
    ///   - lhs: The size to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// - Returns: A new size representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func * (lhs: Size, rhs: Double) -> Size {
        Size(width: lhs.width * rhs, height: lhs.height * rhs, depth: lhs.depth * rhs)
    }

    /// Multiplies a size by a scalar value in place.
    /// 
    /// - Parameters:
    ///   - lhs: The size to multiply.
    ///   - rhs: The scalar value to multiply by.
    /// /// - Complexity: O(1)
    @inlinable public static func *= (lhs: inout Size, rhs: Double) {
        lhs = lhs * rhs
    }

    /// Returns a size that’s the element-wise sum of two sizes.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand-side value.
    ///   - rhs: The right-hand-side value.
    /// - Returns: A new size representing the element-wise sum of the two sizes.
    /// - Complexity: O(1)
    @inlinable public static func + (lhs: Size, rhs: Size) -> Size {
        Size(width: lhs.width + rhs.width, height: lhs.height + rhs.height, depth: lhs.depth + rhs.depth)
    }

    /// Returns a size that’s the element-wise sum of two sizes.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand-side value.
    ///   - rhs: The right-hand-side value.
    /// - Returns: A new size representing the element-wise sum of the two sizes.
    /// - Complexity: O(1)
    @inlinable public static func + (lhs: Size, rhs: Vector3) -> Size {
        Size(width: lhs.width + rhs.x, height: lhs.height + rhs.y, depth: lhs.depth + rhs.z)
    }

    /// Adds two sizes together.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand-side value.
    ///   - rhs: The right-hand-side value.
    /// - Complexity: O(1)
    @inlinable public static func += (lhs: inout Size, rhs: Size) {
        lhs = lhs + rhs
    }

    /// Adds a vector to a size.
    /// 
    /// - Parameters:
    ///   - lhs: The size to add to.
    ///   - rhs: The vector to add.
    /// - Complexity: O(1)
    @inlinable public static func += (lhs: inout Size, rhs: Vector3) {
        lhs = Size(width: lhs.width + rhs.x, height: lhs.height + rhs.y, depth: lhs.depth + rhs.z)
    }

    /// Returns a size that’s the element-wise difference of two sizes.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand-side value.
    ///   - rhs: The right-hand-side value.
    /// - Returns: A new size representing the element-wise difference of the two sizes.
    /// - Complexity: O(1)
    @inlinable public static func - (lhs: Size, rhs: Size) -> Size {
        Size(width: lhs.width - rhs.width, height: lhs.height - rhs.height, depth: lhs.depth - rhs.depth)
    }

    /// Subtracts two sizes.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand-side value.
    ///   - rhs: The right-hand-side value.
    /// - Complexity: O(1)
    @inlinable public static func -= (lhs: inout Size, rhs: Size) {
        lhs = lhs - rhs
    }

    /// Subtracts a vector from a size.
    /// 
    /// - Parameters:
    ///   - lhs: The size to subtract from.
    ///   - rhs: The vector to subtract.
    /// - Returns: A new size representing the element-wise difference of the two sizes.
    /// - Complexity: O(1)
    @inlinable public static func - (lhs: Size, rhs: Vector3) -> Size {
        Size(width: lhs.width - rhs.x, height: lhs.height - rhs.y, depth: lhs.depth - rhs.z)
    }

    /// Subtracts a vector from a size.
    /// 
    /// - Parameters:
    ///   - lhs: The size to subtract from.
    ///   - rhs: The vector to subtract.
    /// - Complexity: O(1)
    @inlinable public static func -= (lhs: inout Size, rhs: Vector3) {
        lhs = Size(width: lhs.width - rhs.x, height: lhs.height - rhs.y, depth: lhs.depth - rhs.z)
    }

    /// Divides a size by a scalar value.
    /// 
    /// - Parameters:
    ///   - lhs: The size to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Returns: A new size representing the scaled dimensions.
    /// - Complexity: O(1)
    @inlinable public static func / (lhs: Size, rhs: Double) -> Size {
        Size(width: lhs.width / rhs, height: lhs.height / rhs, depth: lhs.depth / rhs)
    }

    /// Divides a size by a scalar value in place.
    /// 
    /// - Parameters:
    ///   - lhs: The size to divide.
    ///   - rhs: The scalar value to divide by.
    /// - Complexity: O(1)
    @inlinable public static func /= (lhs: inout Size, rhs: Double) {
        lhs = lhs / rhs
    }
}

extension Size : Primitive {

    /// Returns the entity that results from applying an affine transform.
    ///
    /// - Parameter transform: The affine transform that the function applies to the Spatial primitive.
    public func applying(_ transform: AffineTransform) -> Size {
        .zero
    }

    /// Returns the entity that results from applying a projective transform.
    ///
    /// - Parameter transform: The projective transform that the function applies to the Spatial primitive.
    public func applying(_ transform: ProjectiveTransform) -> Size {
        .zero
    }

    /// Returns a Boolean value that indicates whether the size is finite.
    public var isFinite: Bool {
        self == .infinity
    }
    
    /// Returns a Boolean value that indicates whether the size contains any NaN values.
    public var isNaN: Bool {
        self.width.isNaN || self.height.isNaN || self.depth.isNaN
    }
    
    /// Returns a Boolean value that indicates whether the size is zero.
    public var isZero: Bool {
        self.width == 0 && self.height == 0 && self.depth == 0
    }

    /// A size with infinite values.
    public static var infinity: Size {
        .init(width: .infinity, height: .infinity, depth: .infinity)
    }
}
