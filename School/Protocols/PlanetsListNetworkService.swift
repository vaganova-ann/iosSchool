//
//  PlanetsListNetworkService.swift
//  School
//
//  Created by Anna Vaganova on 05.04.2021.
//

import UIKit

protocol PlanetsListNetworkService {
    func getPlanetList(page: Int, onRequestCompleted: @escaping ((PlanetListResponseModel?, Error?)->()))
    func getResidentData(url: String, onRequestCompleted: @escaping ((CharacterData?, Error?) -> ()))
}
