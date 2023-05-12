import UIKit
/// This class is a base class for view controllers in an iOS application.
class BaseViewController: UIViewController {
    /// Property that is used to manage the presentation logic for the associated view controller.
    var presenter: Presenter?
    /// This method is called when the view finishes loading and is used for initializing the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    /// This method is called when the view is about to become visible and before it is added to the screen, and is used for performing actions before the view appears.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    /// This method is called when the view appears on the screen and is fully visible, and is used for performing actions after the view appears.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    /// This method is called when the view is being hidden or removed from the navigation stack, and is used for performing actions before the view is hidden.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    /// This method is called when the view is fully hidden or removed from the navigation stack, and is used for performing actions after the view is hidden.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
    }
}
