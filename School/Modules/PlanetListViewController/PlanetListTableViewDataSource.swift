//
//  PlanetListTableViewDataSource.swift
//  School
//
//  Created by Студент 2 on 12.04.2021.
//

import UIKit


class PlanetListTableViewDataSource: NSObject {
    private var model: [DataAboutPlanet]
    
    internal init(model: [DataAboutPlanet]) {
        self.model = model
    }
}

extension PlanetListTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
