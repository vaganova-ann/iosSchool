//
//  RegistrationDataCell.swift
//  School
//
//  Created by Anna Vaganova on 4/6/21.
//

import UIKit

class RegistrationDataCell: UITableViewCell {

    @IBOutlet private var rightLabel: UILabel!
    @IBOutlet private var leftLabel: UILabel!
    
    func createRegistrationDateCell(userData: ProfileData) -> UITableViewCell {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        rightLabel.backgroundColor = .clear
        rightLabel.text = dateFormatter.string(from: userData.registrationDate)
        leftLabel.text = "Дата Регистрации:"
        
        return self
    }
    
}
