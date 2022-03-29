//
//  DetalheViewController.swift
//  PokeApp
//
//  Created by Usr_Prime on 24/03/22.
//

import UIKit

class DetalheViewController: UIViewController {
    
    let viewModel = DetalheViewModel()

    @IBOutlet weak var backgtoundTop: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonTypeView: UIView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var backgroundBottom: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!

    @IBOutlet weak var baseStatsView: UIView!
    @IBOutlet weak var hpNumLabel: UILabel!
    @IBOutlet weak var attackNumLabel: UILabel!
    @IBOutlet weak var defenseNumLabel: UILabel!
    @IBOutlet weak var spAtkNumLabel: UILabel!
    @IBOutlet weak var spDefNumLabel: UILabel!
    @IBOutlet weak var SpeedNumLabel: UILabel!
    @IBOutlet weak var totalNumLabel: UILabel!
    @IBOutlet weak var hpSlider: UISlider!
    @IBOutlet weak var attackSlider: UISlider!
    @IBOutlet weak var defenseSlider: UISlider!
    @IBOutlet weak var spAtkSlider: UISlider!
    @IBOutlet weak var spDefSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var totalSlider: UISlider!
    
    @IBOutlet weak var typesCollectionView: UICollectionView!
    @IBOutlet weak var movesCollectView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        DispatchQueue.main.async { [self] in
            self.viewModel.setupData()
        }
        backgroundBottom.layer.cornerRadius = 35
        
        movesCollectView.dataSource = self
        typesCollectionView.dataSource = self
        movesCollectView.register(UINib(nibName: "MoveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoveCollectionViewCell")
        typesCollectionView.register(UINib(nibName: "TypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TypeCollectionViewCell")
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func segmentedControlClick(_ sender: Any) {
        guard let selectedControl = SegmentedControlOptions(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        switch selectedControl {
        case .About:
            showAbout()
        case .BaseStats:
            showBaseStats()
        case .Moves:
            showMoves()
        }
    }
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func showAbout() {
        aboutView.isHidden = false
        baseStatsView.isHidden = true
        movesCollectView.isHidden = true
    }
    func showBaseStats() {
        aboutView.isHidden = true
        baseStatsView.isHidden = false
        movesCollectView.isHidden = true
    }
    func showMoves() {
        aboutView.isHidden = true
        baseStatsView.isHidden = true
        movesCollectView.isHidden = false
    }
}
extension DetalheViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movesCollectView {
            if let pokemonDetails = viewModel.pokemonDetails {
                return pokemonDetails.moves.count
            }
        }
        if collectionView == typesCollectionView {
            if let pokemonDetails = viewModel.pokemonDetails {
                return pokemonDetails.types.count
            }
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index: Int = indexPath.row
        if collectionView == typesCollectionView {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionViewCell", for: indexPath) as! TypeCollectionViewCell
            if let pokemonDetails = viewModel.pokemonDetails {
                if let types = PokemonTypes(rawValue: pokemonDetails.types[index].type.name) {
                    cell2.setType(to: pokemonDetails.types[index].type.name.capitalized, color: viewModel.getColorFor(type: types))
                }            }
            return cell2
        }
        let moveCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoveCollectionViewCell", for: indexPath) as! MoveCollectionViewCell
        if let pokemonDetails = viewModel.pokemonDetails {
            moveCell.setMoveLabel(to: pokemonDetails.moves[index].move.name.replacingOccurrences(of: "-", with: " ").capitalized)
        }
        return moveCell 
    }
}
extension DetalheViewController: DetalheViewDelegate {
    func setupHeader(name: String, type: PokemonTypes, image: String, id: Int) {
        
        backgtoundTop.backgroundColor = viewModel.getColorFor(type: type)
        pokemonNameLabel.text = name.replacingOccurrences(of: "-", with: " ").capitalized
        pokemonIdLabel.text = "#\(id)"
        
        guard let imageURL = URL(string: image) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let imageEnd = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.pokemonImageView.image = imageEnd
            }
        }
    }
    func setupBaseStatus(stats: [Stats]) {
        hpNumLabel.text = "\(stats[0].base_stat)"
        attackNumLabel.text = "\(stats[1].base_stat)"
        defenseNumLabel.text = "\(stats[2].base_stat)"
        spAtkNumLabel.text = "\(stats[3].base_stat)"
        spDefNumLabel.text = "\(stats[4].base_stat)"
        SpeedNumLabel.text = "\(stats[5].base_stat)"
        
        hpSlider.value = Float(stats[0].base_stat)
        attackSlider.value = Float(stats[1].base_stat)
        defenseSlider.value = Float(stats[2].base_stat)
        spAtkSlider.value = Float(stats[3].base_stat)
        spDefSlider.value = Float(stats[2].base_stat)
        speedSlider.value = Float(stats[5].base_stat)
        
        let totalStats = Float(stats[0].base_stat) + Float(stats[1].base_stat) + Float(stats[2].base_stat) + Float(stats[3].base_stat) + Float(stats[4].base_stat) + Float(stats[5].base_stat)
        
        totalNumLabel.text = String(totalStats)
        totalSlider.value = totalStats
        }
    func setupAbout(species: String, height: String, weight: String, abilities: String) {
        speciesLabel.text = species.replacingOccurrences(of: "-", with: " ").capitalized
        heightLabel.text = "\(height)m"
        weightLabel.text = "\(weight)kg"
        abilitiesLabel.text = abilities
    }
    func reloadData() {
        DispatchQueue.main.async {
            self.movesCollectView.reloadData()
        }
    }
}
