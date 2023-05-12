import Foundation

/// Represents a PokemonDetail model.
struct PokemonDetail: Decodable {

    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let abilities: [Abilities]
    let types: [Types]
    let forms: [Form]
    let sprites: Sprites

    var idString: String { String(describing: id) }

    init(id: Int = 0,
         name: String = "",
         height: Int = 0,
         weight: Int = 0,
         abilities: [Abilities] = [],
         types: [Types] = [],
         forms: [Form] = [],
         sprites: Sprites = Sprites(frontDefault: "") ) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.abilities = abilities
        self.types = types
        self.forms = forms
        self.sprites = sprites
    }
}

struct Abilities: Decodable {
    let ability: Ability
}

struct Ability: Decodable {
    let name: String
}

struct Types: Decodable {
    let type: TypeOf
}

struct TypeOf: Decodable {
    let name: String
}

struct Form: Decodable {
    let name: String
}

struct Sprites: Decodable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

