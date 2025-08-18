import Spatial

/// A 2D circle shape.
@frozen public struct Circle : Codable, Equatable, Hashable, Sendable {

    /// The radius of the circle.
    public let radius: Double

    /// The number of segments used to approximate the circle.
    public let segments: Int

    /// Creates a new circle with the specified radius and number of segments.
    /// 
    /// - Parameters:
    ///   - radius: The radius of the circle.
    ///   - segments: The number of segments used to approximate the circle.
    @inlinable public init(radius: Double, segments: Int = 32) {
        self.radius = radius
        self.segments = segments
    }
}

extension Circle : Shape {

    /// The body of the shape.
    public var body : Never {
        fatalError("This should never be called")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<Circle>, inputs: _ShapeInputs) -> _ShapeOutputs {
        var outputs = _ShapeOutputs()
        let segments = shape.value.segments
        let radius = shape.value.radius
        let step = 2 * Double.pi / Double(segments)
        let center = Vector3(x: 0, y: 0, z: 0)

        var vertices: [Vector3] = []
        for i in 0..<segments {
            let a = Double(i) * step
            vertices.append(Vector3(x: cos(a) * radius, y: sin(a) * radius, z: 0))
        }

        for i in 0..<segments {
            let v1 = center
            let v2 = vertices[i]
            let v3 = vertices[(i + 1) % segments]
            outputs.triangles.append(Triangle(a: v1, b: v2, c: v3))
        }

        return outputs
    }
}