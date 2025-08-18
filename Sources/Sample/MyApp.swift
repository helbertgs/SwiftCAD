import SwiftCAD

@main
struct MyApp : App {
    var body: some Scene {
        Window(title: "Sphere") {
            Union {
                Sphere(radius: 10)
                Cube(size: 10)
            }
        }
    }
}