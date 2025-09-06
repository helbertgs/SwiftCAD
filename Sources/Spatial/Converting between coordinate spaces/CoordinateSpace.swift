import Foundation

/// A type that represents a coordinate space which you can use to convert values to and from other coordinate spaces.
public protocol CoordinateSpace {

    // MARK: - Associated Types

    associatedtype AncestorCoordinateSpace : CoordinateSpace

    // MARK: - Instance Properties

    /// An ancestor coordinate space.
    var ancestorSpace: Self.AncestorCoordinateSpace? { get }

    // MARK: - Instance Methods

    /// This space’s transform relative to its ancestor.
    func ancestorFromSpaceTransform() throws -> ProjectiveTransform

    /// Converts a value from this coordinate space to the specified target coordinate space.
    /// 
    /// - Parameters:
    ///   - value: The value to convert.
    ///   - targetCoordinateSpace: The coordinate space to convert the value to.
    /// - Returns: The converted value.
    func convert<T>(value: T, from targetCoordinateSpace: Self) throws -> T where T : ProjectiveTransformable

    /// Converts a value from a source coordinate space to this coordinate space.
    /// 
    /// - Parameters:
    ///   - value: The value to convert.
    ///   - sourceCoordinateSpace: The coordinate space to convert the value from.
    /// - Returns: The converted value.
    func convert<T, Space>(value: T, from sourceCoordinateSpace: Space) throws -> T where T : ProjectiveTransformable, Space : CoordinateSpace

    /// Converts a value from this coordinate space to a target coordinate space.
    /// 
    /// - Parameters:
    ///   - value: The value to convert.
    ///   - targetCoordinateSpace: The coordinate space to convert the value to.
    /// - Returns: The converted value.
    func convert<T, Space>(value: T, to targetCoordinateSpace: Space) throws -> T where T : ProjectiveTransformable, Space : CoordinateSpace

    /// Returns the transform that converts values from this coordinate space to the specified target coordinate space.
    /// 
    /// - Parameter targetCoordinateSpace: The coordinate space to convert values to.
    /// - Returns: The transform that converts values from this coordinate space to the specified target coordinate space.
    func transform(from targetCoordinateSpace: Self) throws -> ProjectiveTransform

    /// Returns the transform that converts values from a source coordinate space to this coordinate space.
    /// 
    /// - Parameter sourceCoordinateSpace: The coordinate space to convert values from.
    /// - Returns: The transform that converts values from the specified coordinate space to this coordinate space
    func transformSpace(_ baseFromMapTransform: @escaping (Self) -> ProjectiveTransform) -> Self.AncestorCoordinateSpace

    // MARK: - Type Properties

    /// A coordinate space that represents the world root for all other coordinate spaces.
    static var worldReference: WorldReferenceCoordinateSpace { get }
}
