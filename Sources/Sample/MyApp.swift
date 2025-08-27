import SwiftCAD

@main
struct MyApp : App {
    var body: some Scene {
        Window(title: "SwiftCAD") {
            Union {
                Cube(size: 5)
                    .scale(width: 10, height: 10, depth: 10)
                    .rotate(.init(x: 0, y: 90, z: 0, w: 1))

                Sphere(radius: 15)
                    .translate(x: 20, y: 20, z: 20)
            }
        }
    }
}