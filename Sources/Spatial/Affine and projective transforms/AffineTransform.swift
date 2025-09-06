import Foundation

/// A 3D affine transformation matrix.
public struct AffineTransform : Sendable {

    // MARK: - Instance Properties

    /// The entry at position [1,1] in the matrix.
    @usableFromInline
    var m11: Double = 0.0

    /// The entry at position [1,2] in the matrix.
    @usableFromInline
    var m12: Double = 0.0

    /// The entry at position [1,3] in the matrix.
    @usableFromInline
    var m13: Double = 0.0

    /// The entry at position [1,4] in the matrix.
    @usableFromInline
    var m14: Double = 0.0

    /// The entry at position [2,1] in the matrix.
    @usableFromInline
    var m21: Double = 0.0

    /// The entry at position [2,2] in the matrix.
    @usableFromInline
    var m22: Double = 0.0

    /// The entry at position [2,3] in the matrix.
    @usableFromInline
    var m23: Double = 0.0

    /// The entry at position [2,4] in the matrix.
    @usableFromInline
    var m24: Double = 0.0

    /// The entry at position [3,1] in the matrix.
    @usableFromInline
    var m31: Double = 0.0

    /// The entry at position [3,2] in the matrix.
    @usableFromInline
    var m32: Double = 0.0

    /// The entry at position [3,3] in the matrix.
    @usableFromInline
    var m33: Double = 0.0

    /// The entry at position [3,4] in the matrix.
    @usableFromInline
    var m34: Double = 0.0

    /// The entry at position [4,1] in the matrix.
    @usableFromInline
    var m41: Double = 0.0

    /// The entry at position [4,2] in the matrix.
    @usableFromInline
    var m42: Double = 0.0

    /// The entry at position [4,3] in the matrix.
    @usableFromInline
    var m43: Double = 0.0

    /// The entry at position [4,4] in the matrix.
    @usableFromInline
    var m44: Double = 0.0

    // MARK: - Type Properties

    /// The identity transform.
    /// - Returns: A new affine transform that is the identity transform.
    /// - Complexity: O(1)
    public static var identity: AffineTransform {
        var t = AffineTransform()

        (t.m11, t.m12, t.m13, t.m14) = (1, 0, 0, 0)
        (t.m21, t.m22, t.m23, t.m24) = (0, 1, 0, 0)
        (t.m31, t.m32, t.m33, t.m34) = (0, 0, 1, 0)
        (t.m41, t.m42, t.m43, t.m44) = (0, 0, 0, 1)

        return t
    }

    /// Transposes the affine transform.
    /// - Returns: A new affine transform that is the transpose of the original.
    /// - Complexity: O(1)
    public var transposed: AffineTransform {
        var t = AffineTransform()
        
        (t.m11, t.m12, t.m13, t.m14) = (m11, m21, m31, m41)
        (t.m21, t.m22, t.m23, t.m24) = (m12, m22, m32, m42)
        (t.m31, t.m32, t.m33, t.m34) = (m13, m23, m33, m43)
        (t.m41, t.m42, t.m43, t.m44) = (m14, m24, m34, m44)
        
        return t
    }

    // MARK: - Instance Properties

    /// The columns of the underlying matrix.
    public var columns: (Vector3, Vector3, Vector3, Vector3) {
        let col1 = Vector3(x: m11, y: m21, z: m31)
        let col2 = Vector3(x: m12, y: m22, z: m32)
        let col3 = Vector3(x: m13, y: m23, z: m33)
        let col4 = Vector3(x: m14, y: m24, z: m34)

        return (col1, col2, col3, col4)
    }

    // MARK: - Creating a 3D affine transform structure

    /// Creates an affine transform.
    public init() {
        (m11, m12, m13, m14) = (0, 0, 0, 0)
        (m21, m22, m23, m24) = (0, 0, 0, 0)
        (m31, m32, m33, m34) = (0, 0, 0, 0)
        (m41, m42, m43, m44) = (0, 0, 0, 0)
    }

    /// Creates an affine transform from a 4x4 matrix.
    /// 
    /// - Parameter m: A 4x4 matrix represented as a 2D array.
    public init(matrix4x4 m: [[Double]]) {
        precondition(m.count == 4 && m.allSatisfy { $0.count == 4 }, "Matrix must be 4x4")
        (m11, m12, m13, m14) = (m[0][0], m[0][1], m[0][2], m[0][3])
        (m21, m22, m23, m24) = (m[1][0], m[1][1], m[1][2], m[1][3])
        (m31, m32, m33, m34) = (m[2][0], m[2][1], m[2][2], m[2][3])
        (m41, m42, m43, m44) = (m[3][0], m[3][1], m[3][2], m[3][3])
    }

    /// Creates an affine transform from a 4x3 matrix.
    /// 
    /// - Parameter m: A 4x3 matrix represented as a 2D array.
    public init(matrix4x3 m: [[Double]]) {
        precondition(m.count == 4 && m.allSatisfy { $0.count == 3 }, "Matrix must be 4x3")
        (m11, m12, m13, m14) = (m[0][0], m[0][1], m[0][2], 0)
        (m21, m22, m23, m24) = (m[1][0], m[1][1], m[1][2], 0)
        (m31, m32, m33, m34) = (m[2][0], m[2][1], m[2][2], 0)
        (m41, m42, m43, m44) = (m[3][0], m[3][1], m[3][2], 1)
    }

    /// Creates an affine transform from the specified scale, rotate, and translate transforms.
    /// 
    /// - Parameters:
    ///   - scale: A size structure that specifies the scale.
    ///   - rotation: A rotation structure that specifies the rotation.
    ///   - translation: A vector that specifies the translation.
    public init(scale: Size = .one, rotation: Quaternion = .zero, translation: Vector3 = .zero) {
        fatalError()
    }

    /// Creates an affine transform by truncating a projective transform.
    /// 
    /// - Parameter transform: The source projective transform.
    public init(truncating transform: ProjectiveTransform) {
        fatalError()
    }

    // MARK: - Transforming a 3D affine transform structure

    /// The inverse of the affine transform, if it exists.
    /// 
    /// - Parameters:
    ///   - from: The source affine transform.
    ///   - to: The destination affine transform.
    /// - Returns: The transformed affine transform, or nil if the transformation could not be performed.
    public func changeBasis(from: AffineTransform = .identity, to: AffineTransform) -> AffineTransform? {
        fatalError()
    }

    /// Flips an affine transform along the specified axis.
    /// 
    /// - Parameter axis: An axis structure that specifies the flip axis.
    public mutating func flip(along axis: Axis) {
        switch axis {
        case .x:
            m11 = -m11
            m12 = -m12
            m13 = -m13
            m14 = -m14
        case .y:
            m21 = -m21
            m22 = -m22
            m23 = -m23
            m24 = -m24
        case .z:
            m31 = -m31
            m32 = -m32
            m33 = -m33
            m34 = -m34
        default:
            return
        }
    }

    /// Returns a new affine transform flipped along the specified axis.
    /// 
    /// - Parameter axis: An axis structure that specifies the flip axis.
    /// - Returns: A new affine transform that is flipped along the specified axis.
    public func flipped(along axis: Axis) -> AffineTransform {
        var t = self
        t.flip(along: axis)
        return t
    }

    /// The inverse of the affine transform, if it exists.
    public var inverse: AffineTransform? {
        let determinant = m11 * (m22 * m33 - m23 * m32) -
                          m12 * (m21 * m33 - m23 * m31) +
                          m13 * (m21 * m32 - m22 * m31)

        guard determinant != 0 else { return nil }

        var inv = AffineTransform()

        inv.m11 =  (m22 * m33 - m23 * m32) / determinant
        inv.m12 = -(m12 * m33 - m13 * m32) / determinant
        inv.m13 =  (m12 * m23 - m13 * m22) / determinant
        inv.m14 = 0

        inv.m21 = -(m21 * m33 - m23 * m31) / determinant
        inv.m22 =  (m11 * m33 - m13 * m31) / determinant
        inv.m23 = -(m11 * m23 - m13 * m21) / determinant
        inv.m24 = 0

        inv.m31 =  (m21 * m32 - m22 * m31) / determinant
        inv.m32 = -(m11 * m32 - m12 * m31) / determinant
        inv.m33 =  (m11 * m22 - m12 * m21) / determinant
        inv.m34 = 0

        inv.m41 = -(inv.m11 * m41 + inv.m21 * m42 + inv.m31 * m43)
        inv.m42 = -(inv.m12 * m41 + inv.m22 * m42 + inv.m32 * m43)
        inv.m43 = -(inv.m13 * m41 + inv.m23 * m42 + inv.m33 * m43)
        inv.m44 = 1

        return inv
    }

    // MARK: - Decomposing a 3D affine transform

    /// The affine transform’s rotation.
    public var rotation: Quaternion? {
        .init(x: m11, y: m22, z: m33, w: m44)
    }

    /// The affine transform’s scale.
    public var scale: Size {
        .init(width: 0, height: 0, depth: 0)
    }

    /// The translation component of the affine transform.
    public var translation: Vector3 {
        .init(x: m41, y: m42, z: m43)
    }

    // MARK: - Subscript

    /// Accesses the specified row and column.
    /// 
    /// - Parameters:
    ///   - col: The column index (0 to 3).
    ///   - row: The row index (0 to 3).
    /// - Returns: The value at the specified row and column.
    /// - Complexity: O(1)
    public subscript(col: Int, row: Int) -> Double {
        get {
            switch col {
            case 0:
                switch row {
                case 0: return m11
                case 1: return m12
                case 2: return m13
                case 3: return m14
                default: fatalError("Index outside of bounds")
                }
            case 1:
                switch row {
                case 0: return m21
                case 1: return m22
                case 2: return m23
                case 3: return m24
                default: fatalError("Index outside of bounds")
                }
            case 2:
                switch row {
                case 0: return m31
                case 1: return m32
                case 2: return m33
                case 3: return m34
                default: fatalError("Index outside of bounds")
                }
            case 3:
                switch row {
                case 0: return m41
                case 1: return m42
                case 2: return m43
                case 3: return m44
                default: fatalError("Index outside of bounds")
                }
            default: fatalError("Index outside of bounds")
            }
        }
        
        set {
            switch col {
            case 0:
                switch row {
                case 0: m11 = newValue
                case 1: m12 = newValue
                case 2: m13 = newValue
                case 3: m14 = newValue
                default: fatalError("Index outside of bounds")
                }
            case 1:
                switch row {
                case 0: m21 = newValue
                case 1: m22 = newValue
                case 2: m23 = newValue
                case 3: m24 = newValue
                default: fatalError("Index outside of bounds")
                }
            case 2:
                switch row {
                case 0: m31 = newValue
                case 1: m32 = newValue
                case 2: m33 = newValue
                case 3: m34 = newValue
                default: fatalError("Index outside of bounds")
                }
            case 3:
                switch row {
                case 0: m41 = newValue
                case 1: m42 = newValue
                case 2: m43 = newValue
                case 3: m44 = newValue
                default: fatalError("Index outside of bounds")
                }
            default: fatalError("Index outside of bounds")
            }
        }
    }

    // MARK: - Checking characteristics

    /// Returns a Boolean value that indicates whether the transform is invertible.
    public var isInvertible: Bool {
        let determinant = m11 * (m22 * m33 - m23 * m32) -
                          m12 * (m21 * m33 - m23 * m31) +
                          m13 * (m21 * m32 - m22 * m31)
        return determinant != 0
    }

    /// Indicates whether the scale is uniform over the specified dimensions.
    /// 
    /// - Parameter overDimensions: The dimensions to check for uniform scaling.
    /// - Returns: A Boolean value indicating whether the scale is uniform.
    public func isUniform(overDimensions: Dimension) -> Bool {
        fatalError()
    }
}

extension AffineTransform: Equatable {

    /// Returns a Boolean value indicating whether two affine transforms are equal.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand side affine transform.
    ///   - rhs: The right-hand side affine transform.
    /// - Returns: A Boolean value indicating whether the two transforms are equal.
    public static func ==(lhs: AffineTransform, rhs: AffineTransform) -> Bool {
        lhs.rotation == rhs.rotation &&
        lhs.scale == rhs.scale &&
        lhs.translation == rhs.translation
    }
}

extension AffineTransform : Hashable {

    /// Hashes the essential components of the affine transform by feeding them into the given hasher.
    /// 
    /// - Parameter hasher: The hasher to feed the components into.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rotation)
        hasher.combine(scale)
        hasher.combine(translation)
    }
}

extension AffineTransform : CustomStringConvertible {

    /// A textual representation of the affine transform.
    public var description: String {
        """
        | \(m11) \(m12) \(m13) \(m14) |
        | \(m21) \(m22) \(m23) \(m24) |
        | \(m31) \(m32) \(m33) \(m34) |
        | \(m41) \(m42) \(m43) \(m44) |
        """
    }
}

extension AffineTransform : Rotatable {

    /// Rotates the affine transform by the specified quaternion.
    /// 
    /// - Parameter quaternion: The quaternion representing the rotation.
    public mutating func rotate(by quaternion: Quaternion) {
        let (x, y, z, w) = (quaternion.x, quaternion.y, quaternion.z, quaternion.w)
        let (xx, yy, zz) = (x * x, y * y, z * z)
        let (xy, xz, yz) = (x * y, x * z, y * z)
        let (wx, wy, wz) = (w * x, w * y, w * z)

        let rotationMatrix = AffineTransform(matrix4x4: [
            [1.0 - 2.0 * (yy + zz), 2.0 * (xy - wz),        2.0 * (xz + wy),        0.0],
            [2.0 * (xy + wz),       1.0 - 2.0 * (xx + zz),  2.0 * (yz - wx),        0.0],
            [2.0 * (xz - wy),       2.0 * (yz + wx),        1.0 - 2.0 * (xx + yy),  0.0],
            [0.0,                   0.0,                    0.0,                    0.0]
        ])

        self = self.concatenating(rotationMatrix)
    }

    /// Rotates the affine transform by the specified angle.
    /// 
    /// - Parameter angle: The angle in radians to rotate the transform.
    public mutating func rotate(by angle: Double) {
        let cos = cos(angle)
        let sin = sin(angle)
        let m11 = self.m11 * cos - self.m21 * sin
        let m12 = self.m12 * cos - self.m22 * sin
        let m21 = self.m11 * sin + self.m21 * cos
        let m22 = self.m12 * sin + self.m22 * cos
        self.m11 = m11
        self.m12 = m12
        self.m21 = m21
        self.m22 = m22
    }

    /// Returns a new affine transform rotated by the specified quaternion.
    /// 
    /// - Parameter rotation: The quaternion representing the rotation.
    /// - Returns: A new affine transform rotated by the specified quaternion.
    public func rotated(by rotation: Quaternion) -> AffineTransform {
        var transform = self
        transform.rotate(by: rotation)
        return transform
    }
}

extension AffineTransform : Scalable {

    /// Scales the affine transform by the specified size.
    /// 
    /// - Parameter size: The size to scale the transform by.
    public mutating func scale(by size: Size) {
        self.scaleBy(x: size.width, y: size.height)
    }
    
    /// Returns a new affine transform scaled by the specified size.
    /// 
    /// - Parameters:
    ///   - x: The scaling factor along the x-axis.
    ///   - y: The scaling factor along the y-axis.
    public mutating func scaleBy(x: Double, y: Double) {
        self.m11 *= x
        self.m22 *= y
    }
    
    /// Returns a new affine transform scaled by the specified size.
    /// 
    /// - Parameter size: The size to scale the transform by.
    /// - Returns: A new affine transform that is scaled by the specified size.
    public func scaledBy(x: Double, y: Double) -> AffineTransform {
        var transform = self
        transform.scaleBy(x: x, y: y)
        return transform
    }
    
    /// Scales the affine transform by the specified factors.
    /// 
    /// - Parameters:
    ///   - x: The scaling factor along the x-axis.
    ///   - y: The scaling factor along the y-axis.
    ///   - z: The scaling factor along the z-axis.
    public mutating func scaleBy(x: Double, y: Double, z: Double) {
        self.m11 *= x
        self.m22 *= y
        self.m33 *= z
    }

    /// Returns a new affine transform scaled by the specified factors.
    /// 
    /// - Parameters:
    ///   - x: The scaling factor along the x-axis.
    ///   - y: The scaling factor along the y-axis.
    ///   - z: The scaling factor along the z-axis.
    /// - Returns: A new affine transform that is scaled by the specified factors.
    public func scaledBy(x: Double = 1, y: Double = 1, z: Double = 1) -> AffineTransform {
        var t = self
        t.m11 *= x
        t.m22 *= y
        t.m33 *= z

        return t
    }
    
    /// Returns a new affine transform scaled by the specified factors.
    /// 
    /// - Parameter scale: The scaling factor to apply uniformly along all axes.
    public mutating func uniformlyScale(by scale: Double) {
        self.scaleBy(x: scale, y: scale, z: scale)
    }
    
    /// Returns a new affine transform scaled uniformly by the specified factor.
    /// 
    /// - Parameter scale: The scaling factor to apply uniformly along all axes.
    /// - Returns: A new affine transform that is scaled uniformly by the specified factor.
    public func uniformlyScaled(by scale: Double) -> AffineTransform {
        var transform = self
        transform.uniformlyScale(by: scale)
        return transform
    }
}

extension AffineTransform : Translatable {

    /// Translates the affine transform by the specified vector.
    /// 
    /// - Parameter vector: The vector to translate the transform by.
    public mutating func translate(by vector: Vector2) {
        self.m41 += vector.x
        self.m42 += vector.y
    }

    /// Returns a new affine transform translated by the specified vector.
    /// 
    /// - Parameter vector: The vector to translate the transform by.
    /// - Returns: A new affine transform that is translated by the specified vector.
    public func translated(by vector: Vector2) -> AffineTransform {
        var transform = self
        transform.translate(by: vector)
        return transform
    }

    /// Translates the affine transform by the specified vector.
    /// 
    /// - Parameter vector: The vector to translate the transform by.
    public mutating func translate(by vector: Vector3) {
        self.m41 += vector.x
        self.m42 += vector.y
        self.m43 += vector.z
    }

    /// Returns a new affine transform translated by the specified vector.
    /// 
    /// - Parameter vector: The vector to translate the transform by.
    /// - Returns: A new affine transform that is translated by the specified vector.
    public func translated(by vector: Vector3) -> AffineTransform {
        var transform = self
        transform.translate(by: vector)
        return transform
    }
}

extension AffineTransform : Transformable {

    /// Creates an affine transform from the specified rotation.
    /// 
    /// - Parameter rotation: The rotation to create the transform from.
    public init(rotation: Quaternion) {
        fatalError()
    }
    
    /// Creates an affine transform from the specified scale.
    /// 
    /// - Parameter scale: The scale to create the transform from.
    public init(scale: Size) {
        let (x, y, z) = (scale.width, scale.height, scale.depth)
        self = .init(matrix4x4: [
            [x, 0, 0, 0],
            [0, y, 0, 0],
            [0, 0, z, 0],
            [0, 0, 0, 1]
        ])
    }
    
    /// Creates an affine transform from the specified translation.
    /// 
    /// - Parameter translation: The translation to create the transform from.
    public init(translation: Vector3) {
        let (x, y, z) = (translation.x, translation.y, translation.z)
        self = .init(matrix4x4: [
            [1, 0, 0, x],
            [0, 1, 0, y],
            [0, 0, 1, z],
            [0, 0, 0, 1]
        ])
    }
    
    /// A Boolean value indicating whether the affine transform is the identity transform.
    public var isIdentity: Bool {
        self == .identity
    }
    
    /// A Boolean value indicating whether the affine transform is rectilinear (i.e., composed of only translations, rotations, and uniform scalings).
    public var isRectilinear: Bool {
        false
    }

    /// A Boolean value indicating whether the affine transform is a pure translation.
    public var isTranslation: Bool {
        false
    }

    /// A Boolean value indicating whether the affine transform is a pure rotation.
    public var isUniform: Bool {
        false
    }

    /// Concatenates the affine transform with another affine transform and returns the result.
    /// 
    /// - Parameter transform: The affine transform to concatenate with.
    /// - Returns: A new affine transform that is the result of the concatenation.
    public func concatenating(_ transform: AffineTransform) -> AffineTransform {
        self * transform
    }
    
    /// Concatenates the affine transform with another affine transform.
    /// 
    /// - Parameters:
    ///   - other: The affine transform to concatenate with.
    ///   - tolerance: The tolerance within which to consider the transforms equal.
    /// - Returns: A Boolean value indicating whether the two transforms are approximately equal.
    public func isApproximatelyEqual(to other: AffineTransform, tolerance: Double) -> Bool {
        false
    }
}

extension AffineTransform : AdditiveArithmetic {

    // MARK: - Applying arithmetic operations

    /// Multiplies two affine transforms.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand side transform.
    ///   - rhs: The right-hand side transform.
    /// - Returns: The product of the two transforms.
    @inlinable public static func * (lhs: AffineTransform, rhs: AffineTransform) -> AffineTransform {
        .init(matrix4x4: [
            [lhs.m11 * rhs.m11 + lhs.m12 * rhs.m21 + lhs.m13 * rhs.m31 + lhs.m14 * rhs.m41,
             lhs.m11 * rhs.m12 + lhs.m12 * rhs.m22 + lhs.m13 * rhs.m32 + lhs.m14 * rhs.m42,
             lhs.m11 * rhs.m13 + lhs.m12 * rhs.m23 + lhs.m13 * rhs.m33 + lhs.m14 * rhs.m43,
             lhs.m11 * rhs.m14 + lhs.m12 * rhs.m24 + lhs.m13 * rhs.m34 + lhs.m14 * rhs.m44],
            [lhs.m21 * rhs.m11 + lhs.m22 * rhs.m21 + lhs.m23 * rhs.m31 + lhs.m24 * rhs.m41,
             lhs.m21 * rhs.m12 + lhs.m22 * rhs.m22 + lhs.m23 * rhs.m32 + lhs.m24 * rhs.m42,
             lhs.m21 * rhs.m13 + lhs.m22 * rhs.m23 + lhs.m23 * rhs.m33 + lhs.m24 * rhs.m43,
             lhs.m21 * rhs.m14 + lhs.m22 * rhs.m24 + lhs.m23 * rhs.m34 + lhs.m24 * rhs.m44],
            [lhs.m31 * rhs.m11 + lhs.m32 * rhs.m21 + lhs.m33 * rhs.m31 + lhs.m34 * rhs.m41,
             lhs.m31 * rhs.m12 + lhs.m32 * rhs.m22 + lhs.m33 * rhs.m32 + lhs.m34 * rhs.m42,
             lhs.m31 * rhs.m13 + lhs.m32 * rhs.m23 + lhs.m33 * rhs.m33 + lhs.m34 * rhs.m43,
             lhs.m31 * rhs.m14 + lhs.m32 * rhs.m24 + lhs.m33 * rhs.m34 + lhs.m34 * rhs.m44],
            [lhs.m41 * rhs.m11 + lhs.m42 * rhs.m21 + lhs.m43 * rhs.m31 + lhs.m44 * rhs.m41,
             lhs.m41 * rhs.m12 + lhs.m42 * rhs.m22 + lhs.m43 * rhs.m32 + lhs.m44 * rhs.m42,
             lhs.m41 * rhs.m13 + lhs.m42 * rhs.m23 + lhs.m43 * rhs.m33 + lhs.m44 * rhs.m43,
             lhs.m41 * rhs.m14 + lhs.m42 * rhs.m24 + lhs.m43 * rhs.m34 + lhs.m44 * rhs.m44]
        ])
    }

    /// Multiplies and assigns an affine transform by a affine transform value.
    /// 
    /// - Parameters:
    ///   - lhs: The affine transform to modify.
    ///   - rhs: The affine transform to multiply by.
    @inlinable public static func *= (lhs: inout AffineTransform, rhs: AffineTransform) {
        lhs = lhs * rhs
    }

    /// Multiplies two affine transforms.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand side transform.
    ///   - rhs: The right-hand side transform.
    /// - Returns: The product of the two transforms.
    @inlinable public static func * (lhs: AffineTransform, rhs: Double) -> AffineTransform {
        .init(matrix4x4: [
            [lhs.m11 * rhs, lhs.m12 * rhs, lhs.m13 * rhs, lhs.m14 * rhs],
            [lhs.m21 * rhs, lhs.m22 * rhs, lhs.m23 * rhs, lhs.m24 * rhs],
            [lhs.m31 * rhs, lhs.m32 * rhs, lhs.m33 * rhs, lhs.m34 * rhs],
            [lhs.m41 * rhs, lhs.m42 * rhs, lhs.m43 * rhs, lhs.m44 * rhs]
        ])
    }

    /// Multiplies and assigns an affine transform by a scalar value.
    /// 
    /// - Parameters:
    ///   - lhs: The affine transform to modify.
    ///   - rhs: The scalar value to multiply by.
    @inlinable public static func *= (lhs: inout AffineTransform, rhs: Double) {
        lhs = lhs * rhs
    }

    /// Adds two affine transforms.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand side transform.
    ///   - rhs: The right-hand side transform.
    /// - Returns: The sum of the two transforms.
    @inlinable public static func + (lhs: AffineTransform, rhs: AffineTransform) -> AffineTransform {
        .init(matrix4x4: [
            [lhs.m11 + rhs.m11, lhs.m12 + rhs.m12, lhs.m13 + rhs.m13, lhs.m14 + rhs.m14],
            [lhs.m21 + rhs.m21, lhs.m22 + rhs.m22, lhs.m23 + rhs.m23, lhs.m24 + rhs.m24],
            [lhs.m31 + rhs.m31, lhs.m32 + rhs.m32, lhs.m33 + rhs.m33, lhs.m34 + rhs.m34],
            [lhs.m41 + rhs.m41, lhs.m42 + rhs.m42, lhs.m43 + rhs.m43, lhs.m44 + rhs.m44]
        ])
    }

    /// Adds and assigns an affine transform by another affine transform.
    /// 
    /// - Parameters:
    ///   - lhs: The affine transform to modify.
    ///   - rhs: The affine transform to add.
    @inlinable public static func += (lhs: inout AffineTransform, rhs: AffineTransform) {
        lhs = lhs + rhs
    }

    /// Subtracts one affine transform from another.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand side transform.
    ///   - rhs: The right-hand side transform.
    /// - Returns: The difference of the two transforms.
    @inlinable public static func - (lhs: AffineTransform, rhs: AffineTransform) -> AffineTransform {
        .init(matrix4x4: [
            [lhs.m11 - rhs.m11, lhs.m12 - rhs.m12, lhs.m13 - rhs.m13, lhs.m14 - rhs.m14],
            [lhs.m21 - rhs.m21, lhs.m22 - rhs.m22, lhs.m23 - rhs.m23, lhs.m24 - rhs.m24],
            [lhs.m31 - rhs.m31, lhs.m32 - rhs.m32, lhs.m33 - rhs.m33, lhs.m34 - rhs.m34],
            [lhs.m41 - rhs.m41, lhs.m42 - rhs.m42, lhs.m43 - rhs.m43, lhs.m44 - rhs.m44]
        ])
    }

    /// Subtracts and assigns an affine transform by another affine transform.
    /// 
    /// - Parameters:
    ///   - lhs: The affine transform to modify.
    ///   - rhs: The affine transform to subtract.
    @inlinable public static func -= (lhs: inout AffineTransform, rhs: AffineTransform) {
        lhs = lhs - rhs
    }

    /// Divides an affine transform by a scalar value.
    /// 
    /// - Parameters:
    ///   - lhs: The left-hand side transform.
    ///   - rhs: The scalar value to divide by.
    /// - Returns: The quotient of the two transforms.
    @inlinable public static func / (lhs: AffineTransform, rhs: Double) -> AffineTransform {
        .init(matrix4x4: [
            [lhs.m11 / rhs, lhs.m12 / rhs, lhs.m13 / rhs, lhs.m14 / rhs],
            [lhs.m21 / rhs, lhs.m22 / rhs, lhs.m23 / rhs, lhs.m24 / rhs],
            [lhs.m31 / rhs, lhs.m32 / rhs, lhs.m33 / rhs, lhs.m34 / rhs],
            [lhs.m41 / rhs, lhs.m42 / rhs, lhs.m43 / rhs, lhs.m44 / rhs]
        ])
    }

    /// Divides and assigns an affine transform by a scalar value.
    /// 
    /// - Parameters:
    ///   - lhs: The affine transform to modify.
    ///   - rhs: The scalar value to divide by.
    @inlinable public static func /= (lhs: inout AffineTransform, rhs: Double) {
        lhs = lhs / rhs
    }
}

extension AffineTransform : Primitive {

    /// A primitive with zero values.
    public static var zero: AffineTransform {
        .init(matrix4x4: [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ])
    }

    /// Returns a Boolean value that indicates whether the primitive is infinite.
    public var isFinite: Bool {
        self == .infinity
    }

    /// Returns a Boolean value that indicates whether the primitive contains any NaN values.
    public var isNaN: Bool {
        fatalError()
    }

    /// Returns a Boolean value that indicates whether the primitive is zero.
    public var isZero: Bool {
        self == .zero
    }

    /// A primitive with infinite values.
    public static var infinity: AffineTransform {
        .init(scale: .infinity, rotation: .infinity, translation: .infinity)
    }
}
