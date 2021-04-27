//
//  PlanetListViewController.swift
//  School
//
//  Created by Anna Vaganova on 05.04.2021.
//

import UIKit
import PKHUD

class PlanetListViewController: UIViewController  {
    
    @IBOutlet private var tableView: UITableView!
    
    private var model: [DataAboutPlanet]!
    
    private var currendDownloadPage: Int!
    private var numberOfPages: Int!
    
    let networkService: PlanetsListNetworkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.registerForKeyboardNotifications()
        tableView.delegate = self
        tableView.dataSource = self
        
        model = []
        currendDownloadPage = 1
        
        loadPlanets(page: currendDownloadPage, uiInteractionsAllowed: true)
    
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
            
            DispatchQueue.main.async {
                self.numberOfPages = resultResponse.info.pages
                
                let lastIndexPathRow = self.model.count
                self.model.append(contentsOf: self.generateModel(planetList: resultResponse))
                
                var indexes: [IndexPath] = []
                for index in lastIndexPathRow...self.model.count - 1 {
                            indexes.append(IndexPath(row: index, section: 0))
                }
                self.tableView.insertRows(at: indexes, with: .none)
            }
            
            if uiInteractionsAllowed {
                self.tableView.reloadData()
                HUD.hide()
            }
        }
    }
    
    deinit {
        HUD.deregisterFromKeyboardNotifications()
    }
    
    func generateModel(planetList : PlanetListResponseModel) -> [DataAboutPlanet]  {
        
        var planets: [DataAboutPlanet] = []
        let informationAboutPlanet = planetList.results
        for planet in informationAboutPlanet {
            if let planetName = planet.name {
                planets.append(DataAboutPlanet(name: planetName, type: planet.type, population: planet.residents.count, residents: planet.residents))
            }
        }
        return planets
    }
}

extension PlanetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == model.count/2,
           currendDownloadPage <= numberOfPages {
            currendDownloadPage += 1
            DispatchQueue.global(qos: .userInitiated).async {
                self.loadPlanets(page: self.currendDownloadPage, uiInteractionsAllowed: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let destinationViewController = mainStoryBoard.instantiateViewController(identifier: ResidentsListViewController.className) as? ResidentsListViewController {
            
            destinationViewController.residentsUrlList = model[indexPath.row].residents
            destinationViewController.planetName = model[indexPath.row].name
            
            navigationController?.pushViewController(destinationViewController, animated: true)
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
