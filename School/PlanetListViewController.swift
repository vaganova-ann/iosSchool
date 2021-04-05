//
//  PlanetListViewController.swift
//  School
//
//  Created by Студент 2 on 05.04.2021.
//

import UIKit
import PKHUD

let networkService: PlanetsListNetworkService = NetworkService()

class PlanetListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.registerForKeyboardNotifications()
        HUD.allowsInteraction = false
        HUD.dimsBackground = true
        
        
    }
    
    func loadPlanets() {
        HUD.show(.progress)
        networkService.getPlanetList(page: 1) { [weak self] (response, error) in
            guard let self = self else { return }
            HUD.hide()
            //            self.textField.text = response?.info.next
            print("--------RESPONSE---------------")
            print(response as Any)
            print("--------ERROR---------------")
            print(error as Any)
            print("--------END---------------")
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            
        }
        
        DispatchQueue.global().async {
            
        }
        loadPlanets()
    }
    
    
    
    deinit {
        HUD.deregisterFromKeyboardNotifications()
    }
    
}
