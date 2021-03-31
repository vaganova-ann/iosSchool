//
//  AnimalTableViewCell.swift
//  School
//
//  Created by Студент 2 on 26.03.2021.
//

import UIKit

class Animal: NSObject, CellConfigurator {
    
    var reuseIndentifier: String {
        get { return AnimalTableViewCell.className }
    }
    
    var name: String = ""
    var image: UIImage?
    
    init(name: String, image: UIImage?) {
        self.name = name
        self.image = image
    }
}


class AnimalTableViewCell: UITableViewCell, ConfigurableRow {
    
    
    @IBOutlet private var titleLable: UILabel!
    @IBOutlet private var portraitImageView: UIImageView!
    
    func configureWith(_ consigurator: Any) -> UITableViewCell {
        
        guard let model = consigurator as? Animal
        else {
            return UITableViewCell()
        }
        titleLable.text = model.name
        portraitImageView.image = model.image
        
        return self
    }
    
}
