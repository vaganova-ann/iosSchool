//
//  UIImage+PortrainImage.swift
//  School
//
//  Created by Студент 2 on 26.03.2021.
//

import UIKit

extension UIImage {
    static func portraitImageWithNumber(_ number: Int) -> UIImage?{
        return UIImage(named: "image-\(number)")
    }
}
