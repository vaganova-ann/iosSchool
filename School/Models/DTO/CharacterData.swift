//
//  CharacterData.swift
//  School
//
//  Created by Студент 4 on 4/28/21.
//

import Foundation

struct CharacterData: Decodable {
    let name: String
    let gender: String
    let species: String
    let imageUrl: String?
}
