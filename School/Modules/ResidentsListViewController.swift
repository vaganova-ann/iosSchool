//
//  ResidentsListViewController.swift
//  School
//
//  Created by Anna Vaganova on 4/27/21.
//

import UIKit

struct ResidentData {
    var name: String
    var gender: String
    var species: String
    var smallPortrait: UIImage?
    var bigPortrait: UIImage?
}

class ResidentsListViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    var residentsUrlList: [String]?
    var planetName: String?
    
    let networkService: RickAndMortyDataNetworkService = NetworkService()

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
    
    func loadResident(url: String, cell: ResidentCollectionViewCell) {

        DispatchQueue.global(qos: .userInitiated).async {
            
            self.networkService.getResidentData(url: url) { (response, error) in
                guard let resultResponse = response
                else { return }
                
                DispatchQueue.main.async {
                    let resident = ResidentData(name: resultResponse.name, gender: resultResponse.gender, species: resultResponse.species)
                    ResidentStorage.sharedInstance.residentDictionary[url] = resident
                    if cell.idResidentCell == url {
                        cell.createResidentCell(resident: resident)
                    }
                }
                
                if let imageUrl = resultResponse.image {
                    self.networkService.getResidentImage(url: imageUrl) {  (response, error) in
                        if let resultImageResponse = response {
                            
                            DispatchQueue.main.async {
                                var residentInfo = ResidentStorage.sharedInstance.residentDictionary[url]
                                residentInfo?.bigPortrait = resultImageResponse
                                let resizedImage =  self.resizeImage(bigImage: resultImageResponse, size: CGSize(width: 120, height: 120))
                                residentInfo?.smallPortrait = resizedImage
                                ResidentStorage.sharedInstance.residentDictionary[url] = residentInfo
                                
                                if cell.idResidentCell == url {
                                    cell.portraitImageView.image = resizedImage
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            cell.loadActivityIndicatorView.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
    func resizeImage(bigImage: UIImage, size: CGSize) -> UIImage {
        let render = UIGraphicsImageRenderer(size: size)
        return render.image { (context) in
            bigImage.draw(in: CGRect(origin: .zero, size: size))
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
            
            cell.loadActivityIndicatorView.hidesWhenStopped = true
            
            let keyUrl = urlList[indexPath.row]
            cell.idResidentCell = keyUrl
            
            if let person = ResidentStorage.sharedInstance.residentDictionary[keyUrl] {
                if cell.idResidentCell == keyUrl {
                    return cell.createResidentCell(resident: person)
                }
            }
            else {
                cell.loadActivityIndicatorView.startAnimating()
                loadResident(url: keyUrl, cell: cell)
            }
            
            return cell
        }
       return UICollectionViewCell()
    }
}
