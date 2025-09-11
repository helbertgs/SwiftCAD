import Foundation

/// A 3D projective transformation matrix.
@frozen public struct ProjectiveTransform : Codable, Equatable, Hashable, Rotatable, Translatable, Transformable, Scalable, Sendable {

    // MARK: - Creating a 3D projective transform structure

    /// Creates a projective transform from an affine transform.
    /// 
    /// - Parameter transform: The source affine transform.
    @inlinable public init(_ transform: AffineTransform) {
        self.matrix = [
            [transform[0, 0], transform[0, 1], transform[0, 2], transform[0, 3]],
            [transform[1, 0], transform[1, 1], transform[1, 2], transform[1, 3]],
            [transform[2, 0], transform[2, 1], transform[2, 2], transform[2, 3]],
            [transform[3, 0], transform[3, 1], transform[3, 2], transform[3, 3]]
        ]

        self.scaleComponent = transform.scale
        self.translation = transform.translation
        self.rotation = transform.rotation
    }

    /// Creates a projective transform from scale, rotation, and translation components.
    /// 
    /// - Parameters:
    ///   - scale: The scale component.
    ///   - rotation: The rotation component.
    ///   - translation: The translation component.
    @inlinable public init(scale: Size = .one, rotation: Quaternion = .identity, translation: Vector3 = .zero) {
        self.scaleComponent = scale
        self.translation = translation
        self.rotation = rotation
        self.matrix = [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]
    }

    public init(rotation: Quaternion) {
        let (x, y, z, w) = (rotation.x, rotation.y, rotation.z, rotation.w)
        let (xx, yy, zz) = (x * x, y * y, z * z)
        let (xy, xz, yz) = (x * y, x * z, y * z)
        let (wx, wy, wz) = (w * x, w * y, w * z)

        self.matrix = [
            [1.0 - 2.0 * (yy + zz), 2.0 * (xy - wz),        2.0 * (xz + wy),        0.0],
            [2.0 * (xy + wz),       1.0 - 2.0 * (xx + zz),  2.0 * (yz - wx),        0.0],
            [2.0 * (xz - wy),       2.0 * (yz + wx),        1.0 - 2.0 * (xx + yy),  0.0],
            [0.0,                   0.0,                    0.0,                    1.0]
        ]

        self.scaleComponent = .one
        self.translation = .zero
        self.rotation = rotation.normalized
    }

    public init(scale: Size) {
        let (x, y, z) = (scale.width, scale.height, scale.depth)
        self.matrix = [
            [x, 0, 0, 0],
            [0, y, 0, 0],
            [0, 0, z, 0],
            [0, 0, 0, 1]
        ]
        self.scaleComponent = scale
        self.translation = .zero
        self.rotation = .identity
    }

    public init(translation: Vector3) {
        let (x, y, z) = (translation.x, translation.y, translation.z)
        self.matrix = [
            [1, 0, 0, x],
            [0, 1, 0, y],
            [0, 0, 1, z],
            [0, 0, 0, 1]
        ]
        self.scaleComponent = .one
        self.translation = translation
        self.rotation = .identity
    }

    // MARK: - Inspecting a 3D projective transform’s properties

    /// The projective transform’s inverse.
    public var inverse: ProjectiveTransform? {
        let affine = AffineTransform(matrix4x4: matrix)
        guard let invAffine = affine.inverse else { return nil }
        return ProjectiveTransform(invAffine)
    }

    /// The scale component of the projective transform.
    public var scaleComponent: Size

    /// The translation component of the projective transform.
    public var translation: Vector3

    /// The projective transform’s underlying matrix.
    public var matrix: [[Double]]

    // MARK: - Transforming a 3D projective transform structure

    /// Flips a projective transform along the specified axis.
    /// 
    /// - Parameter axis: An axis structure that specifies the flip axis.
    public mutating func flip(along axis: Axis) {
        self = flipped(along: axis)
    }

    /// Returns a projective transform flipped along the specified axis.
    /// 
    /// - Parameter axis: An axis structure that specifies the flip axis.
    /// - Returns: A new projective transform that is flipped along the specified axis.
    public func flipped(along axis: Axis) -> ProjectiveTransform {
        fatalError("not implemented")
    }

    // MARK: - Decomposing a 3D projective transform

    /// The projective transform’s rotation.
    public var rotation: Quaternion?

    // MARK: - Checking characteristics

    /// Determines whether the projective transform is uniform (equal scaling in all dimensions).
    /// 
    /// - Parameter overDimensions: The dimensions to check for uniformity.
    /// - Returns: A Boolean value indicating whether the projective transform is uniform.
    public func isUniform(overDimensions: Dimension) -> Bool {
        return switch overDimensions {
        case [.x, .y]: scaleComponent.width == scaleComponent.height
        case [.x, .z]: scaleComponent.width == scaleComponent.depth
        case [.y, .z]: scaleComponent.height == scaleComponent.depth
        case .all: scaleComponent.width == scaleComponent.height && scaleComponent.height == scaleComponent.depth
        default: false
        }
    }

    /// A Boolean value indicating whether the projective transform is affine.
    public var isAffine: Bool {
        return true
    }

    /// A Boolean value indicating whether the projective transform is invertible.
    public var isInvertible: Bool {
        return true
    }

    // MARK: - Comparing values

    public func isApproximatelyEqual(to other: ProjectiveTransform, tolerance: Double) -> Bool {
        guard matrix.count == other.matrix.count else { return false }
        for (r, row) in matrix.enumerated() {
            for (c, v) in row.enumerated() {
                if abs(v - other.matrix[r][c]) > tolerance { return false }
            }
        }
        return true
    }

    // MARK: - Rotatable Conformance

    /// Rotates the projective transform by the specified quaternion.
    /// 
    /// - Parameter quaternion: The quaternion representing the rotation.
    public mutating func rotate(by quaternion: Quaternion) {
        var affine = AffineTransform(matrix4x4: matrix)
        affine.rotate(by: quaternion)
        self = ProjectiveTransform(affine)
    }

    /// Returns a new projective transform rotated by the specified quaternion.
    /// 
    /// - Parameter rotation: The quaternion representing the rotation.
    /// - Returns: A new projective transform rotated by the specified quaternion.
    public func rotated(by rotation: Quaternion) -> ProjectiveTransform {
        var p = self
        p.rotate(by: rotation)
        return p
    }

    // MARK: - Translatable Conformance

    /// Translates the projective transform by the specified 3D vector.
    /// 
    /// - Parameter vector: The vector representing the translation.
    public mutating func translate(by vector: Vector3) {
        var affine = AffineTransform(matrix4x4: matrix)
        affine.translate(by: vector)
        self = ProjectiveTransform(affine)
    }

    /// Returns a new projective transform translated by the specified 3D vector.
    /// 
    /// - Parameter vector: The vector representing the translation.
    /// - Returns: A new projective transform translated by the specified 3D vector.
    public func translated(by vector: Vector3) -> ProjectiveTransform {
        var p = self
        p.translate(by: vector)
        return p
    }

    // MARK: - Scalable Conformance

    /// Scales the projective transform by the specified size.
    /// 
    /// - Parameter size: The size representing the scaling factors.
    public mutating func scale(by size: Size) {
        var affine = AffineTransform(matrix4x4: matrix)
        affine.scale(by: size)
        self = ProjectiveTransform(affine)
    }

    /// Scales the projective transform by the specified factors along each axis.
    /// 
    /// - Parameters:
    ///   - x: The scaling factor along the x-axis.
    ///   - y: The scaling factor along the y-axis.
    ///   - z: The scaling factor along the z-axis.
    public mutating func scaleBy(x: Double, y: Double, z: Double) {
        var affine = AffineTransform(matrix4x4: matrix)
        affine.scaleBy(x: x, y: y, z: z)
        self = ProjectiveTransform(affine)
    }

    /// Returns a new projective transform scaled by the specified factors along each axis.
    /// 
    /// - Parameters:
    ///   - x: The scaling factor along the x-axis.
    ///   - y: The scaling factor along the y-axis.
    ///   - z: The scaling factor along the z-axis.
    /// - Returns: A new projective transform scaled by the specified factors along each axis.
    public func scaledBy(x: Double, y: Double, z: Double) -> ProjectiveTransform {
        var p = self
        p.scaleBy(x: x, y: y, z: z)
        return p
    }

    /// Scales the projective transform uniformly by the specified factor.
    /// 
    /// - Parameter scale: The uniform scaling factor.
    public mutating func uniformlyScale(by scale: Double) {
        scaleBy(x: scale, y: scale, z: scale)
    }

    /// Returns a new projective transform uniformly scaled by the specified factor.
    /// 
    /// - Parameter scale: The uniform scaling factor.
    /// - Returns: A new projective transform uniformly scaled by the specified factor.
    public func uniformlyScaled(by scale: Double) -> ProjectiveTransform {
        var p = self
        p.uniformlyScale(by: scale)
        return p
    }

    // MARK: - Transformable Conformance

    /// A Boolean value indicating whether the projective transform is the identity transform.
    public var isIdentity: Bool {
        if translation != .zero { return false }
        if scaleComponent != .one { return false }
        if let r = rotation, r != .identity { return false }

        return matrix == [
            [1.0,0.0,0.0,0.0],
            [0.0,1.0,0.0,0.0],
            [0.0,0.0,1.0,0.0],
            [0.0,0.0,0.0,1.0]
        ]
    }

    /// A Boolean value indicating whether the projective transform is rectilinear (no rotation or skew).
    public var isRectilinear: Bool {
        fatalError("not implemented")
    }

    /// A Boolean value indicating whether the projective transform is a translation only (no rotation or scaling).
    public var isTranslation: Bool {
        return rotation == nil || rotation == .identity ? (scaleComponent == .one && matrix[0][0] == 1 && matrix[1][1] == 1 && matrix[2][2] == 1) : false
    }

    /// A Boolean value indicating whether the projective transform is a uniform scale (equal scaling in all dimensions).
    public var isUniform: Bool {
        isUniform(overDimensions: .all)
    }

    /// Concatenates the projective transform with another projective transform.
    /// 
    /// - Parameter transform: The projective transform to concatenate with.
    /// - Returns: A new projective transform that is the result of concatenating the two transforms.
    public func concatenating(_ transform: ProjectiveTransform) -> ProjectiveTransform {
        // multiply matrices (row-major)
        let a = AffineTransform(matrix4x4: self.matrix)
        let b = AffineTransform(matrix4x4: transform.matrix)
        let product = a * b
        return ProjectiveTransform(product)
    }

    // MARK: - Equatable Conformance

    /// Checks if two projective transforms are equal.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand side projective transform.
    ///   - rhs: The right-hand side projective transform.
    /// - Returns: A Boolean value indicating whether the two projective transforms are equal.
    public static func == (lhs: ProjectiveTransform, rhs: ProjectiveTransform) -> Bool {
        lhs.scaleComponent == rhs.scaleComponent &&
        lhs.translation == rhs.translation &&
        lhs.rotation == rhs.rotation &&
        lhs.matrix == rhs.matrix
    }
}
