//
//  ProfileColorCell.swift
//  School
//
//  Created by Anna Vaganova on 4/6/21.
//

import UIKit

class LoginCell: UITableViewCell {

    @IBOutlet private var LoginLabel: UILabel!
    
    func createLoginCell(userData: ProfileData) -> UITableViewCell {
        LoginLabel.text = userData.login
        return self
    }
    
}
