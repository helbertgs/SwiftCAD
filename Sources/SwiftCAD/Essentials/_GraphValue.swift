import Foundation

/// A wrapper for values in a graph.
public struct _GraphValue<Value> {

    /// The wrapped value.
    public let value: Value

    /// Initializes a new graph value with the given value.
    /// - Parameter value: The value to wrap.
    public init(_ value: Value) {
        self.value = value
    }

    /// Accesses a value in the graph using a key path.
    public subscript<U>(keyPath: KeyPath<Value, U>) -> _GraphValue<U> {
        get { .init(value[keyPath: keyPath]) }
    }
}