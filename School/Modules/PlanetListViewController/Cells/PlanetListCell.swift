//
//  PlanetListCell.swift
//  School
//
//  Created by Студент 4 on 4/12/21.
//

import UIKit

struct dataAboutPlanet {
    var name: String
    var type: String
    var population: Int
}

class PlanetListCell: UITableViewCell {
    
    @IBOutlet private var planetNameLabel: UILabel!
    @IBOutlet private var planetTypeLabel: UILabel!
    @IBOutlet private var planetPopulationLabel: UILabel!

    func createPlanetCell(information: dataAboutPlanet) -> UITableViewCell {
        
        planetNameLabel.text = information.name
        planetTypeLabel.text = information.type
        planetPopulationLabel.text = String(information.population)
        
        return self
    }
    
}
