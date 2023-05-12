/// The `ViewLifecycleDelegate` protocol defines a set of methods that a class implementing it can use to respond to the different lifecycle events of a `UIViewController`.
protocol ViewLifecycleDelegate: AnyObject {

    /// This method is called when the view finishes loading.
    func viewDidLoad()

    /// This method is called when the view is about to become visible.
    func viewWillAppear()

    /// This method is called when the view appears on the screen and is fully visible.
    func viewDidAppear()

    /// This method is called when the view is being hidden or removed from the navigation stack.
    func viewWillDisappear()

    /// This method is called when the view is fully hidden or removed from the navigation stack.
    func viewDidDisappear()
}
