//
//  ConfigurableRow.swift
//  School
//
//  Created by Студент 2 on 26.03.2021.
//

import UIKit

protocol ConfRow: UITableViewCell {
    
    func configureWith(_ consigurator: Any) -> UITableViewCell
}

protocol CellConf: NSObject {
    var reuseId: String {get}
}

extension CellConf {
    var reuseId: String {
        get{
            return Self.className
        }
    }
}
