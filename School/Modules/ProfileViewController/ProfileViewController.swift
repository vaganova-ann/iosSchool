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
    private var model: ProfileData!
    
    let keyChain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
        
        let loginCellNib = UINib(nibName: LoginCell.className, bundle: Bundle.main)
        tableView.register(loginCellNib, forCellReuseIdentifier: LoginCell.className)
        
        let customDataCellNib = UINib(nibName: CustomDataCell.className, bundle: Bundle.main)
        tableView.register(customDataCellNib, forCellReuseIdentifier: CustomDataCell.className)
        
        let photosCellNib = UINib(nibName: PhotosCell.className, bundle: Bundle.main)
        tableView.register(photosCellNib, forCellReuseIdentifier: PhotosCell.className)
        
        logOutButton.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
    }
    
    func updateModel() {
        
        model = generateModel()
        dataSource = ProfileTableViewDataSource(profile: model)
        dataSource.photoSelector = self
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    func generateModel() -> ProfileData {
        
        if let autorizationToken = keyChain.get(ApplicationConstants.keychainTokenKey),
           let responseData = AuthorizationMockSimulator().getProfile(token: autorizationToken)?.user
        {
            var userProfileData = ProfileData(login: responseData.login, registrationDate: responseData.registrationDate)
            
            if let responseColor = responseData.prefferedColor {
                userProfileData.color = CustomColor(green: responseColor.green, red: responseColor.red, blue: responseColor.blue)
            }
            
            if let responsePhoto = responseData.photo {
                userProfileData.photo = base64ToImage(responsePhoto)
            }
            return userProfileData
        }
        return ProfileData(login: "Логин пользователя", registrationDate: Date())
        }
    
    @objc func logOutAction() {
        keyChain.delete(ApplicationConstants.keychainTokenKey)
        tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func imageToBase64(_ image: UIImage) -> String? {
        return image.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
    
    func base64ToImage(_ base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }
}

extension ProfileViewController: PhotoSelectionProtocol {
    func selectPhoto() {
        let actionSheet = UIAlertController( title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default){ _ in
            self.chooseImagePicker(source: .camera) }
        
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        let photo = UIAlertAction(title: "Photo", style: .default){ _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                    
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        present(actionSheet,animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard  let userPhoto = info[.editedImage] as? UIImage else {return}
        guard let photo = imageToBase64(userPhoto) else {return}
        
        if let autorizationToken = keyChain.get(ApplicationConstants.keychainTokenKey) {
            AuthorizationMockSimulator().postUserImage(token: autorizationToken, base64: photo)
        }
        model.photo = userPhoto
        updateModel()
        tableView.reloadData()
        dismiss(animated: true)
    }
}

