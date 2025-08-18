import Spatial

/// The Output for the shape.
public struct _ShapeOutputs {

    var triangles: [Triangle]

    public init(triangles: [Triangle] = []) {
        self.triangles = triangles
    }
}