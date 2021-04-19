//
//  CustomDataCell.swift
//  School
//
//  Created by Anna Vaganova on 4/6/21.
//

import UIKit

class CustomDataCell: UITableViewCell {

    @IBOutlet private var rightLabel: UILabel!
    @IBOutlet private var leftLabel: UILabel!
    
    func createColorCell(userData: ProfileData) -> UITableViewCell {
        rightLabel.text = ""
        leftLabel.text = "Цвет профиля:"
        
        if let userColor = userData.color {
            rightLabel.backgroundColor = UIColor(red: CGFloat(userColor.red), green: CGFloat(userColor.green), blue: CGFloat(userColor.blue), alpha: 0.5)
        }
        else {
            rightLabel.backgroundColor = .clear
        }
        return self
    }
    
    func createRegistrationDateCell(userData: ProfileData) -> UITableViewCell {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        rightLabel.backgroundColor = .clear
        rightLabel.text = dateFormatter.string(from: userData.registrationDate)
        leftLabel.text = "Дата Регистрации:"
        
        return self
    }
    
}
