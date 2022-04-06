//
//  Utils.swift
//  PokeApp
//
//  Created by Usr_Prime on 01/04/22.
//

import UIKit

class Utils {
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
