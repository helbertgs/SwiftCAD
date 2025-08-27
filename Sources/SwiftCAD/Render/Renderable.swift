import Foundation

protocol Renderable {
    func render<T>(_ shape: T) -> Any where T : Shape
}