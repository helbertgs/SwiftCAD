import Foundation

/// A structure representing a graph.
public struct _Graph {

    /// The root value of the graph.
    let root: Any

    /// Creates a new graph with the given root value.
    /// 
    /// - Parameter root: The root value of the graph.
    init(_ root: Any) {
        self.root = root
    }
}