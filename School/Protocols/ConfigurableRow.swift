//
//  ConfigurableRow.swift
//  School
//
//  Created by Anna Vaganova on 26.03.2021.
//

import UIKit

protocol ConfigurableRow: UITableViewCell {
    
    func configureWith(_ configurator: Any) -> UITableViewCell
}

protocol CellConfigurator: NSObject {
    var reuseIndentifier: String {get}
}

extension CellConfigurator {
    var reuseIndentifier: String {
        get{
            return Self.className
        }
    }
}
