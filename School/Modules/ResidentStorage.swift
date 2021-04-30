//
//  ResidentStorage.swift
//  School
//
//  Created by Студент 4 on 4/28/21.
//

import UIKit

class ResidentStorage {
    
    static let sharedInstance = ResidentStorage()
    
    var residentDictionary = Dictionary<String, ResidentData>(minimumCapacity: 1000)
}

extension ResidentStorage: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
