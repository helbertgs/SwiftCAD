import Spatial

/// A protocol that defines a geometric shape.
public protocol Shape {

    /// The type of the shape's body.
    associatedtype Body : Shape

    /// The body of the shape.
    @ShapeBuilder var body : Self.Body { get }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    static func _makeShape(_ shape: _GraphValue<Self>, inputs: _ShapeInputs) -> _ShapeOutputs
}

extension Shape {

    /// Applies a shape modifier to the shape.
    /// 
    /// - Parameter modifier: The shape modifier to apply.
    /// - Returns: A modified shape.
    public func modifier<T>(_ modifier: T) -> ModifiedContent<Self, T> where T : ShapeModifier {
        ModifiedContent(content: self, modifier: modifier)
    }
}

extension Shape {

    /// Translates the shape by a given position vector.
    /// 
    /// - Parameter position: The position vector to translate the shape by.
    /// - Returns: A modified shape.
    public func translate(_ position: Vector3) -> some Shape {
        self
    }

    /// Translates the shape by a given position vector.
    /// 
    /// - Parameter position: The position vector to translate the shape by.
    /// - Returns: A modified shape.
    public func translate(_ position: Vector2) -> some Shape {
        self
    }

    /// Translates the shape by a given position vector.
    /// 
    /// - Parameters:
    ///   - x: The x-coordinate of the position vector.
    ///   - y: The y-coordinate of the position vector.
    ///   - z: The z-coordinate of the position vector.
    /// - Returns: A modified shape.
    public func translate(x: Double = 0, y: Double = 0, z: Double = 0) -> some Shape {
        self
    }

    /// Scales the shape by a given size.
    /// 
    /// - Parameter size: The size to scale the shape by.
    /// - Returns: A modified shape.
    public func scale(_ size: Size) -> some Shape {
        self
    }

    /// Scales the shape by a given size.
    /// 
    /// - Parameter size: The size to scale the shape by.
    /// - Returns: A modified shape.
    public func scale(_ size: Vector2) -> some Shape {
        self
    }

    /// Scales the shape by a given size.
    /// 
    /// - Parameter size: The size to scale the shape by.
    /// - Returns: A modified shape.
    public func scale(_ size: Vector3) -> some Shape {
        self
    }

    /// Scales the shape by a given size.
    /// 
    /// - Parameters:
    ///   - width: The width to scale the shape by.
    ///   - height: The height to scale the shape by.
    ///   - depth: The depth to scale the shape by.
    /// - Returns: A modified shape.
    public func scale(width: Double = 0, height: Double = 0, depth: Double = 0) -> some Shape {
        self
    }

    /// Rotates the shape by a given angle.
    /// 
    /// - Parameter angle: The angle to rotate the shape by.
    /// - Returns: A modified shape.
    public func rotate(_ angle: Angle) -> some Shape {
        self
    }

    /// Rotates the shape by a given quaternion.
    /// 
    /// - Parameter quaternion: The quaternion to rotate the shape by.
    /// - Returns: A modified shape.
    public func rotate(_ quaternion: Quaternion) -> some Shape {
        self
    }

    /// Transforms the shape by a given transformation.
    /// 
    /// - Parameter transform: The transformation to apply to the shape.
    /// - Returns: A modified shape.
    public func transform(_ transform: Transform) -> some Shape {
        self
    }

    /// Mirrors the shape.
    /// 
    /// - Returns: A modified shape.
    public func mirror() -> some Shape {
        self
    }
}