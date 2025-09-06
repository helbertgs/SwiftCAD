import Swift

/// A type that represents measurement units.
@frozen public enum Unit {

    /// Millimeters
    case mm

    /// Centimeters
    case cm

    // Meters
    case m

    // Inches
    case `in`

    // Feet
    case ft
}

@frozen public struct UnitKey : EnvironmentKey {
    public static var defaultValue: Unit {
        .mm
    }
}

extension EnvironmentValues {
    /// A Boolean value that indicates whether the view associated with this
    /// environment allows user interaction.
    ///
    /// The default value is `true`.
    public var unit: Unit {
        get { self[UnitKey.self] }
        set { self[UnitKey.self] = newValue }
    }
}
