//
//  CustomButton.swift
//  School
//
//  Created by Anna Vaganova on 19.03.2021.
//

import UIKit

// кастомный класс кнопки
class CustomButton: UIButton{
    
    // переопределяем свойство
    override var isHighlighted: Bool{
        
        didSet{
            self.backgroundColor = self.highlightedColor
        }
    }
    
    // новое свойство
    var highlightedColor:UIColor = UIColor.red
    
    //var closure: () ->
    //func foo(_ isEnabled : Bool){}
    
}
