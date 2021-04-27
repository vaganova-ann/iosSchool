//
//  ResidentsListViewController.swift
//  School
//
//  Created by Студент 4 on 4/27/21.
//

import UIKit


struct ResidentData {
    var name: String
    var gender: String
    var species: String
    var portrait: UIImage!
}

class ResidentsListViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    var residentsUrlList: [String]!
    var planetName: String!
    
    var collectionViewLayout: UICollectionViewLayout {
           UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection in
               return ResidentCollectionViewCell.defaultSectionLayout(env: env)
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let chosenPlanetName = planetName {
            self.title = "Жители локации " + " \"\(chosenPlanetName)\""
        }
        else {
            self.title = "Жители"
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
}

extension ResidentsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
}
