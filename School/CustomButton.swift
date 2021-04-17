//
//  CustomButton.swift
//  School
//
//  Created by Anna Vaganova on 19.03.2021.
//

import UIKit

class CustomButton: UIButton{
    
    override var isHighlighted: Bool{
        didSet{
            self.backgroundColor = self.highlightedColor
        }
    }

    var highlightedColor:UIColor = UIColor.green
}
