//
//  NSObject+ClassName.swift
//  School
//
//  Created by Студент 2 on 26.03.2021.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
