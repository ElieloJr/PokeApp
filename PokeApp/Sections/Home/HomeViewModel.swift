//
//  HomeViewModel.swift
//  PokeApp
//
//  Created by Usr_Prime on 23/03/22.
//

import SwiftUI
import CoreData

protocol HomeViewDelegate: AnyObject {
    func setName(to name: String)
    func pokemonFound()
    func pokemonNoFound()
    func reloadData()
}

class HomeViewModel {
    var delegate: HomeViewDelegate?
    var selectedPokemon: PokemonAPIResponse?
    var nameUser: String?
    var recentList: [RecentPokemonList] = []
    
    func updateData(){
        self.delegate?.setName(to: nameUser!)
        self.fetch()
        self.delegate?.reloadData()
    }
    func getPokemonList() -> [RecentPokemonList] {
        return self.recentList
    }

    private func searchPokemonByTerm(_ term: String, canSaveData: Bool) {
        PokemonAPI.shared.getPokemonData(pokemon: "\(term)") { result in
            switch result {
            case .success(let pokemon):
                self.selectedPokemon = pokemon
                self.delegate?.pokemonFound()
                
                if canSaveData {
                    self.saveRecentSearch(pokemon: pokemon) { (result) in
                        switch result {
                        case .success(let finished):
                            if finished {
                                self.fetch()
                                self.delegate?.reloadData()
                            } else { print("Moio") }
                        case .failure(_):
                            print("-->Moio")
                        }
                    }
                }
            case .failure(_):
                self.delegate?.pokemonNoFound()
            }
        }
    }
    func searchPokemonRecent(by id: String) {
        searchPokemonByTerm(id, canSaveData: false)
    }
    func searchPokemonClick(by name: String) {
        let lowerCasedName = name.lowercased()
        let whiteSpacesName = lowerCasedName.trimmingCharacters(in: .whitespaces)
        searchPokemonByTerm(whiteSpacesName, canSaveData: true)
    }
}

extension HomeViewModel {
    
    // Funções do Core Data
    
    func saveRecentSearch(pokemon: PokemonAPIResponse, completion: @escaping (Result<Bool, Error>) -> ()) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                print("--Deu ruim aqui--")
                return
            }
            let menagedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "RecentPokemonList", in: menagedContext)!
            let task = NSManagedObject(entity: entity, insertInto: menagedContext)
            task.setValue(pokemon.forms[0].name, forKey: "name")
            task.setValue("\(pokemon.id)", forKey: "id")
            task.setValue(pokemon.sprites.other.home.front_default, forKey: "urlImage")
            task.setValue(pokemon.types[0].type.name, forKey: "type")
            task.setValue(UUID(), forKey: "identifier")
            
            do {
                try menagedContext.save()
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        }
    }
    func fetch() {
        fetchRecentList { (result) in
            switch result {
            case .success(let recentList):
                self.recentList = recentList
                self.delegate?.reloadData()
            case .failure(_):
                print("Não deu certo")
            }
        }
    }
    func fetchRecentList(completion: @escaping (Result<[RecentPokemonList], Error>) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let menagedContext = appDelegate.persistentContainer.viewContext
        DispatchQueue.main.async {
            let fetchRequest = NSFetchRequest<RecentPokemonList>(entityName: "RecentPokemonList")
            do {
                let result = try menagedContext.fetch(fetchRequest)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
