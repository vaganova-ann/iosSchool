//
//  RegistrationViewController.swift
//  School
//
//  Created by Anna Vaganova on 4/3/21.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        textFields[0].returnKeyType = .next
        textFields[1].returnKeyType = .next
        textFields[2].returnKeyType = .done
        
        textFields[0].keyboardType = UIKeyboardType.emailAddress
        
        registerKeyboardNotification()
        
        scrollView.delegate = self
        for elem in textFields {
            elem.delegate = self
        }
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
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
        
        scrollView.contentInset = UIEdgeInsets(top: (scrollView.contentSize.height - kbFrameSize.height) / 2.0, left: 0.0,
                                               bottom: (scrollView.contentSize.height  + kbFrameSize.height) / 2.0, right: 0.0)
        
    }
    
    @objc func keyboardWillHide(){
        scrollView.contentInset = .zero
    }
}

extension RegistrationViewController: UITextFieldDelegate, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let scale = min(max(1.0 - offset / 100.0, 0.0), 10.0)
        titleLabel.transform = CGAffineTransform(scaleX: 1.0, y: scale)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFields = textFields.sorted{ $0.frame.origin.y < $1.frame.origin.y }
        
        guard let currentIndex = textFields.firstIndex(of: textField)
        else { return false }
        
        if textFields[currentIndex].returnKeyType == .next,
           textFields.indices.contains(currentIndex + 1) {
            
            textFields[currentIndex + 1].becomeFirstResponder()
        }
        
        if textFields[currentIndex].returnKeyType == .done {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
