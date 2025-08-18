import Foundation

extension Never {
    
    /// The body.
    public var body : Never {
        fatalError("This should never be called")
    }
}