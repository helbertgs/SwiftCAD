import Foundation

/// The Inputs for the shape.
public struct _ShapeInputs {

    /// The environment values for the shape.
    var environmentValues: EnvironmentValues

    /// The generation of the shape.
    var generation: Int = 0

    /// Creates a new shape inputs.
    /// 
    /// - Parameters:
    ///   - environmentValues: The environment values for the shape.
    ///   - generation: The generation of the shape.
    init(environmentValues: EnvironmentValues = .default, generation: Int = 0) {
        self.environmentValues = environmentValues
        self.generation = generation
    }
}
