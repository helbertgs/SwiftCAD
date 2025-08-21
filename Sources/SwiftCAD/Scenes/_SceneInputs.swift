import Spatial

public struct _SceneInputs {
    var environmentValues: EnvironmentValues
    var seed: Int = 0

    public init(environmentValues: EnvironmentValues = .init(), seed: Int = 0) {
        self.environmentValues = environmentValues
        self.seed = seed
    }
}
