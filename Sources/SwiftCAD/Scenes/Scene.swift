import Foundation

/// A part of an app’s user interface with a life cycle managed by the system.
public protocol Scene {

    // MARK: - Creating a scene
    
    /// The type of scene that represents the body of this scene.
    associatedtype Body : Scene

    /// The content and behavior of the scene.
    @SceneBuilder var body: Self.Body { get }

    /// Creates a new scene from the given graph value and inputs.
    /// - Parameters:
    ///   - scene: The graph value representing the scene.
    ///   - inputs: The inputs to the scene.
    /// - Returns: The outputs of the scene.
    static func _makeScene(_ scene: _GraphValue<Self>, inputs: _SceneInputs) -> _SceneOutputs
}