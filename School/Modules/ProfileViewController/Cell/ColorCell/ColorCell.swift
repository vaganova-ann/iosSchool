//
//  ColorCell.swift
//  School
//
//  Created by Студент 4 on 5/1/21.
//

import UIKit

class ColorCell: UITableViewCell {
    
    @IBOutlet private var colorView: UIView!
    @IBOutlet private var leftLabel: UILabel!
    
    func createColorCell(userData: ProfileData) -> UITableViewCell {
        
        leftLabel.text = "Цвет профиля:"
        colorView.layer.cornerRadius = 5.0
        
        if let userColor = userData.color {
            colorView.backgroundColor = UIColor(red: CGFloat(userColor.red), green: CGFloat(userColor.green), blue: CGFloat(userColor.blue), alpha: 0.5)
        }
        else {
            colorView.backgroundColor = .clear
        }
        return self
    }
    
}
