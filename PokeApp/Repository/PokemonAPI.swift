//
//  PokemonAPI.swift
//  PokeApp
//
//  Created by Usr_Prime on 25/03/22.
//

import Foundation

class PokemonAPI {
    static let shared = PokemonAPI()
    
    func getPokemonData(pokemon: String, completion: @escaping (Result<PokemonAPIResponse, Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(PokemonAPIResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
