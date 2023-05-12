//
//  Array.swift
//  PokemonApp
//
//  Created by Daniil Auhustsinovich on 12.05.23.
//

import Foundation
/// An extension to Array that provides a convenient way to join an array of Strings with commas.
extension Array where Element == String {
    func commaSeparated() -> String {
        return self.joined(separator: ", ")
    }
}

