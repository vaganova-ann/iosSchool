//
//  ProfileColorCell.swift
//  School
//
//  Created by Anna Vaganova on 4/6/21.
//

import UIKit

class LoginCell: UITableViewCell {

    @IBOutlet private var loginLabel: UILabel!
    
    func createLoginCell(userData: ProfileData) -> UITableViewCell {
        loginLabel.text = userData.login
        return self
    }
    
}
