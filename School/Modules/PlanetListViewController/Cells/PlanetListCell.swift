//
//  PlanetListCell.swift
//  School
//
//  Created by Студент 4 on 4/12/21.
//

import UIKit

struct DataAboutPlanet {
    var name: String
    var type: String?
    var population: Int?
}

class PlanetListCell: UITableViewCell {
    
    @IBOutlet private var planetNameLabel: UILabel!
    @IBOutlet private var planetTypeLabel: UILabel!
    @IBOutlet private var planetPopulationLabel: UILabel!

    func createPlanetCell(information: DataAboutPlanet) -> UITableViewCell {
        
        planetNameLabel.text = information.name
        planetTypeLabel.text = information.type
        
        if let population = information.population {
            planetPopulationLabel.text = String(population)
        }
        else {
            planetPopulationLabel.text = nil
        }
        return self
    }
}
