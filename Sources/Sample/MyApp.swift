import SwiftCAD

@main
struct MyApp : App {
    var body: some Scene {
        Window(title: "Sphere") {
            Union {
                Cube(size: 20)
                Sphere(radius: 12)
            }
        }
    }
}