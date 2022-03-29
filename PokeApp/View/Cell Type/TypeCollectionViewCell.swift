//
//  TypeCollectionViewCell.swift
//  PokeApp
//
//  Created by Usr_Prime on 28/03/22.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundUIView.layer.borderColor = UIColor.white.cgColor
        backgroundUIView.layer.borderWidth = 1
        backgroundUIView.layer.cornerRadius = 20
    }
    func setType(to type: String, color: UIColor) {
        typeLabel.text = type
        backgroundUIView.backgroundColor = color
    }
}
