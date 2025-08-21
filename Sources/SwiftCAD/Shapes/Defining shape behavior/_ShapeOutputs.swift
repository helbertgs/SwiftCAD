import Spatial

/// The Output for the shape.
public struct _ShapeOutputs {

    /// The translation of the shape.
    var translation: Vector3 = .zero

    /// The rotation of the shape.
    var rotation: Quaternion = .identity

    /// The scale of the shape.
    var scale: Size = .one

    /// The vertices of the shape.
    var vertices: [Vector3] = []
    
    /// The faces of the shape.
    var faces: [Triangle] = []
    
    /// The triangles of the shape.
    var triangles: [Triangle] = []

    /// The children of the shape.
    var children: [_ShapeOutputs] = []
}