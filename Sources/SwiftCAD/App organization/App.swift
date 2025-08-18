import Foundation

/// A type that represents the structure and behavior of an app.
public protocol App {

    // MARK: - Implementing an app

    /// The type of scene representing the content of the app.
    /// 
    /// When you create a custom app, Swift infers this type from your implementation of the required body property.
    associatedtype Body : Scene

    /// The content and behavior of the app.
    @SceneBuilder var body: Self.Body { get }

    // MARK: - Running an app

    /// Creates an instance of the app using the body that you define for its content.
    /// 
    /// Swift synthesizes a default initializer for structures that don’t provide one. 
    /// You typically rely on the default initializer for your app.
    init()

    /// Initializes and runs the app.
    /// 
    /// If you precede your App conformer’s declaration with the @main attribute, the system calls the conformer’s main() method to launch the app.
    /// OpenCAD provides a default implementation of the method that manages the launch process in a platform-appropriate way.
    static func main()
}

extension App {

    /// The default implementation of the main method that runs the app.
    public static func main() {
        let app = Self()
        let scene = app.body
        let outputs = Self.Body._makeScene(.init(scene), inputs: .init())
  
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(outputs.title).stl") {
            try? outputs.data.write(to: url, options: .atomic)
            print("STL file written to \(url.path)")
        } else {
            print("Failed to create output URL.")
        }
    }
}