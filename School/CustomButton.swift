//
//  CustomButton.swift
//  School
//
//  Created by Студент 2 on 19.03.2021.
//

import UIKit

// кастомный класс кнопки
class CustomButton: UIButton{
    
    // переопределяем свойство
    override var isHighlighted: Bool{
        
        didSet{
            // назначаем кнопке случайный цвет
            self.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        }
    }
    
    //var closure: () ->
    //func foo(_ isEnabled : Bool){}
    
}
