import Foundation

/// A wrapper for values in a graph.
public struct _GraphValue<Value> {

    /// The unique identifier for the graph value.
    var id: UUID = UUID()

    /// The wrapped value.
    var value: Value

    /// The generation of the graph value.
    var generation: Int = 0

    /// The children of the graph value.
    var children: [_GraphValue<any Shape>]

    /// Initializes a new graph value with the given parameters.
    /// 
    /// - Parameters:
    ///   - value: The value to wrap.
    ///   - generation: The generation of the graph value.
    ///   - children: The children of the graph value.
    init(_ value: Value, generation: Int = 0, children: [_GraphValue<any Shape>] = []) {
        self.value = value
        self.generation = generation
        self.children = children
    }

    /// Accesses a value in the graph using a key path.
    subscript<U>(keyPath: KeyPath<Value, U>) -> _GraphValue<U> {
        get { .init(value[keyPath: keyPath], generation: generation + 1) }
    }
}
