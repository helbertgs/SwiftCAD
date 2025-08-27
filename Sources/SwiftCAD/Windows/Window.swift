import Foundation

/// A structure that represents a window in the user interface.
public struct Window<Content> : Scene where Content : Shape {

    /// The title of the window.
    public let title: String

    /// The content to display in the window.
    public let content: Content

    /// Creates a new STL object.
    /// - Parameter shape: The shape to export.
    public init(title: String, @ShapeBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    // MARK: - Scene

    /// The content and behavior of the scene.
    public var body: some Scene {
        fatalError("Not implemented")
    }

    /// Creates a new scene from the given graph value and inputs.
    /// - Parameters:
    ///   - scene: The graph value representing the scene.
    ///   - inputs: The inputs to the scene.
    /// - Returns: The outputs of the scene.
    public static func _makeScene(_ scene: _GraphValue<Window<Content>>, inputs: _SceneInputs) -> _SceneOutputs {
        let body = scene.value.content
        let graph = _GraphValue(body, generation: scene.generation + 1)

        let output = Content._makeShape(graph, inputs: .init(environmentValues: inputs.environmentValues))
        // print(output)

        var source = "solid OpenCAD\n"
        for tri in output.faces {
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

        return .init(shape: scene.value.content, data: data, title: scene.value.title)
    }
}