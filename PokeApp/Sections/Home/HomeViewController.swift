//
//  HomeViewController.swift
//  PokeApp
//
//  Created by Usr_Prime on 23/03/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    func setup() {
        searchTextField.layer.borderWidth = 0.6
        searchTextField.layer.cornerRadius = 28
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
