//
//  CustomButton.swift
//  School
//
//  Created by Студент 2 on 19.03.2021.
//

import UIKit

class CustomButton: UIButton{
    override var isEnabled: Bool{
//        set {
//            self.isEnabled = newValue
//        }
//        get{
//            return self.isEnabled
//        }
        didSet{
            print(self.isEnabled)
            //foo(self.isEnabled)
        }
    }
    
    //var closure: () ->
    //func foo(_ isEnabled : Bool){}
    
}
