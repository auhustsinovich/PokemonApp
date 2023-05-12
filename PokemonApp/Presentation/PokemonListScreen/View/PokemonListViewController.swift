//
//  PokemonListViewController.swift
//  PokemonApp
//
//  Created by Daniil Auhustsinovich on 12.05.23.
//

import UIKit

class PokemonListViewController: BaseViewController {




    @IBOutlet var tableView: UITableView!


    private var pokemons = [Pokemon]() {
        didSet {
            reloadTableView()
        }
    }

    // MARK: - Casting for PokemonListPresenter
    private var pokemonListPresenter: PokemonListPresenter? {
        return presenter as? PokemonListPresenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    func updateView(model: [Pokemon]) {
        pokemons.append(contentsOf: model)
    }

    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // Setup navigation bar
    private func setupNavigationBar() {
        title = "Pokemons"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Navigation bar appearance
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .black
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "pixelmix", size: 30)!]

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: PokemonListCell.identifier, bundle: nil), forCellReuseIdentifier: PokemonListCell.identifier)
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeCell(PokemonListCell.self, for: indexPath) else {
            return UITableViewCell() }

        cell.configure(with: pokemons[indexPath.row])

        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            pokemonListPresenter?.loadMoreData()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
