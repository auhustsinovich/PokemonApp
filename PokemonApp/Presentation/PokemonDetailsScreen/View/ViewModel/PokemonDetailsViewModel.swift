import UIKit
/// Represents a PokemonDetailViewModel.
struct PokemonDetailViewModel: Codable {

    var id: Int = 0
    var name: String = "Name"
    var height: String = "height"
    var weight: String = "weight"
    var types: [String] = ["types","tpes"]
    var abilities: [String] = ["ab", "ab"]
    var commaTypes: String = "commaTypes"
    var commaAbilities: String = "commaAbilities"
    var imageData: Data = Data()

    static func configure(pokemon: PokemonDetail) -> PokemonDetailViewModel {
        var temp = PokemonDetailViewModel()

        temp.id = pokemon.id
        temp.name = pokemon.name

        temp.height = String(pokemon.height)
        temp.weight = String(pokemon.weight)

        temp.types = pokemon.types.compactMap({ $0.type.name })
        temp.abilities = pokemon.abilities.compactMap({ $0.ability.name })

        temp.commaTypes = temp.types.commaSeparated()
        temp.commaAbilities = temp.abilities.commaSeparated()

        if let url = URL(string: pokemon.sprites.frontDefault) {
            do {
                let imageData = try Data(contentsOf: url)
                temp.imageData = imageData
            } catch {
                print(error)
            }
        }

        return temp
    }
}
