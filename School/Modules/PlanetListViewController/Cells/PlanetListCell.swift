//
//  PlanetListCell.swift
//  School
//
//  Created by Anna Vaganova on 4/12/21.
//

import UIKit

struct DataAboutPlanet {
    var name: String
    var type: String?
    var population: Int?
    var residents: [String]
}

class PlanetListCell: UITableViewCell {
    
    @IBOutlet private var planetNameLabel: UILabel!
    @IBOutlet private var planetTypeLabel: UILabel!
    @IBOutlet private var planetPopulationLabel: UILabel!

    func createPlanetCell(information: DataAboutPlanet) -> UITableViewCell {
        
        accessoryType = .disclosureIndicator
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
