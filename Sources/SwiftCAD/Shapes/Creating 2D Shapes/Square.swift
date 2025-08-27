import Spatial

/// A 2D square shape.
@frozen public struct Square : Codable, Equatable, Hashable, Sendable {

    /// The size of the square.
    public let size: Size

    /// The center point of the square.
    public let center: Bool

    /// Creates a new square with the specified size.
    /// 
    /// - Parameters:
    ///   - size: The size of the square.
    ///   - center: A Boolean value indicating whether the square should be centered.
    @inlinable public init(size: Size, center: Bool = false) {
        self.size = size
        self.center = center
    }

    /// Creates a new square with the specified side length.
    /// 
    /// - Parameter 
    ///   - side: The length of the sides of the square.
    ///   - center: A Boolean value indicating whether the square should be centered.
    @inlinable public init<T>(size: T, center: Bool = false) where T : BinaryFloatingPoint {
        self.size = Size(width: size, height: size, depth: 0)
        self.center = center
    }
}

extension Square : Shape {

    /// The body of the shape.
    public var body : Never {
        fatalError("This should never be called")
    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<Square>, inputs: _ShapeInputs) -> _ShapeOutputs {
        var outputs = _ShapeOutputs()
        outputs.type = Self.self
        outputs.content = shape.value

        let width = shape.value.size.width / 2
        let height = shape.value.size.height / 2
        var vertices: [Vector3] = []

        if shape.value.center {
            vertices = [
                Vector3(x: -width, y: -height, z: 0),
                Vector3(x:  width, y: -height, z: 0),
                Vector3(x:  width, y:  height, z: 0),
                Vector3(x: -width, y:  height, z: 0)
            ]
        } else {
            vertices = [
                Vector3(x: 0,     y: 0,     z: 0),
                Vector3(x: width, y: 0,     z: 0),
                Vector3(x: width, y: height,z: 0),
                Vector3(x: 0,     y: height,z: 0)
            ]
        }

        outputs.vertices.append(contentsOf: vertices)
        outputs.faces.append(Triangle(a: vertices[0], b: vertices[1], c: vertices[2]))
        outputs.faces.append(Triangle(a: vertices[0], b: vertices[2], c: vertices[3]))

        return outputs
    }    
}