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
    /// The presenter implements several methods from the Presenter protocol, which are called at various points in the view controller lifecycle.
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
