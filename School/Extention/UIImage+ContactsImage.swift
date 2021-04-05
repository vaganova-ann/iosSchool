//
//  UIImage+PortrainImage.swift
//  School
//
//  Created by Anna Vaganova on 26.03.2021.
//

import UIKit

extension UIImage {
    static func portraitImageWithNumber(_ number: Int) -> UIImage?{
        return UIImage(named: "portrait/image-\(number)")
    }
    
    static func animalImageWithNumber(_ number: Int) -> UIImage?{
        return UIImage(named: "animalImage/image-\(number)")
    }
}
