import UIKit

private let pokemonListStoryboardName = "PokemonListStoryboard"

extension Router {
    static func initPokemonListScreen() -> PokemonListViewController {
        let storyboard = UIStoryboard(name: pokemonListStoryboardName, bundle: nil)
        guard let navigationView = storyboard.instantiateInitialViewController() as? UINavigationController,
              let view = navigationView.topViewController as? PokemonListViewController
        else {
            return PokemonListViewController()
        }

        let router = Router(view: view)
        let presenter = PokemonListPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
