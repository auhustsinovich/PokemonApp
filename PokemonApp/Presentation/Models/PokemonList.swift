import Foundation
/// A struct representing a list of Pokemon.
struct PokemonList: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String

    var id: Int? {
        return Int(url.split(separator: "/").last?.description ?? "0")
    }

    var imageURL: URL? {
        return URL(string: "\(CommonDefaultValues.imageUrl)\(id ?? 0).png")
    }
}
