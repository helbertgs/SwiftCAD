import Foundation

/// A structure that represents a modified content.
public struct ModifiedContent<Content, Modifier> {

    /// The content to be modified.
    public let content: Content

    /// The modifier to be applied to the content.
    public let modifier: Modifier

    /// Creates a new modified content.
    /// - Parameters:
    ///   - content: The content to be modified.
    ///   - modifier: The modifier to be applied to the content.    
    public init(content: Content, modifier: Modifier) {
        self.content = content
        self.modifier = modifier
    }
}

extension ModifiedContent : Shape where Content : Shape, Modifier : ShapeModifier {
    
    /// The body of the shape.
    public var body: Content {
        content
    }

//    /// Creates a new shape from the given graph value and inputs.
//    /// - Parameters:
//    ///   - shape: The graph value representing the shape.
//    ///   - inputs: The inputs for the shape.
//    /// - Returns: The outputs of the shape.
//    public static func _makeShape(_ shape: _GraphValue<ModifiedContent<Content, Modifier>>, inputs: _ShapeInputs) -> _ShapeOutputs {
//        var root = shape
//        let content = shape.value.content
//        let modifier = shape.value.modifier
//
//        let modified = Modifier._makeShape(
//            _GraphValue(modifier),
//            inputs: inputs,
//            body: { graph, inputs in
//                guard let content = graph.root as? _GraphValue<any Shape> else {
//                    return .init()
//                }
//                
//                return _mapShape(content.value, inputs: inputs)
//            }
//        )
//
//        return Content._makeShape(.init(content), inputs: inputs)
//    }

    /// Creates a new shape from the given graph value and inputs.
    /// - Parameters:
    ///   - shape: The graph value representing the shape.
    ///   - inputs: The inputs for the shape.
    /// - Returns: The outputs of the shape.
    public static func _makeShape(_ shape: _GraphValue<ModifiedContent<Content, Modifier>>, inputs: _ShapeInputs) -> _ShapeOutputs {
        let content = shape.value.content
        let modifier = shape.value.modifier
        var newInputs = inputs
        var outputs = _ShapeOutputs()

        let m = Modifier._makeShape(
            _GraphValue(modifier),
            inputs: inputs,
            body: { _, i in
                newInputs = i
                return .init()
            }
        )

        let c = Content._makeShape(.init(content), inputs: newInputs)

        print(m, c)

        return outputs
    }

//    private static func _mapShape<T>(_ shape: T, inputs: _ShapeInputs) -> _ShapeOutputs where T : Shape {
//        T._makeShape(.init(shape), inputs: inputs)
//    }
}
