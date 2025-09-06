import Foundation

/// Constants that describe an axis.
@frozen public struct Axis: Codable, Equatable, Hashable, RawRepresentable, Sendable {

    // MARK: - Constants

    /// The operation is along the x-axis.
    public static let x: Axis = .init(rawValue: 0)

    /// The operation is along the y-axis.
    public static let y: Axis = .init(rawValue: 1)

    /// The operation is along the z-axis.
    public static let z: Axis = .init(rawValue: 2)

    // MARK: - Accessing the Raw Value

    /// The corresponding value of the raw type.
    public let rawValue: Int

    // MARK: - Creating a Value

    /// Creates a new instance with the specified raw value.
    /// 
    /// - Parameter rawValue: The raw value to use for the new instance.
    @inlinable public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}