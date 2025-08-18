import Spatial

/// A shape that represents a cube.
@frozen public struct Cube : Codable, Equatable, Hashable, Sendable {

    // MARK: - Properties

    /// The size of the cube.
    public let size : Size

    /// Creates a new cube with the specified size.
    /// - Parameter size: The size of the cube.
    @inlinable public init(size: Size) {
        self.size = size
    }

    /// Creates a new cube with the specified size.
    /// - Parameter size: The size of the cube.
    @inlinable public init<T>(size: T) where T : BinaryFloatingPoint {
        self.size = Size(width: Double(size), height: Double(size), depth: Double(size))
    }

    /// Creates a new cube with the specified dimensions.
    /// - Parameters:
    ///   - width: The width of the cube.
    ///   - height: The height of the cube.
    ///   - depth: The depth of the cube.
    @inlinable public init<T>(width: T, height: T, depth: T) where T : BinaryFloatingPoint {
        self.size = Size(width: Double(width), height: Double(height), depth: Double(depth))
    }
}

extension Cube : Shape {

    /// The body of the shape.
    public var body : Never {
        fatalError("This should never be called")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<Cube>, inputs: _ShapeInputs) -> _ShapeOutputs {
        let s = shape.value.size / 2.0
        let vertices = [
            Vector3(x: -s.width, y: -s.height, z: -s.depth),
            Vector3(x:  s.width, y: -s.height, z: -s.depth),
            Vector3(x:  s.width, y:  s.height, z: -s.depth),
            Vector3(x: -s.width, y:  s.height, z: -s.depth),
            Vector3(x: -s.width, y: -s.height, z:  s.depth),
            Vector3(x:  s.width, y: -s.height, z:  s.depth),
            Vector3(x:  s.width, y:  s.height, z:  s.depth),
            Vector3(x: -s.width, y:  s.height, z:  s.depth)
        ]

        let faces = [
            (0, 1, 2), (0, 2, 3), // bottom
            (4, 5, 6), (4, 6, 7), // top
            (0, 1, 5), (0, 5, 4), // front
            (2, 3, 7), (2, 7, 6), // back
            (1, 2, 6), (1, 6, 5), // right
            (0, 3, 7), (0, 7, 4)  // left
        ]

        var outputs = _ShapeOutputs()
        faces.forEach { face in
            let a = vertices[face.0]
            let b = vertices[face.1]
            let c = vertices[face.2]

            outputs
                .triangles
                .append(
                    .init(a: a, b: b, c: c)
                )
        }

        return outputs
    }
}