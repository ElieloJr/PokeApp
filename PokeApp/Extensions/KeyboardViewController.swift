//
//  ElielViewController.swift
//  PokeApp
//
//  Created by Usr_Prime on 30/03/22.
//

import UIKit

class KeyboardViewController: UIViewController {
    var wasKeyboardMoved = false
    var enableKeyboardUpMovement = true
    var enableTapOutsideToHide = true
    var CampTextField: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.enableKeyboardUpMovement {
            self.registerKeyboardToGoUpAndDown()
        }
        if enableTapOutsideToHide {
            self.registerViewForTapToDismiss()
        }
    }
    func addToolBar(textField: UITextField) {
        CampTextField = textField
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .done, target: self, action: #selector(KeyboardViewController.cancelClick))
        toolBar.setItems([spaceButton, cancelButton, spaceButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    private func registerKeyboardToGoUpAndDown() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func registerViewForTapToDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if !wasKeyboardMoved {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= keyboardSize.height
            }
            wasKeyboardMoved.toggle()
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        wasKeyboardMoved.toggle()
    }
    @objc func cancelClick(textField: UITextField) {
        CampTextField?.resignFirstResponder()
    }
}
