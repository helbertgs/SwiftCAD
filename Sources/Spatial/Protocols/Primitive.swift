import Foundation

/// A set of methods common to Spatial primitives.
public protocol Primitive {

    // MARK: -  Instance properties

    /// Returns a Boolean value that indicates whether the primitive is infinite.
    var isFinite: Bool { get }

    /// Returns a Boolean value that indicates whether the primitive contains any NaN values.
    var isNaN: Bool { get }

    /// Returns a Boolean value that indicates whether the primitive is zero.
    var isZero: Bool { get }

    // MARK: - Type properties

    /// A primitive with infinite values.
    static var infinity: Self { get }

    /// A primitive with zero values.
    static var zero: Self { get }

    // MARK: - Transforming primitives
    
    /// Applies an affine transform.
    ///
    /// - Parameter transform: The affine transform that the function applies to the Spatial primitive.
    mutating func apply(_ transform: AffineTransform)

    /// Applies a projective transform.
    ///
    /// - Parameter transform: The projective transform that the function applies to the Spatial primitive.
    mutating func apply(_ transform: ProjectiveTransform)
    
    /// Returns the entity that results from applying an affine transform.
    ///
    /// - Parameter transform: The affine transform that the function applies to the Spatial primitive.
    func applying(_ transform: AffineTransform) -> Self
    
    /// Returns the entity that results from applying a projective transform.
    ///
    /// - Parameter transform: The projective transform that the function applies to the Spatial primitive.
    func applying(_ transform: ProjectiveTransform) -> Self
}

extension Primitive {

    // MARK: - Transforming primitives

    /// Applies an affine transform.
    ///
    /// - Parameter transform: The affine transform that the function applies to the Spatial primitive.
    public mutating func apply(_ transform: AffineTransform) {
        self = applying(transform)
    }

    /// Applies a projective transform.
    ///
    /// - Parameter transform: The projective transform that the function applies to the Spatial primitive.
    public mutating func apply(_ transform: ProjectiveTransform) {
        self = applying(transform)
    }
}