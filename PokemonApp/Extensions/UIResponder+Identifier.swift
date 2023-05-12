import UIKit
/// Extension on UIResponder to get a unique identifier for the class.
extension UIResponder {
    /// Returns a unique identifier for the class as a string.
    static var identifier: String {
        String(describing: self)
    }
}
