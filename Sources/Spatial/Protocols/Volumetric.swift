import Foundation

/// A set of methods for working with Spatial primitives with volume.
public protocol Volumetric {

    // MARK: - Instance properties

    /// The size of the volume.
    var size: Size { get }

    // MARK: - Instance methods

    /// Returns a Boolean value that indicates whether the entity contains the specified volumetric entity.
    /// 
    /// - Parameter other: The volumetric entity that the function compares against.
    func contains(_ other: Self) -> Bool

    /// Returns a Boolean value that indicates whether this volume contains the specified point.
    /// 
    /// - Parameter point: The point that the function compares against.
    func contains(point: Point) -> Bool

    /// Returns a Boolean value that indicates whether this volume contains any of the specified points.
    /// 
    /// - Parameter points: The points that the function compares against.
    func contains(anyOf points: [Point]) -> Bool

    /// Sets the primitive to the intersection of itself and the specified primitive.
    /// 
    /// - Parameter other: The volumetric entity that the function compares against.
    mutating func formIntersection(_ other: Self)

    /// Sets the primitive to the union of itself and the specified primitive.
    /// 
    /// - Parameter other: The volumetric entity that the function compares against.
    mutating func formUnion(_ other: Self)

    /// Returns the intersection of two volumetric entities.
    /// 
    /// - Parameter other: The volumetric entity that the function compares against.
    func intersection(_ other: Self) -> Self?

    /// Returns the smallest volumetric entity that contains the two source entities.
    /// 
    /// - Parameter other: The volumetric entity that the function compares against.
    func union(_ other: Self) -> Self
}