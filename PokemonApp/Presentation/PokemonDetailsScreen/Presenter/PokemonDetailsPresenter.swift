import Foundation

final class PokemonDetailsPresenter: BasePresenter<PokemonDetailsViewController> {

    private var pokemon: PokemonDetailViewModel!

    init(view: PokemonDetailsViewController, router: Router, pokemon: PokemonDetailViewModel) {
        super.init(view: view, router: router)
        self.pokemon = pokemon

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view?.updateUI(with: pokemon)
    }
}
