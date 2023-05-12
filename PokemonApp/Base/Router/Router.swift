import UIKit
/// The Router class manages navigation and screen transitions for an iOS application.
final class Router {
    fileprivate(set) weak var view: UIViewController?
/// The init method initializes the Router with a view controller, which is stored as a weak reference for later use.
    init(view: UIViewController) {
        self.view = view
    }
    /// This  method dismisses the current view controller,
    func dismissScreen() {
        view?.dismiss(animated: true)
    }
    /// This  method pops the current view controller off the navigation stack.
    func popCurrentScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
    /// This  method accesses the application delegate and the root view controller of the window.
    func dismissAllViewViewControllers() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
            (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
        }
    }
}
