//
//  HomeViewController.swift
//  PokeApp
//
//  Created by Usr_Prime on 23/03/22.
//

import UIKit

class HomeViewController: KeyboardViewController {

    var viewModel = HomeViewModel()
    
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var searchImageView: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var fastCollectionView: UICollectionView!
    
    func setupHome() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        searchTextField.layer.borderWidth = 0.6
        searchTextField.layer.cornerRadius = 28
        viewModel.delegate = self
        fastCollectionView.delegate = self
        fastCollectionView.dataSource = self
        fastCollectionView.register(UINib(nibName: "FastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FastCollectionViewCell")
    }
    override func viewDidLoad() {
        super.enableTapOutsideToHide = false
        super.addToolBar(textField: searchTextField)
        super.viewDidLoad()
        setupHome()
        DispatchQueue.main.async {
            self.viewModel.updateData()
        }
    }
    @IBAction func searchButtonClick(_ sender: Any) {
        guard let pokemonName = searchTextField.text else { return }
        viewModel.searchPokemonClick(by: pokemonName)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetalheViewController, let selectedPokemon = self.viewModel.selectedPokemon else { return }
        vc.viewModel.pokemonDetails = selectedPokemon
    }
    @IBAction func exitButtonClick(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel.getPokemonList().reversed()[indexPath.row].id else { return }
        viewModel.searchPokemonRecent(by: id)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPokemonList().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FastCollectionViewCell", for: indexPath) as? FastCollectionViewCell
        cell?.setData(pokemon: viewModel.getPokemonList().reversed()[indexPath.row])
        return cell!
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
    func reloadData() {
        DispatchQueue.main.async {
            self.fastCollectionView.reloadData()
        }
    }
}
