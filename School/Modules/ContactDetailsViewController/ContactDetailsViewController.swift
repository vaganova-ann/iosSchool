//
//  ContactDetailsViewController.swift
//  School
//
//  Created by Дмитрий Тетенюк on 31.03.2021.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    private var personNames: [String] = ["Ervin Fuentes",
                                   "Maude Lane",
                                   "Merle Richmond",
                                   "Cherry Moody",
                                   "Virgie Hansen",
                                   "Paula Jackson",
                                   "Otis Patrick",
                                   "Jessica Dunlap",
                                   "Brittany Calhoun",
                                   "Lesley Atkinson"]
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private var persons: [Person] = []
    
    var collectionViewLayout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection in
            return PesikCell.defaultSectionLayout(env: env)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let pesikNib = UINib(nibName: PesikCell.className, bundle: nil)
        //collectionView.register(pesikNib, forCellWithReuseIdentifier: PesikCell.className)
        
        let pesikNib = UINib(nibName: PesikCell.className, bundle: nil)
        collectionView.register(pesikNib, forCellWithReuseIdentifier: PesikCell.className)
        generateModels()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = collectionViewLayout
        
    }
    
    func navigateNext()  {
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewControllerToPush = storyboard.instantiateViewController(identifier: ContactDetailsViewController.className)
        
        navigationController?.pushViewController(viewControllerToPush, animated: true)
        
    }
    
    func generateModels() {
        persons = []
        for index in 0..<personNames.count {
            let person = Person(name: personNames[index], portrait: UIImage.portraitImageWithNumber(index))
            persons.append(person)
        }
    }
}

extension ContactDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        persons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PesikCell.className, for: indexPath) as? PesikCell  {
            return cell.configureWith(person: persons[indexPath.item])
        }
        return UICollectionViewCell()
    }
    
    
}
