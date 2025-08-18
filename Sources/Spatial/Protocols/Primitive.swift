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
}