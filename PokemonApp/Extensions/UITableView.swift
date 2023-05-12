import UIKit
/**
An extension to simplify the process of dequeuing a table view cell with a specific type from the table view.

Returns: The dequeued cell, or nil if no cell is available for reuse.

Parameters:

classType: The type of the cell to dequeue.
indexPath: The index path specifying the location of the cell in the table view.
Note: The T type parameter must conform to the UITableViewCell protocol and have a static identifier property of type String.
*/
extension UITableView {
    func dequeCell<T: UITableViewCell>(_ classType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
}

