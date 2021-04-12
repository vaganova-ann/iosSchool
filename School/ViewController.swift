//
//  ViewController.swift
//  School
//
//  Created by Anna Vaganova  on 17.03.2021.
//

import UIKit
import KeychainSwift

let keyChain = KeychainSwift()

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak private var titelLable: UILabel!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var loginTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var scrollView: UIScrollView!
    
    //let keyChain = KeychainSwift()
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        loginTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
        
        loginTextField.keyboardType = UIKeyboardType.emailAddress
        
        registerKeyboardNotification()
        
        scrollView.delegate = self
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc func tapAction(){
        
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else { return }

        let loginAnswer = AuthorizationMockSimulator().logIn(login: login, password: password)
        if loginAnswer.result == true,
           let authorizationTocken = loginAnswer.token {
            keyChain.set(authorizationTocken, forKey: ApplicationConstants.keychainTokenKey)
        }
        let destinationViewController = mainStoryBoard.instantiateViewController(identifier: String("TabBarController"))
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
    @IBAction func tapRegisterButttonAction() {
        
        let destinationViewController = mainStoryBoard.instantiateViewController(identifier: RegistrationViewController.className)
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    @IBAction func loginTextFieldPrimaryActionTriggered(_ sender: UITextField) {
        passwordTextField.becomeFirstResponder()
    }
    
    
    @IBAction func passwordTextFieldPrimaryActionTriggered(_ sender: UITextField) {
        hideKeyboard()
    }
    
    func registerKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func keyboardWillHide(){
        scrollView.contentInset = .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let scale = min(max(1.0 - offset / 100.0, 0.0), 10.0)
        titelLable.transform = CGAffineTransform(scaleX: 1.0, y: scale)
    }
    
    
    
}

