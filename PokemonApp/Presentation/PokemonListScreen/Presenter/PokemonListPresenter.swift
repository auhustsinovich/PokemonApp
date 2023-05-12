import UIKit

private enum Defaults {
    static let error = "Connection error"
    static let dataErrorMessage = "Failed getting data, try again later."
    static let connectErrorMessage = "No internet connection, try again later."
}

/// The presenter for the Pokemon list screen.
final class PokemonListPresenter: BasePresenter<PokemonListViewController> {
    
    // MARK: - Internal interface

    /**
     Initializes the Pokemon list presenter with the given view and router.

     - Parameter view: The view that this presenter will manage.
     - Parameter router: The router that this presenter will use to navigate to other screens.
    */
    override init(view: PokemonListViewController, router: Router) {
        super.init(view: view, router: router)
    }

    /// Called when the view is loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemons()
    }

    /**
     Retrieves the list of Pokemon from the API and displays it in the view.

     This function clears the `pokemons` array and retrieves a new list of Pokemon from the API. If the retrieval is successful, the `fillPokemonsList(with:)` function is called to update the `pokemons` array with the new data and display it in the view.

     - Note: This function is called automatically when the view is loaded. To manually refresh the list of Pokemon, call this function again.
    */
    func getPokemons() {
        pokemons.removeAll()

        DispatchQueue.global().async {

            self.getData(from: .pokemonList(page: self.page)) { result in
                switch result {
                case .success(let data):
                    self.fillPokemonsList(with: data)
                    self.page += 1
                case .failure(let error):
                    Alert.show(on: self.view, title: Defaults.error, message: Defaults.connectErrorMessage)
                    print(error)
                }
            }
        }
    }

    /**
     Retrieves more Pokemon data from the API and displays it in the view.

     This function retrieves the next page of Pokemon data from the API and updates the `pokemons` array with the new data. If the retrieval is successful, the `fillPokemonsList(with:)` function is called to display the new data in the view.

     - Note: This function should be called when the user scrolls to the bottom of the list and wants to load more Pokemon.
    */
    func loadMoreData() {
        self.getData(from: .pokemonList(page: self.page)) { result in
            switch result {
            case .success(let data):
                self.fillPokemonsList(with: data)
                self.page += 1
            case .failure(let error):
                Alert.show(on: self.view, title: Defaults.error, message: Defaults.connectErrorMessage)
                print(error)
            }
        }
    }

    // MARK: - Private interface

    private var pokemons = [Pokemon]()
    private var page = 1
    private var pokemonDetailsViewModel = PokemonDetailViewModel()
    private var pokemonDetails: PokemonDetail! {
        didSet {
            pokemonDetailsViewModel = configureViewModel(pokemon: self.pokemonDetails)
        }
    }
    private func fillPokemonsList(with data: Data) {
        do {
            let pokemonsList = try JSONDecoder().decode(PokemonList.self, from: data)
            print("Pokemons: \(pokemonsList.results.count)")
            self.view?.updateView(model: pokemonsList.results)
            pokemonsList.results.forEach { pokemon in
                let pokemonViewData = Pokemon(name: pokemon.name , url: pokemon.url)
                self.pokemons.append(pokemonViewData)
            }
        } catch {
            print(error)
        }
    }

    private func getData(from endpoint: EndpointAPI, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.sendRequest(endpoint: endpoint, page: self.page) { result in
            switch result {
            case .success(let data):
                print("\(endpoint) data received: \(data)")
                completionHandler(.success(data))
            case .failure(let error):
                print("\(endpoint) error: \(error)")
                completionHandler(.failure(error))
            }
        }
    }

    private func updatePokemonList(with newList: [Pokemon]) {
        self.pokemons.removeAll()
        self.pokemons = newList
    }

    func showPokemonInfo(with index: Int) {
        DispatchQueue.global().async {
            self.getData(from: .pokemonDetail(id: index)) { result in
                switch result {
                case .success(let data):
                    self.fillPokemonDetails(with: data)
                    if self.pokemonDetails != nil {
                        DispatchQueue.main.async {
                            self.router.goToDetailsScreen(pokemon: self.pokemonDetailsViewModel)
                        }
                    }

                case .failure(let error):
                    print(error)
                    Alert.show(on: self.view, title: Defaults.error, message: Defaults.dataErrorMessage)
                }
            }
        }
    }

    private func fillPokemonDetails(with data: Data) {
        do {
            let details = try JSONDecoder().decode(PokemonDetail.self, from: data)
            self.pokemonDetails = details
        } catch {
            print(error)
        }
    }

    private func configureViewModel(pokemon: PokemonDetail) -> PokemonDetailViewModel {
        PokemonDetailViewModel.configure(pokemon: pokemon)
    }
}
