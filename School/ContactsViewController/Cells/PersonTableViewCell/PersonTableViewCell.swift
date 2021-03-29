//
//  PersonTableViewCell.swift
//  School
//
//  Created by Студент 2 on 26.03.2021.
//

import UIKit

struct Person {
    var name: String
    var portrait: UIImage?
}


class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLable: UILabel!
    @IBOutlet private var portraitImageView: UIImageView!
    
    func configureWith(_ model: Person) -> Self {
        titleLable.text = model.name
        portraitImageView.image = model.portrait
        return self
    }
}
