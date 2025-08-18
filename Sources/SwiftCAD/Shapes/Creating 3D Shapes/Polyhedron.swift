import Spatial

/// A 3D shape representing a polyhedron.
@frozen public struct Polyhedron : Codable, Equatable, Hashable, Sendable {

    /// The vertices of the polyhedron.
    public let vertices: [Vector3]

    /// The faces of the polyhedron.
    public let faces: [[Int]]

    /// Creates a new polyhedron.
    /// - Parameters:
    ///   - vertices: The vertices of the polyhedron.
    ///   - faces: The faces of the polyhedron.
    @inlinable public init(vertices: [Vector3], faces: [[Int]]) {
        self.vertices = vertices
        self.faces = faces
    }
}

extension Polyhedron : Shape {

    /// The body of the shape.
    public var body : Never {
        fatalError("This should never be called")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<Polyhedron>, inputs: _ShapeInputs) -> _ShapeOutputs {
        var outputs = _ShapeOutputs()
        let faces = shape.value.faces
        let points = shape.value.vertices

        for face in faces where face.count >= 3 {
            for i in 1..<(face.count - 1) {
                let v1 = points[face[0]]
                let v2 = points[face[i]]
                let v3 = points[face[i + 1]]
                outputs.triangles.append(Triangle(a: v1, b: v2, c: v3))
            }
        }

        return outputs
    }
}

extension Polyhedron {

    /// Compares two polyhedra for equality.
    /// - Parameters:
    ///   - lhs: The left-hand side polyhedron.
    ///   - rhs: The right-hand side polyhedron.
    /// - Returns: A Boolean value indicating whether the two polyhedra are equal.
    public static func == (_ lhs: Polyhedron, _ rhs: Polyhedron) -> Bool {
        return lhs.vertices == rhs.vertices && lhs.faces == rhs.faces
    }
}