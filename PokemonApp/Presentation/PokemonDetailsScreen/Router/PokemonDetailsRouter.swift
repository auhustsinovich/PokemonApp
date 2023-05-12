import UIKit

private let pokemonDetailsStoryboardName = "PokemonDetailsStoryboard"

extension Router {
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

    func goToDetailsScreen(pokemon: PokemonDetailViewModel) {
        if let view = view as? PokemonListViewController {
            let viewController = initDetailsScreen(pokemon: pokemon)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
