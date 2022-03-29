//
//  DetalheViewModel.swift
//  PokeApp
//
//  Created by Usr_Prime on 24/03/22.
//

import UIKit

enum SegmentedControlOptions: Int {
    case About = 0
    case BaseStats = 1
    case Moves = 2
}
enum PokemonTypes: String {
    case Bug = "bug"
    case Fire =  "fire"
    case Normal = "normal"
    case Dark = "dark"
    case Flying = "flying"
    case Poison = "poison"
    case Dragon = "dragon"
    case Ghost = "ghost"
    case Psychic = "psychic"
    case Electric = "electric"
    case Grass = "grass"
    case Rock = "rock"
    case Fairy = "fairy"
    case Ground = "ground"
    case Steel = "steel"
    case Fighting = "fighting"
    case Ice = "ice"
    case Water = "water"
}
protocol DetalheViewDelegate: AnyObject {
    func setupHeader(name: String, type: PokemonTypes, image: String, id: Int)
    func setupAbout(species: String, height: String, weight: String, abilities: String)
    func setupBaseStatus(stats: [Stats])
    func reloadData()
}

class DetalheViewModel {
    var delegate: DetalheViewDelegate?
    var pokemonDetails: PokemonAPIResponse?
    
    func setupData(){
        guard let pokeDetails = pokemonDetails else { return }
        guard let namePokemon = pokemonDetails?.forms[0].name else { return }
        guard let types = PokemonTypes(rawValue: pokeDetails.types[0].type.name) else { return }
        var abilitities = "\(pokeDetails.abilities[0].ability.name.replacingOccurrences(of: "-", with: " ").capitalized)"
        if (pokeDetails.abilities.count > 1) {
            abilitities = "\(pokeDetails.abilities[0].ability.name.replacingOccurrences(of: "-", with: " ").capitalized), \(pokeDetails.abilities[1].ability.name.replacingOccurrences(of: "-", with: " ").capitalized)"
        }
        
        self.delegate?.setupHeader(name: namePokemon, type: types, image: pokeDetails.sprites.other.home.front_default, id: pokeDetails.id)
        self.delegate?.setupAbout(species: namePokemon, height: formattedNumber(pokeDetails.height), weight: formattedNumber(pokeDetails.weight), abilities: abilitities)
        self.delegate?.setupBaseStatus(stats: pokeDetails.stats)
    }
    func formattedNumber(_ value: Int) -> String {
        let numberString = "\(value)"
        if numberString.count > 1 {
            return String(numberString.dropLast())
        }
        return numberString
    }
    func getColorFor(type: PokemonTypes) -> UIColor {
        switch type {
        case .Fire:
            return UIColor(red: 0.67, green: 0.12, blue: 0.14, alpha: 1.00)
        case .Bug:
            return UIColor(red: 0.11, green: 0.29, blue: 0.15, alpha: 1.00)
        case .Normal:
            return UIColor(red: 0.45, green: 0.33, blue: 0.38, alpha: 1.00)
        case .Dark:
            return UIColor(red: 0.02, green: 0.03, blue: 0.02, alpha: 1.00)
        case .Flying:
            return UIColor(red: 0.29, green: 0.40, blue: 0.49, alpha: 1.00)
        case .Poison:
            return UIColor(red: 0.37, green: 0.17, blue: 0.54, alpha: 1.00)
        case .Dragon:
            return UIColor(red: 0.27, green: 0.55, blue: 0.58, alpha: 1.00)
        case .Ghost:
            return UIColor(red: 0.20, green: 0.20, blue: 0.42, alpha: 1.00)
        case .Psychic:
            return UIColor(red: 0.64, green: 0.16, blue: 0.42, alpha: 1.00)
        case .Electric:
            return UIColor(red: 0.89, green: 0.89, blue: 0.17, alpha: 1.00)
        case .Grass:
            return UIColor(red: 0.08, green: 0.48, blue: 0.24, alpha: 1.00)
        case .Rock:
            return UIColor(red: 0.28, green: 0.09, blue: 0.04, alpha: 1.00)
        case .Fairy:
            return UIColor(red: 0.59, green: 0.10, blue: 0.27, alpha: 1.00)
        case .Ground:
            return UIColor(red: 0.66, green: 0.44, blue: 0.17, alpha: 1.00)
        case .Steel:
            return UIColor(red: 0.37, green: 0.46, blue: 0.43, alpha: 1.00)
        case .Fighting:
            return UIColor(red: 0.60, green: 0.25, blue: 0.15, alpha: 1.00)
        case .Ice:
            return UIColor(red: 0.53, green: 0.82, blue: 0.96, alpha: 1.00)
        case .Water:
            return UIColor(red: 0.08, green: 0.32, blue: 0.89, alpha: 1.00)
        }
    }
}
