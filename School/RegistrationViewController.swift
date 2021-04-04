//
//  RegistrationViewController.swift
//  School
//
//  Created by Студент 4 on 4/3/21.
//

import UIKit

class RegistrationViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak private var loginTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var passwordAgainTextField: UITextField!
    @IBOutlet weak private var doneButton: UIButton!
    @IBOutlet weak private var titleLabel: UILabel!
    
    @IBOutlet weak private var scrollView: UIScrollView!
    
    var activeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.addTarget(self, action: #selector(tapDoneButtonAction), for: .touchUpInside)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        loginTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .next
        passwordAgainTextField.returnKeyType = .done
        
        loginTextField.keyboardType = UIKeyboardType.emailAddress
        
        registerKeyboardNotification()
        
        scrollView.delegate = self
        
        
        
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    @objc func tapDoneButtonAction(){
        
        
        
    }
    
    @objc func hideKeyboard(){
        //view.resignFirstResponder() // если строка ниже не помогает
        view.endEditing(true)
    }
    

    @IBAction func loginTextFieldPrimaryActionTriggered(_ sender: UITextField) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func passwordFieldPrimaryActionTriggered(_ sender: UITextField) {
        passwordAgainTextField.becomeFirstResponder()
    }
    
    @IBAction func passwordAgainTextFieldPrimaryActionTriggered(_ sender: UITextField) {
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
        
        let durationNumber = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        print(durationNumber ?? 0)
        
        //let centerOffsetX = (scrollView.contentSize.width - scrollView.frame.size.width) / 2
        //let centerOffsetY =  -kbFrameSize.height / 2
        //let centerPoint = CGPoint(x: centerOffsetX, y: centerOffsetY)
        //scrollView.setContentOffset(centerPoint, animated: true)
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let scale = min(max(1.0 - offset / 100.0, 0.0), 10.0)
        titleLabel.transform = CGAffineTransform(scaleX: 1.0, y: scale)
    }
    
}
