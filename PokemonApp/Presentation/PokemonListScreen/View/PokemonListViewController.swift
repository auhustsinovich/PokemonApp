//
//  PokemonListViewController.swift
//  PokemonApp
//
//  Created by Daniil Auhustsinovich on 12.05.23.
//

import UIKit

/// The PokemonListViewController class is responsible for displaying the list of pokemons in a table view and handling the UI interactions. It is a subclass of BaseViewController.
class PokemonListViewController: BaseViewController {

    // MARK: - Internal interface

    @IBOutlet var tableView: UITableView!

    /**
    The method that gets called when the view controller's view is first loaded into memory.
    It calls setupNavigationBar and setupTableView methods to configure the navigation bar and table view respectively.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    /**
     Updates the view with the given array of Pokemon models.

     - Parameter model: An array of Pokemon models to add to the existing list.
     */
    func updateView(model: [Pokemon]) {
        pokemons.append(contentsOf: model)
    }

    ///  Reloads the table view on the main thread.
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - UI elements
    private func setupNavigationBar() {
        title = "Pokemons"
        navigationController?.navigationBar.prefersLargeTitles = true
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

    // MARK: - Private interface
    
    private var pokemons = [Pokemon]() {
        didSet {
            reloadTableView()
        }
    }

    private var pokemonListPresenter: PokemonListPresenter? {
        return presenter as? PokemonListPresenter
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: PokemonListCell.identifier, bundle: nil), forCellReuseIdentifier: PokemonListCell.identifier)
    }
}

// MARK: - Table View Delegate & DataSource

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
