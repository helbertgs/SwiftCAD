import Foundation

/// A 3D shape representing a cylinder.
@frozen public struct Cylinder : Codable, Equatable, Hashable, Sendable {

    /// The radius of the top base of the cylinder.
    public let r1: Double

    /// The radius of the bottom base of the cylinder.
    public let r2: Double

    /// The height of the cylinder.
    public let height: Double

    /// The number of slices used to render the cylinder.
    public let slices: Int

    /// Creates a new cylinder.
    /// - Parameters:
    ///   - r1: The radius of the top base of the cylinder.
    ///   - r2: The radius of the bottom base of the cylinder.
    ///   - height: The height of the cylinder.
    ///   - slices: The number of slices used to render the cylinder.
    @inlinable public init(r1: Double, r2: Double, height: Double, slices: Int = 12) {
        self.r1 = r1
        self.r2 = r2
        self.height = height
        self.slices = slices
    }

    /// Creates a new cylinder.
    /// - Parameters:
    ///   - radius: The radius of the cylinder.
    ///   - height: The height of the cylinder.
    ///   - slices: The number of slices used to render the cylinder.
    @inlinable public init(radius: Double, height: Double, slices: Int = 12) {
        self.r1 = radius
        self.r2 = radius
        self.height = height
        self.slices = slices
    }
}

extension Cylinder : Shape {

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
        let r1 = shape.value.r1
        let r2 = shape.value.r2
        let height = shape.value.height
        let slices = shape.value.slices
        let step = 2 * Double.pi / Double(slices)

        for i in 0..<slices {
            let a0 = Double(i) * step
            let a1 = Double(i+1) * step
            let x0 = cos(a0), y0 = sin(a0)
            let x1 = cos(a1), y1 = sin(a1)
            let v0 = Vector3(x: x0 * r1, y: y0 * r1, z: 0)
            let v1 = Vector3(x: x1 * r1, y: y1 * r1, z: 0)
            let v2 = Vector3(x: x1 * r2, y: y1 * r2, z: height)
            let v3 = Vector3(x: x0 * r2, y: y0 * r2, z: height)
            
            outputs.triangles.append(Triangle(v1: v0, v2: v1, v3: v2))
            outputs.triangles.append(Triangle(v1: v0, v2: v2, v3: v3))
            outputs.triangles.append(Triangle(v1: Vector3(x: 0, y: 0, z: 0), v2: v1, v3: v0))
            outputs.triangles.append(Triangle(v1: Vector3(x: 0, y: 0, z: height), v2: v2, v3: v3))
        }

        return outputs
    }
}