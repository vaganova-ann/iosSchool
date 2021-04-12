//
//  ProfileViewController.swift
//  School
//
//  Created by Anna Vaganova on 4/6/21.
//

import UIKit
import KeychainSwift

class ProfileViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var logOutButton: UIButton!
    
    private var dataSource: ProfileTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = generateModel()
        dataSource = ProfileTableViewDataSource(profile: model)
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        let loginCellNib = UINib(nibName: LoginCell.className, bundle: Bundle.main)
        tableView.register(loginCellNib, forCellReuseIdentifier: LoginCell.className)
        
        let customDataCellNib = UINib(nibName: CustomDataCell.className, bundle: Bundle.main)
        tableView.register(customDataCellNib, forCellReuseIdentifier: CustomDataCell.className)
        
        let photosCellNib = UINib(nibName: PhotosCell.className, bundle: Bundle.main)
        tableView.register(photosCellNib, forCellReuseIdentifier: PhotosCell.className)
        
        logOutButton.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
    }
    
    func generateModel() -> ProfileData {
        
        if let autorizationToken = keyChain.get(ApplicationConstants.keychainTokenKey),
           let responseData = AuthorizationMockSimulator().getProfile(token: autorizationToken)?.user
        {
            var userProfileData = ProfileData(login: responseData.login, registrationDate: responseData.registrationDate)
            
            if let responseColor = responseData.prefferedColor {
                userProfileData.color = CustomColor(green: responseColor.green, red: responseColor.red, blue: responseColor.blue)
            }
            
            if let responsePhoto = responseData.photo{
                userProfileData.photo = responsePhoto
            }
            return userProfileData
        }
        return ProfileData(login: "Логин пользователя", registrationDate: Date())
        }
    
    @objc func logOutAction() {
        keyChain.delete(ApplicationConstants.keychainTokenKey)
        tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
}
