import Swift

/// A collection of environment values propagated through the hierarchy.
public struct EnvironmentValues : CustomStringConvertible {

    // MARK: - Type Alias.

    private typealias PropertyList = [AnyEnvironmentPropertyKey]

    // MARK: - Private Property(ies).

    private var _plist: PropertyList

    /// Creates an environment values instance.
    public init() {
        _plist = PropertyList()
    }

    // MARK: - Public Subscript(s).

    /// Accesses the environment value associated with a custom key.
    public subscript<K>(key: K.Type) -> K.Value where K : EnvironmentKey {
        get {
            _plist
                .filter { type(of: $0) == EnvironmentPropertyKey<K>.self }
                .map { $0 as! EnvironmentPropertyKey<K> }
                .map { $0.value }
                .last ?? K.defaultValue

        }
        set {
            _plist.append(EnvironmentPropertyKey<K>(newValue))
        }
    }

    // MARK: - Custom String Convertible

    /// A string that represents the contents of the environment values
    /// instance.
    public var description: String {
        let elements = _plist
            .compactMap { $0 as? CustomStringConvertible }
            .compactMap { $0.description }
            .joined(separator: ",")

        return "[\(elements)]"
    }
}

extension EnvironmentValues {
    nonisolated(unsafe) static let `default` = EnvironmentValues()
}
