import Foundation

/// A 3D affine transformation matrix.
public struct AffineTransform {

    // MARK: - Instance Properties

    /// The entry at position [1,1] in the matrix.
    private var m11: Double = 0.0

    /// The entry at position [1,2] in the matrix.
    private var m12: Double = 0.0

    /// The entry at position [1,3] in the matrix.
    private  var m13: Double = 0.0

    /// The entry at position [1,4] in the matrix.
    private  var m14: Double = 0.0

    /// The entry at position [2,1] in the matrix.
    private  var m21: Double = 0.0

    /// The entry at position [2,2] in the matrix.
    private  var m22: Double = 0.0

    /// The entry at position [2,3] in the matrix.
    private  var m23: Double = 0.0

    /// The entry at position [2,4] in the matrix.
    private  var m24: Double = 0.0

    /// The entry at position [3,1] in the matrix.
    private  var m31: Double = 0.0

    /// The entry at position [3,2] in the matrix.
    private  var m32: Double = 0.0

    /// The entry at position [3,3] in the matrix.
    private  var m33: Double = 0.0

    /// The entry at position [3,4] in the matrix.
    private  var m34: Double = 0.0

    /// The entry at position [4,1] in the matrix.
    private  var m41: Double = 0.0

    /// The entry at position [4,2] in the matrix.
    private  var m42: Double = 0.0

    /// The entry at position [4,3] in the matrix.
    private  var m43: Double = 0.0

    /// The entry at position [4,4] in the matrix.
    private  var m44: Double = 0.0

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

    // MARK: - Creating a 3D affine transform structure

    /// Creates an affine transform.
    public init() {
        (m11, m12, m13, m14) = (0, 0, 0, 0)
        (m21, m22, m23, m24) = (0, 0, 0, 0)
        (m31, m32, m33, m34) = (0, 0, 0, 0)
        (m41, m42, m43, m44) = (0, 0, 0, 0)

        self.scale = .one
        self.rotation = .zero
        self.translation = .zero
    }

    /// Creates an affine transform from the specified scale, rotate, and translate transforms.
    /// 
    /// - Parameters:
    ///   - scale: A size structure that specifies the scale.
    ///   - rotation: A rotation structure that specifies the rotation.
    ///   - translation: A vector that specifies the translation.
    public init(scale: Size = .one, rotation: Quaternion = .zero, translation: Vector3 = .zero) {
        self.scale = scale
        self.rotation = rotation
        self.translation = translation
    }

    // MARK: - Decomposing a 3D affine transform

    /// The affine transform’s rotation.
    public var rotation: Quaternion?

    /// The affine transform’s scale.
    public var scale: Size

    /// The translation component of the affine transform.
    public var translation: Vector3

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
}
