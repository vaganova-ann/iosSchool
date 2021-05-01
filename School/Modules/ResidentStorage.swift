//
//  ResidentStorage.swift
//  School
//
//  Created by Anna Vaganova on 4/28/21.
//

import UIKit

class ResidentStorage {
    
    static let sharedInstance = ResidentStorage()
    
    var residentDictionary = Dictionary<String, ResidentData>(minimumCapacity: 100)
    private init() {}
}

extension ResidentStorage: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
