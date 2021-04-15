//
//  PlanetListViewController.swift
//  School
//
//  Created by Студент 2 on 05.04.2021.
//

import UIKit
import PKHUD

let networkService: PlanetsListNetworkService = NetworkService()

class PlanetListViewController: UIViewController  {
    
    @IBOutlet private var tableView: UITableView!
    
    private var model: [DataAboutPlanet]!
    
    private var page: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.registerForKeyboardNotifications()
        tableView.delegate = self
        tableView.dataSource = self
        
        model = []
        page = 1
        
        loadPlanets(page: page, uiInteractionsAllowed: true)
    
        let planetCellNib = UINib(nibName: PlanetListCell.className, bundle: Bundle.main)
        tableView.register(planetCellNib, forCellReuseIdentifier: PlanetListCell.className)
    }
    
    func loadPlanets(page: Int, uiInteractionsAllowed: Bool) {
        
        if uiInteractionsAllowed {
            HUD.show(.progress)
        }
        networkService.getPlanetList(page: page) { [weak self] (response, error) in
            guard let self = self,
                  let resultResponse = response
            else { return }
            
            self.model.append(contentsOf: self.generateModel(planetList: resultResponse))
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            if uiInteractionsAllowed {
                HUD.hide()
            }
        }
    }
    
    deinit {
        HUD.deregisterFromKeyboardNotifications()
    }
    
    func generateModel(planetList : PlanetListResponceModel) -> [DataAboutPlanet]  {
        
        var planets: [DataAboutPlanet] = []
        let informationAboutPlanet = planetList.results
        for planet in informationAboutPlanet {
            if let planetName = planet.name {
                planets.append(DataAboutPlanet(name: planetName, type: planet.type, population: planet.residents.count))
            }
        }
        return planets
    }
}

extension PlanetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == model.count/2 {
            page += 1
            DispatchQueue.global(qos: .userInitiated).async {
                self.loadPlanets(page: self.page, uiInteractionsAllowed: false)
            }
        }
    }
}


extension PlanetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let planet = model[indexPath.row]
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: PlanetListCell.className) as? PlanetListCell {
            return dequeuedCell.createPlanetCell(information: planet)
        }
        else {
            return UITableViewCell()
        }
    }
}
