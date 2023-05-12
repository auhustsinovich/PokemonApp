//
//  PokemonDetailsViewController.swift
//  PokemonApp
//
//  Created by Daniil Auhustsinovich on 12.05.23.
//

import UIKit

class PokemonDetailsViewController: BaseViewController {

    @IBOutlet weak var pokemonImageView: UIImageView!

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!

    private var pokemon = PokemonDetailViewModel()  {
        didSet {
            updateUI(with: pokemon)
        }
    }
    private var pokemonDetailsPresenter: PokemonDetailsPresenter? {
        return presenter as? PokemonDetailsPresenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateUI(with pokemon: PokemonDetailViewModel) {
        title = "#\(pokemon.id)  \(pokemon.name)"
        pokemonNameLabel.text = ("Name: \(pokemon.name)")
        pokemonTypesLabel.text = ("Types: \(pokemon.commaTypes)")
        pokemonAbilitiesLabel.text = ("Abilities: \(pokemon.commaAbilities)")
        pokemonWeightLabel.text = ("Weight: \(pokemon.weight) kg")
        pokemonHeightLabel.text = ("Weight: \(pokemon.height) cm")

        guard let pokemonImage = UIImage(data: pokemon.imageData) else {
            return pokemonImageView.image = UIImage(named: "pokemonLogo")
        }
        pokemonImageView.image = pokemonImage
    }
}
