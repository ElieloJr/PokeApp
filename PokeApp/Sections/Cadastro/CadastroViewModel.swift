//
//  CadastroViewModel.swift
//  PokeApp
//
//  Created by Usr_Prime on 17/03/22.
//

import UIKit

enum RegisterFields {
    case name
    case email
    case password
}
protocol CadastroViewDelegate: AnyObject {
    func setFieldsToDefault()
    func showError(message: String, field: RegisterFields)
    func registerSuccessful()
}

class CadastroViewModel {
    var delegate: CadastroViewDelegate?
    var userCanRegister = true
    
    func registerUser(name: String, email: String, password: String) {
        self.delegate?.setFieldsToDefault()
        userCanRegister = true
        
        validateName(name)
        validateEmail(email)
        validatePassword(password)
        
        if userCanRegister {
            let attributes = generateKeychainAttributes(name: name, email: email, password: password)
            if registerUserOnKeychain(attributes) {
                self.delegate?.registerSuccessful()
            } else {
                self.delegate?.showError(message: "Email já cadastrado", field: .email)
            }
        }
    }
    func registerUserOnKeychain(_ user: [String:Any]) -> Bool {
        return SecItemAdd(user as CFDictionary, nil) == noErr
    }
    func validateName(_ name: String) {
        if name == "" || name.count <= 3 {
            userCanRegister = false
            self.delegate?.showError(message: "Nome invalido", field: .name)
        }
    }
    func validateEmail(_ email: String) {
        if email == "" || !isValidEmail(email){
            userCanRegister = false
            self.delegate?.showError(message: "Email invalido", field: .email)
        }
    }
    func validatePassword(_ password: String) {
        if password == "" || password.count < 8 {
            userCanRegister = false
            self.delegate?.showError(message: "No mínimo 8 caracteres", field: .password)
        }
    }
    func isValidEmail(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func generateKeychainAttributes(name: String, email: String, password: String) -> [String: Any] {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: name,
            kSecAttrAccount as String: email,
            kSecValueData as String: password.data(using: .utf8) as Any,
        ]
    }
}
