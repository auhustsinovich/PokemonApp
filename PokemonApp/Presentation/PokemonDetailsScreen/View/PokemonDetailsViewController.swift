import UIKit

class PokemonDetailsViewController: BaseViewController {

    // MARK: - Internal interface

    @IBOutlet weak var pokemonImageView: UIImageView!

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!

    /**
    Updates the UI of the PokemonDetailsViewController with the information of a given PokemonDetailViewModel.

    - Parameters:
        - pokemon: The PokemonDetailViewModel object containing the information to display in the details screen.
     */
    func updateUI(with pokemon: PokemonDetailViewModel) {
        title = "#\(pokemon.id)  \(pokemon.name)"
        pokemonNameLabel.text = ("Name: \(pokemon.name)")
        pokemonTypesLabel.text = ("Types: \(pokemon.commaTypes)")
        pokemonAbilitiesLabel.text = ("Abilities: \(pokemon.commaAbilities)")
        pokemonWeightLabel.text = ("Weight: \(pokemon.weight) kg")
        pokemonHeightLabel.text = ("Height: \(pokemon.height) cm")

        guard let pokemonImage = UIImage(data: pokemon.imageData) else {
            return pokemonImageView.image = UIImage(named: "pokemonLogo")
        }
        pokemonImageView.image = pokemonImage
    }

    // MARK: - Private interface

    private var pokemon = PokemonDetailViewModel()  {
        didSet {
            updateUI(with: pokemon)
        }
    }
    private var pokemonDetailsPresenter: PokemonDetailsPresenter? {
        return presenter as? PokemonDetailsPresenter
    }
}
