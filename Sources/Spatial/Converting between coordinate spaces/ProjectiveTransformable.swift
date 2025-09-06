import Foundation

public protocol ProjectiveTransformable: Transformable {

    // MARK: - Instance Methods

    /// Returns a new instance that’s constructed by applying a projective transform to this instance.
    /// 
    /// - Parameter transform: The projective transform to apply.
    func applying(_ transform: ProjectiveTransform) -> Self
}