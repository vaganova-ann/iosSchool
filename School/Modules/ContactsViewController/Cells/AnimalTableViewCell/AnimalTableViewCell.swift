//
//  AnimalTableViewCell.swift
//  School
//
//  Created by Anna Vaganova on 26.03.2021.
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
    
    func configureWith(_ configurator: Any) -> UITableViewCell {
        
        guard let model = configurator as? Animal
        else {
            return self
        }
        titleLable.text = model.name
        portraitImageView.image = model.image
        
        return self
    }
    
}
