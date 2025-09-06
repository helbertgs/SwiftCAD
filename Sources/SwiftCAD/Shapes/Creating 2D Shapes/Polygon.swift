import Spatial

/// A 2D polygon shape.
@frozen public struct Polygon : Codable, Equatable, Hashable, Sendable {

    /// The vertices of the polygon.
    public let points: [Vector3]

    /// Creates a new polygon with the specified vertices.
    /// Creates a new polygon with the specified points.
    /// - Parameter points: The points of the polygon.
    @inlinable public init(points: [Vector3]) {
        self.points = points
    }
}

extension Polygon : Shape {
    /// The body of the shape.
    public var body : Never {
        fatalError("This should never be called")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<Polygon>, inputs: _ShapeInputs) -> _ShapeOutputs {
        guard shape.value.points.count >= 3 else {
            return .init()
        }

        var outputs = _ShapeOutputs()
        outputs.type = Self.self
        outputs.content = shape.value

        let vertices = shape.value.points
        let count = vertices.count

        let center = Vector3(
            x: vertices.reduce(0) { $0 + $1.x } / Double(count),
            y: vertices.reduce(0) { $0 + $1.y } / Double(count),
            z: vertices.reduce(0) { $0 + $1.z } / Double(count)
        )

        for i in 0..<count {
            let v2 = vertices[i]
            let v3 = vertices[(i + 1) % count]

            outputs.vertices.append(contentsOf: [center, v2, v3])
            outputs.faces.append(Triangle(a: center, b: v2, c: v3))
        }

        return outputs
    }
}
