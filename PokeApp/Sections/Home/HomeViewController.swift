//
//  HomeViewController.swift
//  PokeApp
//
//  Created by Usr_Prime on 23/03/22.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel = HomeViewModel()
    
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var searchImageView: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    func setupHome() {
        searchTextField.layer.borderWidth = 0.6
        searchTextField.layer.cornerRadius = 28
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupHome()
        viewModel.updateData()

        self.navigationItem.setHidesBackButton(true, animated: true)
        //view.keyboardLayoutGuide.topAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
    }
    @IBAction func searchButtonClick(_ sender: Any) {
        guard let pokemonName = searchTextField.text else { return }
        viewModel.searchPokemon(by: pokemonName)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetalheViewController, let selectedPokemon = self.viewModel.selectedPokemon else { return }
        vc.viewModel.pokemonDetails = selectedPokemon
    }
    @IBAction func exitButtonClick(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
extension HomeViewController: HomeViewDelegate {
    func setName(to name: String) {
        userNameLabel?.text = name
    }
    func pokemonFound() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "pokemonFound", sender: self)
            self.searchTextField.text = ""
        }
    }
    func pokemonNoFound() {
        DispatchQueue.main.async {
            UIButton.animate(withDuration: 0.3) {
                self.searchImageView.frame = CGRect(x: 10, y: self.searchImageView.frame.origin.y, width: self.searchImageView.frame.size.width, height: self.searchImageView.frame.size.height)
            } completion: { (_ ) in
                self.searchImageView.frame = CGRect(x: 100, y: self.searchImageView.frame.origin.y, width: self.searchImageView.frame.size.width, height: self.searchImageView.frame.size.height)
            }
        }
    }
}
