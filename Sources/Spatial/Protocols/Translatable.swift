import Foundation

/// A set of methods that defines the interface to translate Spatial entities.
public protocol Translatable {

    // MARK: - Instance methods

    /// Translates the entity by the given vector.
    /// 
    /// - Parameter vector: The vector that defines the translation.
    mutating func translate(by vector: Vector3)

    /// Returns a new entity translated by the given vector.
    /// 
    /// - Parameter vector: The vector that defines the translation.
    func translated(by vector: Vector3) -> Self
}

extension Translatable {

    /// Translates the entity by the given vector.
    /// 
    /// - Parameter vector: The vector that defines the translation.
    mutating public func translate(by vector: Vector3) {
        self = translated(by: vector)
    }
}