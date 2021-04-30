//
//  ResidentsListViewController.swift
//  School
//
//  Created by Студент 4 on 4/27/21.
//

import UIKit
import Alamofire


struct ResidentData {
    var name: String
    var gender: String
    var species: String
    var portrait: UIImage?
}

class ResidentsListViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    var residentsUrlList: [String]?
    var planetName: String?
    
    let networkService: PlanetsListNetworkService = NetworkService()

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
        collectionView.allowsSelection = false
        
        let residentCellNib = UINib(nibName: ResidentCollectionViewCell.className, bundle: nil)
        collectionView.register(residentCellNib, forCellWithReuseIdentifier: ResidentCollectionViewCell.className)
    }
    
    func loadResident(url: String, numberCell: IndexPath) {

        DispatchQueue.global(qos: .userInitiated).async {
            
            self.networkService.getResidentData(url: url) { [weak self] (response, error) in
                guard let self = self,
                      let resultResponse = response
                else { return }
                
                DispatchQueue.main.async {
                    let resident = ResidentData(name: resultResponse.name, gender: resultResponse.gender, species: resultResponse.species)
                    ResidentStorage.sharedInstance.residentDictionary[url] = resident
                    self.collectionView.reloadItems(at: [numberCell])
                }
            }
        }
        
    }

}

extension ResidentsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let urlList = residentsUrlList else {
            return 0
        }
        return urlList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResidentCollectionViewCell.className, for: indexPath) as? ResidentCollectionViewCell,
           let urlList = residentsUrlList {
            
            let keyUrl = urlList[indexPath.row]
            cell.idResidentCell = keyUrl
            
            if let person = ResidentStorage.sharedInstance.residentDictionary[keyUrl]{
                if cell.idResidentCell == keyUrl {
                    return cell.createResidentCell(resident: person)
                }
            }
            else {
                loadResident(url: keyUrl, numberCell: indexPath)
            }
            
            return cell
        }
       return UICollectionViewCell()
    }
}
