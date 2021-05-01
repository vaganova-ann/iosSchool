//
//  CharacterData.swift
//  School
//
//  Created by Anna Vaganova on 4/28/21.
//

import Foundation

struct CharacterData: Decodable {
    let name: String
    let gender: String
    let species: String
    let image: String?
}
