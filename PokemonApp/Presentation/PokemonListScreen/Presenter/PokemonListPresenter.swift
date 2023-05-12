import UIKit

private enum Defaults {
    static let error = "Connection error"
    static let dataErrorMessage = "Failed getting data, try again later."
    static let connectErrorMessage = "No internet connection, try again later."
}

final class PokemonListPresenter: BasePresenter<PokemonListViewController> {

    private var pokemons = [Pokemon]()
    private var page = 1

    override init(view: PokemonListViewController, router: Router) {
        super.init(view: view, router: router)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemons()
    }

    func getPokemons() {
        pokemons.removeAll()

        DispatchQueue.global().async {

            self.getData(from: .pokemonList(page: self.page)) { result in
                switch result {
                case .success(let data):
                    self.fillPokemonsList(with: data)
                    self.page += 1
                case .failure(let error):
                    print(error)
                    // TODO: ALLERTS
                }
            }
        }
    }

    func loadMoreData() {
        self.getData(from: .pokemonList(page: self.page)) { result in
            switch result {
            case .success(let data):
                self.fillPokemonsList(with: data)
                self.page += 1
            case .failure(let error):
                print(error)
                // TODO: ALLERTS
            }
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

}
