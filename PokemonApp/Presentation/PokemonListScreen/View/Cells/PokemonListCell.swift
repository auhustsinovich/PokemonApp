//
//  PokemonListCell.swift
//  PokemonApp
//
//  Created by Daniil Auhustsinovich on 12.05.23.
//

import UIKit

class PokemonListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView! {
        didSet {
            pokemonImageView.contentMode = .scaleAspectFit
            pokemonImageView.clipsToBounds = true
            pokemonImageView.layer.cornerRadius = pokemonImageView.frame.height / 2
            pokemonImageView.backgroundColor = .white
        }
    }

    private var imageURL: URL? {
        didSet {
            updateImage()
        }
    }

    override func prepareForReuse() {
        nameLabel.text = nil
        pokemonImageView.image = UIImage(named: "pokemonLogo")
    }

    func configure(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        imageURL = pokemon.imageURL
    }

    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { result in
            switch result {
            case .success(let image):
                if imageURL == self.imageURL {
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cacheImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image from cache: ", url.lastPathComponent)
            completion(.success(cacheImage))
            return
        }

        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                print("Image from network: ", url.lastPathComponent)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
