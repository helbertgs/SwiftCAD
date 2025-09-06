import Foundation

protocol Renderer<Modifier> {
    associatedtype Modifier
    func render(_ obj: _ShapeOutputs) -> Data
    func modify(_ obj: _ShapeOutputs, with modifier: Modifier, inputs: _ShapeInputs) -> _ShapeOutputs?
    func export()
}

/// A renderer that exports shapes to STL format.
final class STL<T> : Renderer {
    typealias Modifier = T

    /// The shape to be rendered.
    let obj: _ShapeOutputs

    /// Creates a new STL renderer with the given shape.
    /// 
    /// - Parameter obj: The shape to be rendered.
    init(_ obj: _ShapeOutputs) {
        self.obj = obj
    }
    
    /// Renders the given shape to STL format.
    /// 
    /// - Parameter shape: The shape to render.
    /// - Returns: The STL data representing the shape.
    func render(_ obj: _ShapeOutputs) -> Data {
       .init()
    }

    /// Modifies the given shape using the specified modifier and inputs.
    /// 
    /// - Parameters:
    ///   - obj: The shape to be modified.
    ///   - modifier: The modifier to apply to the shape.
    ///   - inputs: The inputs required for the modification.
    /// - Returns: The modified shape, or nil if the modification fails.
    func modify(_ obj: _ShapeOutputs, with modifier: Modifier, inputs: _ShapeInputs) -> _ShapeOutputs? {
        obj
    }

    /// Exports the shape to an STL file in the user's document directory.
    func export() {
        var source = "solid OpenCAD\n"
        for tri in obj.faces {
            source += " facet normal 0 0 0\n"
            source += "  outer loop\n"
            source += "   vertex \(tri.a.x) \(tri.a.y) \(tri.a.z)\n"
            source += "   vertex \(tri.b.x) \(tri.b.y) \(tri.b.z)\n"
            source += "   vertex \(tri.c.x) \(tri.c.y) \(tri.c.z)\n"
            source += "  endloop\n"
            source += " endfacet\n"
        }
        source += "endsolid OpenCAD\n"
        let data = source.data(using: .utf8) ?? Data()

        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Preview.stl") {
            try? data.write(to: url, options: .atomic)
            print("STL file written to \(url.path)")
        } else {
            print("Failed to create output URL.")
        }
    }
}

extension STL where T == TranslateModifier {
    func modify(_ obj: _ShapeOutputs, with modifier: Modifier, inputs: _ShapeInputs) -> _ShapeOutputs? {
        obj
    }
}