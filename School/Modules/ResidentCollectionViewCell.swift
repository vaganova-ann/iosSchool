//
//  ResidentCollectionViewCell.swift
//  School
//
//  Created by Anna Vaganova on 4/27/21.
//

import UIKit

class ResidentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var loadActivityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var genderLabel: UILabel!
    @IBOutlet private var speciesLabel: UILabel!
    
    
    var idResidentCell = ""
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
    }
    
    static func defaultSectionLayout(env:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240.0))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count: 2)
        
        let spacing: CGFloat = 20.0
        groupLayout.contentInsets = .init(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        groupLayout.interItemSpacing = .fixed(spacing)
        
        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        sectionLayout.contentInsets = .init(top: 0.0, leading: 0.0, bottom: spacing*2.0, trailing: 0.0)
        
        return sectionLayout
    }
    
    @discardableResult
    func createResidentCell(resident: ResidentData) -> UICollectionViewCell {
        portraitImageView.layer.cornerRadius = 15.0
        portraitImageView.clipsToBounds = true
        
        if let residentPortrait = resident.smallPortrait {
            portraitImageView.image = residentPortrait
        }
        else {
            portraitImageView.image = UIImage(named: "nonePortrait")
        }
        
        nameLabel.text = resident.name
        genderLabel.text = resident.gender
        speciesLabel.text = resident.species
        
        return self
    }
}
