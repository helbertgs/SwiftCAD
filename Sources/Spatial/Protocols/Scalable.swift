import Foundation

/// A set of methods that defines the interface to scale Spatial entities.
public protocol Scalable {

    // MARK: - Instance methods

    /// Scales the entity by the given size.
    /// 
    /// - Parameter size: The size to scale the entity by.
    mutating func scale(by size: Size)

    /// Scales the entity by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    ///   - z: The factor to scale the entity's z dimension by.
    mutating func scaleBy(x: Double, y: Double, z: Double)

    /// Returns a new entity scaled by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    ///   - z: The factor to scale the entity's z dimension by.
    func scaledBy(x: Double, y: Double, z: Double) -> Self

    /// Uniformly scales the entity by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    mutating func uniformlyScale(by scale: Double)

    /// Returns a new entity uniformly scaled by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    func uniformlyScaled(by scale: Double) -> Self
}

extension Scalable {

    /// Scales the entity by the given size.
    ///
    /// - Parameter size: The size to scale the entity by.
    public mutating func scale(by size: Size) {
        scaleBy(x: size.width, y: size.height, z: size.depth)
    }

    /// Returns a new entity scaled by the given factors.
    ///
    /// - Parameters:
    ///   - x: The factor to scale the entity's x dimension by.
    ///   - y: The factor to scale the entity's y dimension by.
    public func scaledBy(x: Double, y: Double) -> Self {
        return scaledBy(x: x, y: y, z: 1.0)
    }

    /// Uniformly scales the entity by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    public mutating func uniformlyScale(by scale: Double) {
        scaleBy(x: scale, y: scale, z: scale)
    }

    /// Returns a new entity uniformly scaled by the given factor.
    ///
    /// - Parameter scale: The factor to scale the entity by.
    public func uniformlyScaled(by scale: Double) -> Self {
        return scaledBy(x: scale, y: scale, z: scale)
    }
}