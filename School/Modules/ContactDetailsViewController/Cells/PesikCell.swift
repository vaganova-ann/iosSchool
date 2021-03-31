//
//  PesikCell.swift
//  School
//
//  Created by Дмитрий Тетенюк on 31.03.2021.
//

import UIKit

class PesikCell: UICollectionViewCell {
    
    static func defaultSectionLayout(env:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        //let contentInsets = NSDirectionalEdgeInsets(top: 5,
        //                                            leading: 5,
        //                                            bottom: 5,
         //                                           trailing: 5)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                              heightDimension: .estimated(150))
        
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        //itemLayout.contentInsets = contentInsets
        
        let groupSize =
            NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160))
        
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])
        groupLayout.interItemSpacing = .flexible(5)
        
        groupLayout.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        
        return NSCollectionLayoutSection(group: groupLayout)
    }
    
    
    @IBOutlet private var portraitImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    
    func configureWith(person: Person) -> Self {
        portraitImageView.image = person.portrait
        titleLabel.text = person.name
        return self
    }
    
}
