//
//  PlanetListViewController.swift
//  School
//
//  Created by Anna Vaganova on 05.04.2021.
//

import UIKit
import PKHUD

let networkService: PlanetsListNetworkService = NetworkService()

class PlanetListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.registerForKeyboardNotifications()
        //HUD.allowsInteraction = false
        //HUD.dimsBackground = true
        
    }
    
    func loadPlanets(page: Int) -> PlanetListResponceModel {
        HUD.show(.progress)
        
        var resultResponse: PlanetListResponceModel!
        
        networkService.getPlanetList(page: page) { [weak self] (response, error) in
            guard let self = self else { return }
            HUD.hide()
            //            self.textField.text = response?.info.next
            print("--------RESPONSE---------------")
            print(response as Any)
            print("--------ERROR---------------")
            print(error as Any)
            print("--------END---------------")
            
            resultResponse = response
        }
        
        return resultResponse // тут надо чота сделать посмотри в чате в тг
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            
        }
        
        DispatchQueue.global().async {
            
        }
        //loadPlanets()
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
    
    func loadingModel() {
        // функция для подгрузки таблицы во время скролла
    }
    
}
