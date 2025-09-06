import Foundation

/// A set of methods that are common to transforms.
public protocol Transformable {

    // MARK: - Initializers

    /// Returns a new rotation transform.
    /// 
    /// - Parameter rotation: The rotation to apply.
    init(rotation: Quaternion)

    /// Returns a new scale transform.
    /// 
    /// - Parameter scale: The scale to apply.
    init(scale: Size)

    /// Returns a new scale, rotate, translate transform.
    /// 
    /// - Parameters:
    ///   - scale: The scale to apply.
    ///   - rotation: The rotation to apply.
    ///   - translation: The translation to apply.
    init(scale: Size, rotation: Quaternion, translation: Vector3)

    /// Returns a new translation transform.
    /// 
    /// - Parameter translation: The translation to apply.
    init(translation: Vector3)

    // MARK: - Instance Properties

    /// Returns a transform that’s constructed by inverting an existing transform.
    var inverse: Self? { get }

    /// Returns true if the transform is the identity transform.
    var isIdentity: Bool { get }

    /// Returns true if the transform is rectilinear.
    var isRectilinear: Bool { get }

    /// Returns true if the transform is a translation.
    var isTranslation: Bool { get }

    /// Returns true if the transform is uniform over all dimensions.
    var isUniform: Bool { get }

    /// The transform’s rotation. This is nil if the transform isn’t scale-rotate-translate.
    var rotation: Quaternion? { get }

    /// The transform’s translation.
    var translation: Vector3 { get }

    // MARK: - Instance Methods

    /// Returns a transform that’s constructed by combining two existing transforms.
    /// 
    /// - Parameter transform: The transform to concatenate with this transform.
    func concatenating(_ transform: Self) -> Self

    /// Flips the transform along the specified axis.
    /// 
    /// - Parameter axis: The axis to flip along.
    mutating func flip(along axis: Axis)

    /// Returns a transform that’s constructed by flipping the existing transform along the specified axis.
    /// 
    /// - Parameter axis: The axis to flip along.
    func flipped(along axis: Axis) -> Self

    /// Returns a Boolean value that indicates whether two transforms are equal within a specified tolerance.
    /// 
    /// - Parameters:
    ///   - other: The transform to compare against.
    ///   - tolerance: The maximum difference between the two transforms for which they are still considered equal.
    func isApproximatelyEqual(to other: Self, tolerance: Double) -> Bool

    /// Returns true if the transform is uniform over the specified dimensions.
    /// 
    /// - Parameter overDimensions: The dimensions to check for uniformity.
    func isUniform(overDimensions: Dimension) -> Bool
}