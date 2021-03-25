//
//  ViewController.swift
//  School
//
//  Created by Студент 2 on 17.03.2021.
//

import UIKit

class ViewController: UIViewController {
    //@IBOutlet weak private var titelLable: UILabel!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var loginTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        
        //loginButton.setTitle("код не войти", for: .disabled)
        //loginButton.isEnabled = false
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        // тип return при работе с loginTextField
        loginTextField.returnKeyType = .next
        // тип return при работе с passwordTextField
        passwordTextField.returnKeyType = .done
        
        // тип клавиатуры при работе с loginTextField
        loginTextField.keyboardType = UIKeyboardType.emailAddress
        
        registerKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    // функция для сворачивания клавиатуры
    @objc func hideKeyboard(){
        //view.resignFirstResponder() // если строка ниже не помогает
        view.endEditing(true)
    }
    
    @objc func tapAction(){
        guard let text = loginTextField.text else
        {return}
        
        print("\(text) - текст с поля login")
    }
    
    
    @IBAction func tapRegisterButttonAction() {
        if let text = passwordTextField.text {
            print("\(text) - текст с поля password")
        }
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
    
    @objc func keyboardWillShow(_ notification: Notification){
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
}

