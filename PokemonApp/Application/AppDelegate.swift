//
//  AppDelegate.swift
//  PokemonApp
//
//  Created by Daniil Auhustsinovich on 12.05.23.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let pokemonListViewController = Router.initPokemonListScreen()
        let navigationController = UINavigationController(rootViewController: pokemonListViewController)
        navigationController.isNavigationBarHidden = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

