import Spatial

/// The Output for the shape.
public struct _ShapeOutputs {

    /// The type of the shape.
    var type: Any.Type = Void.self

    /// The content of the shape.
    var content: (any Shape)? = nil

    /// The vertices of the shape.
    var vertices: [Vector3] = []
    
    /// The faces of the shape.
    var faces: [Triangle] = []
    
    /// The children of the shape.
    var children: [_ShapeOutputs] = []

    /// The modifiers applied to the shape.
    var modifiers: [any ShapeModifier] = []
}

extension _ShapeOutputs : CustomStringConvertible {
    public var description: String {
        """
        ShapeOutputs {
            type: \(type), 
            vertices: \(vertices.count), 
            faces: \(faces.count), 
            modifiers: [
                \(modifiers.map { "\($0)" }.joined(separator: "\n\t"))
            ], 
            children: [
                \(children.map { "\($0)" }.joined(separator: "\n\t"))
            ]
        }
        """
    }
}