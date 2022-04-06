//
//  RecentPokemonList+CoreDataProperties.swift
//  PokeApp
//
//  Created by Usr_Prime on 31/03/22.
//
//

import Foundation
import CoreData


extension RecentPokemonList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentPokemonList> {
        return NSFetchRequest<RecentPokemonList>(entityName: "RecentPokemonList")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var urlImage: String?
    @NSManaged public var identifier: UUID?
    @NSManaged public var type: String?

}

extension RecentPokemonList : Identifiable {

}
