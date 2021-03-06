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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
        
        let loginCellNib = UINib(nibName: LoginCell.className, bundle: Bundle.main)
        tableView.register(loginCellNib, forCellReuseIdentifier: LoginCell.className)
        
        let customDataCellNib = UINib(nibName: RegistrationDataCell.className, bundle: Bundle.main)
        tableView.register(customDataCellNib, forCellReuseIdentifier: RegistrationDataCell.className)
        
        let colorDataCellNib = UINib(nibName: ColorCell.className, bundle: Bundle.main)
        tableView.register(colorDataCellNib, forCellReuseIdentifier: ColorCell.className)
        
        let photosCellNib = UINib(nibName: PhotosCell.className, bundle: Bundle.main)
        tableView.register(photosCellNib, forCellReuseIdentifier: PhotosCell.className)
        
        logOutButton.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
    }
    
    func updateModel() {
        
        model = generateModel()
        dataSource = ProfileTableViewDataSource(profile: model)
        dataSource.photoSelector = self
        dataSource.colorSelector = self
        
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
        return ProfileData(login: "?????????? ????????????????????????", registrationDate: Date())
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
        
        guard let userPhoto = info[.editedImage] as? UIImage,
              let photo = imageToBase64(userPhoto)
        else { return }
        
        if let autorizationToken = keyChain.get(ApplicationConstants.keychainTokenKey) {
            AuthorizationMockSimulator().postUserImage(token: autorizationToken, base64: photo)
        }
        model.photo = userPhoto
        updateModel()
        tableView.reloadData()
        dismiss(animated: true)
    }
}

extension ProfileViewController: ColorSelectionProtocol {
    func selectColor() {

        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.supportsAlpha = false
        self.present(picker, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alfa: CGFloat = 0
        
        viewController.selectedColor.getRed(&red, green: &green, blue: &blue, alpha: &alfa)
        
        model.color = CustomColor(green: Double(green) , red: Double(red) , blue: Double(blue))
        if let autorizationToken = keyChain.get(ApplicationConstants.keychainTokenKey) {
            AuthorizationMockSimulator().postPrefferedColor(token: autorizationToken, color: AuthorizationMockSimulator.ApplicationUserPrefferedColor.init(green: Double(green) , red: Double(red) , blue: Double(blue)))
        }
        updateModel()
        tableView.reloadData()
        dismiss(animated: true)
    }
}

