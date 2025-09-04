# SwiftCAD

SwiftCAD is an open-source library written in **Swift** for creating 3D models.  
It introduces a **declarative DSL**, inspired by functional and UI-driven approaches like **SwiftUI**, to design 3D geometries in an expressive and Swift-native way.

With SwiftCAD you can build solids, perform boolean operations (union, difference, intersection), apply transformations (translate, rotate, scale), and compose 3D models elegantly.

---

## ✨ Goals

- Provide a **declarative DSL** for 3D modeling.  
- Enable expressive and composable geometry definitions.  
- Integrate naturally with the Swift ecosystem.  
- Be fully **open-source** and community-driven.  

---

## 🚀 Example

```swift
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
```

### 📦 Installation

Add SwiftCAD to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/helbertgs/SwiftCAD.git", branch: "main")
]
```

###  🤝 Contributing

SwiftCAD is a community project, and contributions are welcome!
To get started, please check the [Contributing Guide]().

### 📄 License

This project is licensed under the MIT License, which is simple, permissive, and widely adopted in open-source software.
You are free to use, modify, and distribute it as long as you give proper credit.
👉 MIT License