//
//  PersonTableViewCell.swift
//  School
//
//  Created by Anna Vaganova on 26.03.2021.
//

import UIKit

class Person: NSObject, CellConfigurator {
    
    var reuseIndentifier: String {
        get { return PersonTableViewCell.className }
    }
    
    var name: String = ""
    var portrait: UIImage?
    
    init(name: String, portrait: UIImage?) {
        self.name = name
        self.portrait = portrait
    }
}


class PersonTableViewCell: UITableViewCell, ConfigurableRow {
    
    @IBOutlet private var titleLable: UILabel!
    @IBOutlet private var portraitImageView: UIImageView!
    
    func configureWith(_ configurator: Any) -> UITableViewCell {
        
        guard let model = configurator as? Person
        else {
            return self
        }
        titleLable.text = model.name
        portraitImageView.image = model.portrait
        
        return self
    }
    
}
