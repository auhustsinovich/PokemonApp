import UIKit

private enum Defaults {
    static let closeButtonTitle = "Close"
    static let cancelButtonTitle = "Cancel"
    static let okButtonTitle = "Ok"
    static let confirmButtonTitle = "Confirm"
    static let retryButtonTitle = "Retry"
    static let logoutButtonTitle = "Logout"
}
/// Struct for displaying alerts in a view controller.
struct Alert {
    /**
     Displays an alert on the given view controller with the specified title, message and alert type.

     - Parameters:
        - viewController: The view controller to display the alert on.
        - title: The title of the alert.
        - message: The message of the alert.
        - type: The type of the alert, defaults to `.close`.

     - Remark:
     The `type` parameter determines the type of actions available on the alert. Available types are `.close`, `.ok`, `.confirm`, `.retry` and `.logout`.
     */
    static func show(on viewController: UIViewController?,
                     title: String,
                     message: String,
                     type: AlertType = .close) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in type.actions {
            alert.addAction(action.alertAction)
        }
        DispatchQueue.main.async {
            viewController?.present(alert, animated: true)
        }
    }
    /// An enum defining the different types of alerts available. Each type can have different types of actions.
    enum AlertType {
        case close
        case ok(handler: (() -> Void)? = nil)
        case confirm(handler: (() -> Void)?)
        case retry(handler: (() -> Void)?)
        case logout(handler: (() -> Void)?)
        ///Returns an array of actions for the given alert type.
        var actions: [Action] {
            switch self {
            case .close: return [Action.close]
            case let .ok(handler): return [Action.ok(handler: handler)]
            case let .confirm(handler): return [Action.cancel, Action.confirm(handler: handler)]
            case let .retry(handler): return [Action.cancel, Action.retry(handler: handler)]
            case let .logout(handler): return [Action.cancel, Action.logout(handler: handler)]
            }
        }
    }
    /// An enum defining the different types of actions available on an alert.
    enum Action {
        case close
        case cancel
        case ok(handler: (() -> Void)?)
        case confirm(handler: (() -> Void)?)
        case retry(handler: (() -> Void)?)
        case logout(handler: (() -> Void)?)

        private var title: String {
            switch self {
            case .close: return Defaults.closeButtonTitle
            case .cancel: return Defaults.cancelButtonTitle
            case .ok: return Defaults.okButtonTitle
            case .confirm: return Defaults.confirmButtonTitle
            case .retry: return Defaults.retryButtonTitle
            case .logout: return Defaults.logoutButtonTitle
            }
        }

        private var style: UIAlertAction.Style {
            switch self {
            case .cancel: return .cancel
            default: return .default
            }
        }

        private var handler: (() -> Void)? {
            switch self {
            case .close: return nil
            case .cancel: return nil
            case let .ok(handler): return handler
            case let .confirm(handler): return handler
            case let .retry(handler): return handler
            case let .logout(handler): return handler
            }
        }
        /// Returns a `UIAlertAction` object for the action.
        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: style, handler: { _ in
                if let handler = self.handler {
                    handler()
                }
            })
        }
    }
}

