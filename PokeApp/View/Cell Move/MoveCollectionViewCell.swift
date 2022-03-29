//
//  MoveCollectionViewCell.swift
//  PokeApp
//
//  Created by Usr_Prime on 24/03/22.
//

import UIKit

class MoveCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moveBackgroundView: UIView!
    @IBOutlet weak var moveNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moveBackgroundView.layer.shadowColor = UIColor.black.cgColor
        moveBackgroundView.layer.shadowOpacity = 0.2
        moveBackgroundView.layer.shadowOffset = .zero
        moveBackgroundView.layer.shadowRadius = 5
    }
    func setMoveLabel(to text: String) {
        moveNameLabel.text = text
    }
}
