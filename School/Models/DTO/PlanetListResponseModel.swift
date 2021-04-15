//
//  PlanetListResponceModel.swift
//  School
//
//  Created by Anna Vaganova on 05.04.2021.
//

import Foundation

struct PlanetListResponseModel: Decodable {
    let info: PlanetListInfoResponceModel
    let results: [PlanetsListResultsResponceModel]
}

struct PlanetListInfoResponceModel: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct PlanetsListResultsResponceModel: Decodable {
    let id: Int
    let name: String?
    let type: String?
    let residents: [String]
}
