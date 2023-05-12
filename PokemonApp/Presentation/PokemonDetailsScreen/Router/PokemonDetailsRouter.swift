import UIKit

private let pokemonDetailsStoryboardName = "PokemonDetailsStoryboard"

/// The Router extension provides internal and private interfaces to navigate to the details screen of a given Pokemon.
extension Router {

    // MARK: - Internal interface

    /**
    Navigates to the details screen of a given Pokemon and pushes it onto the navigation stack of the current view controller, if the current view is a PokemonListViewController.

    - Parameters:
        - pokemon: The PokemonDetailViewModel object containing the information to display in the details screen.
    */
    func goToDetailsScreen(pokemon: PokemonDetailViewModel) {
        if let view = view as? PokemonListViewController {
            let viewController = initDetailsScreen(pokemon: pokemon)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    // MARK: - Private interface

    private func initDetailsScreen(pokemon: PokemonDetailViewModel) -> PokemonDetailsViewController {
        let storyboard = UIStoryboard(name: pokemonDetailsStoryboardName, bundle: nil)

        guard let view = storyboard.instantiateInitialViewController() as? PokemonDetailsViewController else {
            return PokemonDetailsViewController()
        }

        let router = Router(view: view)
        let presenter = PokemonDetailsPresenter(view: view, router: router, pokemon: pokemon)
        view.presenter = presenter
        return view
    }
}
