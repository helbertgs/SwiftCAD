import Spatial

/// A structure that represents a sphere.
@frozen public struct Sphere : Codable, Equatable, Hashable, Sendable {

    // MARK: - Properties

    /// The radius of the sphere.
    public let radius: Double

    /// The number of slices in the sphere.
    public let slices: Int

    /// The number of stacks in the sphere.
    public let stacks: Int

    /// Creates a new sphere with the specified parameters.
    /// - Parameters:
    ///   - radius: The radius of the sphere.
    ///   - slices: The number of slices in the sphere.
    ///   - stacks: The number of stacks in the sphere.
    @inlinable public init(radius: Double, slices: Int = 12, stacks: Int = 12) {
        self.radius = radius
        self.slices = slices
        self.stacks = stacks
    }
}

extension Sphere : Shape {

    /// The body of the shape.
    public var body : Never {
        fatalError("This should never be called")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<Sphere>, inputs: _ShapeInputs) -> _ShapeOutputs {
        var outputs = _ShapeOutputs()
        let stacks = shape.value.stacks
        let slices = shape.value.slices
        let radius = shape.value.radius

        for i in 0..<stacks {
            let lat0 = Double.pi * (-0.5 + Double(i) / Double(stacks))
            let lat1 = Double.pi * (-0.5 + Double(i+1) / Double(stacks))

            let z0 = radius * sin(lat0)
            let zr0 = radius * cos(lat0)
            let z1 = radius * sin(lat1)
            let zr1 = radius * cos(lat1)

            for j in 0..<slices {
                let lng0 = 2 * Double.pi * Double(j) / Double(slices)
                let lng1 = 2 * Double.pi * Double(j+1) / Double(slices)

                let x0 = cos(lng0), y0 = sin(lng0)
                let x1 = cos(lng1), y1 = sin(lng1)

                let v1 = Vector3(x: x0*zr0, y: y0*zr0, z: z0)
                let v2 = Vector3(x: x0*zr1, y: y0*zr1, z: z1)
                let v3 = Vector3(x: x1*zr1, y: y1*zr1, z: z1)

                let v4 = Vector3(x: x1*zr0, y: y1*zr0, z: z0)

                outputs.triangles.append(Triangle(a: v1, b: v2, c: v3))
                outputs.triangles.append(Triangle(a: v1, b: v3, c: v4))
            }
        }

        return outputs
    }
}