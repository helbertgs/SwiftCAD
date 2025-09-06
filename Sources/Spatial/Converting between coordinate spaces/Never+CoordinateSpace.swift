import Foundation

extension Never : CoordinateSpace {

    public var ancestorSpace: Never? {
        fatalError("not implemented")
    }

    public func transformSpace(_ baseFromMapTransform: @escaping (Never) -> ProjectiveTransform) -> Never {
        fatalError("not implemented")
    }

    public typealias AncestorCoordinateSpace = Never

    public func ancestorFromSpaceTransform() throws -> ProjectiveTransform {
        fatalError("not implemented")
    }

    public func convert<T>(value: T, from targetCoordinateSpace: Never) throws -> T where T : ProjectiveTransformable {
        fatalError("not implemented")
    }

    public func convert<T, Space>(value: T, from sourceCoordinateSpace: Space) throws -> T where T : ProjectiveTransformable, Space : CoordinateSpace {
        fatalError("not implemented")
    }

    public func convert<T, Space>(value: T, to targetCoordinateSpace: Space) throws -> T where T : ProjectiveTransformable, Space : CoordinateSpace {
        fatalError("not implemented")
    }

    public func transform(from targetCoordinateSpace: Never) throws -> ProjectiveTransform {
        fatalError("not implemented")
    }

    public static var worldReference: WorldReferenceCoordinateSpace {
        fatalError("not implemented")
    }
}
