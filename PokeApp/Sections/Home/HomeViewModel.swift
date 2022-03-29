//
//  HomeViewModel.swift
//  PokeApp
//
//  Created by Usr_Prime on 23/03/22.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func setName(to name: String)
    func pokemonFound()
    func pokemonNoFound()
}

class HomeViewModel {
    var delegate: HomeViewDelegate?
    var selectedPokemon: PokemonAPIResponse?
    var nameUser: String?
    
    func updateData(){
        self.delegate?.setName(to: nameUser!)
    }
    func searchPokemon(by name: String) {
        let lowerCasedName = name.lowercased()
        let whiteSpacesName = lowerCasedName.trimmingCharacters(in: .whitespaces)
        PokemonAPI.shared.getPokemonData(pokemon: "\(whiteSpacesName)") { result in
            switch result {
            case .success(let pokemon):
                print(pokemon)
                self.selectedPokemon = pokemon
                self.delegate?.pokemonFound()
            case .failure(_):
                self.delegate?.pokemonNoFound()
            }
        }
    }
}
