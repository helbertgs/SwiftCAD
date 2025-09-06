import Foundation

public struct Dimension : CaseIterable, Codable, Equatable, Hashable, OptionSet, Sendable {

    // MARK: - Constants

    /// All dimensions.
    public static var allCases: [Dimension] {
        [.x, .y, .z]
    }

    /// The x-dimension.
    public static let x: Dimension = .init(rawValue: 0)

    /// The y-dimension.
    public static let y: Dimension = .init(rawValue: 1)

    /// The z-dimension.
    public static let z: Dimension = .init(rawValue: 2)

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