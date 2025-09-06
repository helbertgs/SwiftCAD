import Foundation

/// A coordinate space that represents a world reference point.
@frozen public struct WorldReferenceCoordinateSpace : CoordinateSpace {

    /// Creates a new world reference coordinate space.
    init() {}

    // MARK: - CoordinateSpace Conformance

    public typealias AncestorCoordinateSpace = Never

    /// An ancestor coordinate space.
    public var ancestorSpace: Never? {
        nil
    }

    /// This space’s transform relative to its ancestor.
    /// 
    /// - Throws: An error if the transform can’t be computed.
    /// - Returns: The transform from the ancestor space to this space.
    public func ancestorFromSpaceTransform() throws -> ProjectiveTransform {
        .init()
    }

    /// Converts a value from this coordinate space to the specified target coordinate space.
    /// 
    /// - Parameters:
    ///   - value: The value to convert.
    ///   - targetCoordinateSpace: The target coordinate space to convert to.
    /// - Throws: An error if the conversion can’t be performed.
    /// - Returns: The converted value.
    public func convert<T>(value: T, from targetCoordinateSpace: Self) throws -> T where T : ProjectiveTransformable {
        value
    }

    /// Converts a value from a source coordinate space to this coordinate space.
    /// 
    /// - Parameters:
    ///   - value: The value to convert.
    ///   - sourceCoordinateSpace: The source coordinate space to convert from.
    /// - Throws: An error if the conversion can’t be performed.
    /// - Returns: The converted value.
    public func convert<T, Space>(value: T, from sourceCoordinateSpace: Space) throws -> T where T : ProjectiveTransformable, Space : CoordinateSpace {
        fatalError("not implemented")
    }

    /// Converts a value from this coordinate space to a target coordinate space.
    ///
    /// - Parameters:
    ///   - value: The value to convert.
    ///   - targetCoordinateSpace: The target coordinate space to convert to.
    /// - Throws: An error if the conversion can’t be performed.
    /// - Returns: The converted value.
    public func convert<T, Space>(value: T, to targetCoordinateSpace: Space) throws -> T where T : ProjectiveTransformable, Space : CoordinateSpace {
        fatalError("not implemented")
    }

    /// Returns the transform that converts values from this coordinate space to the specified target coordinate space.
    /// 
    /// - Parameter targetCoordinateSpace: The target coordinate space to convert to.
    /// - Throws: An error if the transform can’t be computed.
    /// - Returns: The transform from this space to the target space.
    public func transform(from targetCoordinateSpace: Self) throws -> ProjectiveTransform {
        fatalError("not implemented")
    }

    /// Returns the transform that converts values from a source coordinate space to this coordinate space.
    /// 
    /// - Parameter baseFromMapTransform: A closure that maps values from the source space to this space.
    /// - Returns: A new coordinate space that uses the provided transform.
    public func transformSpace(_ baseFromMapTransform: @escaping (WorldReferenceCoordinateSpace) -> ProjectiveTransform) -> Never {
        fatalError("not implemented")
    }

    // MARK: - Type Properties

    /// A coordinate space that represents the world root for all other coordinate spaces.
    public static var worldReference: WorldReferenceCoordinateSpace {
        .init()
    }
}
