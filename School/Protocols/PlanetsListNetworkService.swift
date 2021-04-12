//
//  PlanetsListNetworkService.swift
//  School
//
//  Created by Студент 2 on 05.04.2021.
//

import UIKit

protocol PlanetsListNetworkService {
    
    func getPlanetList(page: Int, onRequestCompleted: @escaping ((PlanetListResponceModel?, Error?)->()))
}
