//
//  ViewController.swift
//  School
//
//  Created by Студент 2 on 17.03.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var titelLable: UILabel!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var loginTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        
        loginButton.setTitle("код не войти", for: .disabled)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        
        //loginButton.isEnabled = false
        
    }
    
    @objc func hideKeyboard(){
        //view.resignFirstResponder() если строка ниже не помогает
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
    
    
}

