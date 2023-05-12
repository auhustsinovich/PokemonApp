import UIKit
/// This is a generic base presenter class that conforms to the Presenter protocol.
class BasePresenter<V: UIViewController>: Presenter {
    /// The generic type parameter V must be a subclass of UIViewController and will be used as the associated view for the presenter.
    weak var view: V?
    /// The presenter has a weak reference to the view to prevent retain cycles, and a reference to a Router object for navigating between screens.
    var router: Router
    /// The init method initializes the presenter with a view and router object.
    init(view: V, router: Router) {
        self.view   = view
        self.router = router
    }

    // MARK: Lifecycle methods

    /// The viewDidLoad() method is called after the controller's view has been loaded into memory.
    func viewDidLoad() {}

    /// The viewWillAppear(_:) method is called just before the view controller's view is about to be added to the view hierarchy.
    func viewWillAppear() {}

    /// The viewDidAppear(_:) method is called after the view controller's view has been added to the view hierarchy.
    func viewDidAppear() {}

    /// The viewWillDisappear(_:) method is called just before the view controller's view is removed from the view hierarchy.
    func viewWillDisappear() {}

    /// The viewDidDisappear(_:) method is called after the view controller's view has been removed from the view hierarchy.
    func viewDidDisappear() {}
}
