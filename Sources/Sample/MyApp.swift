import SwiftCAD

@main
struct MyApp : App {
    var body: some Scene {
        Window(title: "SwiftCAD") {
            Cube(size: 20)
                .custom()
        }
    }
}