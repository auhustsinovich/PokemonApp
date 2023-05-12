import UIKit
@main
/// The application delegate class is responsible for initializing the app and setting up the app's windows and root view controller.
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /**
     Called after the app finishes launching.

     - Parameters:
        - application: The singleton app object.
        - launchOptions: A dictionary indicating the reason the app was launched (if any).

     - Returns: `true` if the app launched successfully, otherwise `false`.
     */
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let pokemonListViewController = Router.initPokemonListScreen()
        let navigationController = UINavigationController(rootViewController: pokemonListViewController)
        navigationController.isNavigationBarHidden = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

