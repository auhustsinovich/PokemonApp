import Foundation

/// Inherits from BasePresenter and is responsible for updating the UI of the PokemonDetailsViewController with the information of a given PokemonDetailViewModel.
final class PokemonDetailsPresenter: BasePresenter<PokemonDetailsViewController> {

    private var pokemon: PokemonDetailViewModel!

    init(view: PokemonDetailsViewController, router: Router, pokemon: PokemonDetailViewModel) {
        super.init(view: view, router: router)
        self.pokemon = pokemon

    }

    /// The viewDidLoad function is an overridden function of the BasePresenter class and is called when the view controller is loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.updateUI(with: pokemon)
    }
}
