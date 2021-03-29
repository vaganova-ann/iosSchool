//
//  AnimalTableViewCell.swift
//  School
//
//  Created by Студент 2 on 26.03.2021.
//

import UIKit

struct Animal {
    var name: String
    var image: UIImage?
}

class AnimalTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLable: UILabel!
    @IBOutlet private var portraitImageView: UIImageView!
    
    func configureWith(_ model: Animal) -> Self {
        titleLable.text = model.name
        portraitImageView.image = model.image
        return self
    }
    
}
