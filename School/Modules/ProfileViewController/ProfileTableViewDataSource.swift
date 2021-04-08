//
//  ProfileTableViewDataSource.swift
//  School
//
//  Created by Anna Vaganova on 4/6/21.
//

import UIKit

struct CustomColor {
    let green: Double
    let red: Double
    let blue: Double
}

struct ProfileData {
    var login: String
    var photo: String?
    var color: CustomColor?
    var registrationDate: Date
}

class ProfileTableViewDataSource: NSObject {
    
    private var profile: ProfileData
    
    init(profile: ProfileData) {
        self.profile = profile
    }
}

extension ProfileTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            1
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PhotosCell.className) as? PhotosCell {
                return cell.createPhotosCell(userData: profile)
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LoginCell.className) as? LoginCell {
                return cell.createLoginCell(userData: profile)
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CustomDataCell.className) as? CustomDataCell {
                return cell.createRegistrationDateCell(userData: profile)
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CustomDataCell.className) as? CustomDataCell {
                return cell.createColorCell(userData: profile)
            }
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
}

extension ProfileTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
