//
//  PokemonAPIResponse.swift
//  PokeApp
//
//  Created by Usr_Prime on 25/03/22.
//

import Foundation

struct PokemonAPIResponse: Codable {
    let id: Int
    let height: Int
    let weight: Int
    let abilities: [Abilities]
    let forms: [Forms]
    let stats: [Stats]
    let moves: [Moves]
    let sprites: Sprites
    let types: [Types]
}
struct Abilities: Codable {
    let ability: Ability
}
struct Ability: Codable {
    let name: String
}
struct Forms: Codable {
    let name: String
}
struct Stats: Codable {
    let base_stat: Int
    let stat: Stat
}
struct Stat: Codable {
    let name: String
}
struct Moves: Codable {
    let move: Move
}
struct Move: Codable {
    let name: String
}
struct Sprites: Codable {
    let other: Other
}
struct Other: Codable {
    let home: Home
}
struct Home: Codable {
    let front_default: String
}
struct Types: Codable {
    let type: TypePoke
}
struct TypePoke: Codable {
    let name: String
}
