import Foundation

extension Never : Scene {

    /// Creates a new scene from the given graph value and inputs.
    /// - Parameters:
    ///   - scene: The graph value representing the scene.
    ///   - inputs: The inputs to the scene.
    /// - Returns: The outputs of the scene.
    public static func _makeScene(_ scene: _GraphValue<Never>, inputs: _SceneInputs) -> _SceneOutputs {
        fatalError("Never scene cannot be created")
    }
}