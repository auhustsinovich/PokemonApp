import Foundation

/// Available API endpoints.
enum EndpointAPI {
    /// The endpoint for the PokeAPI List.
    case pokemonList(page: Int)
    /// The endpoint for the PokeAPI Details.
    case pokemonDetail(id: Int)

    /// Returns a string containing the base URL for the selected API endpoint.
    var baseURL: String {
        return "https://pokeapi.co/api/v2/"
    }

    /// Returns a string containing the path for the selected API endpoint.
    var path: String {
        switch self {
        case .pokemonList:
            return "pokemon?limit=20&offset="
        case let .pokemonDetail(id):
            return "pokemon/\(id)"
        }
    }
}
