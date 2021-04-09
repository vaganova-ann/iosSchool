//
//  NSObject+ClassName.swift
//  School
//
//  Created by Anna Vaganova on 26.03.2021.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
