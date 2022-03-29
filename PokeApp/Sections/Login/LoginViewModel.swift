//
//  LoginViewModel.swift
//  PokeApp
//
//  Created by Usr_Prime on 16/03/22.
//

import UIKit
import LocalAuthentication

protocol LoginViewDelegate: AnyObject {
    func showError(with message: String)
    func setFieldsToDefault()
    func callSegue()
    func failedAuthentication(title: String, message: String)
}

class LoginViewModel {
    var delegate: LoginViewDelegate?
    var userCanLogin = true
    
    func authenticate(email: String, password: String) {
        self.delegate?.setFieldsToDefault()
        userCanLogin = true
        
        verify(value: email)
        
        if canLoginWithFaceId(email: email) {
            if authFaceId(email) {
                self.delegate?.callSegue()
            }
        } else {
            verify(value: password)
            if authenticateWithEmail(email: email, password: password) {
                self.delegate?.callSegue()
            }
        }
    }
    func canLoginWithFaceId(email: String) -> Bool{
        let lastLoggedUser = getLastAccessedEmail()
        return email == lastLoggedUser
    }
    func authenticateWithEmail(email: String, password: String) -> Bool {
        if let existingItem = getUserBy(email: email) {
            if validateEmail(email, userData: existingItem) && validatePassword(password, userData: existingItem) {
                if self.registerAccess(with: email) {
                    return true
                }
            } else {
                self.delegate?.showError(with: "Usuario ou senha incorreta")
            }
        } else {
            self.delegate?.showError(with: "Usuario ou senha incorreta")
        }
        return false
    }
    func verify(value: String) {
        if value == "" {
            userCanLogin = false
        }
    }
    private func getUserBy(email: String) -> [String: Any]? {
        var item: CFTypeRef?
        if SecItemCopyMatching(makeQuery(email) as CFDictionary, &item) == noErr {
            return item as? [String: Any]
        } else { return nil }
    }
    private func validatePassword(_ userPassword: String, userData:[String: Any]) -> Bool {
        if let password = userData[kSecValueData as String] as? Data {
            return password == userPassword.data(using: .utf8)
        } else {
            return false
        }
    }
    private func validateEmail(_ email: String, userData:[String: Any]) -> Bool {
        if let id = userData[kSecAttrAccount as String] as? String {
            return email == id
        } else {
            return false
        }
    }
    private func addLastAccessedEmail(email: String) -> Bool {
        let attributesAdd: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "lastAccessedEmail",
            kSecAttrService as String: "service",
            kSecValueData as String: email.data(using: .utf8)!
        ]
        return SecItemAdd(attributesAdd as CFDictionary, nil) == noErr
    }
    private func updateLastAccessedEmail(email: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "lastAccessedEmail",
            kSecAttrService as String: "service",
        ]
        let attributes: [String: Any] = [kSecValueData as String: email.data(using: .utf8)!]
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr
    }
    func getLastAccessedEmail() -> String {
        var item: CFTypeRef?
        if SecItemCopyMatching(makeQuery("lastAccessedEmail") as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let loginData = existingItem[kSecValueData as String] as? Data,
               let login = String(data: loginData, encoding: .utf8) {
                return "\(login)"
            }
        }
        return ""
    }
    func getUserName(email: String) -> String {
        var item: CFTypeRef?
        if SecItemCopyMatching(makeQuery(email) as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let name = existingItem[kSecAttrService as String] as? String {
                return "\(name)"
            }
        }
        return "--"
    }
    private func registerAccess(with email: String) -> Bool {
        return addLastAccessedEmail(email: email) ? true : updateLastAccessedEmail(email: email)
    }
    func authFaceId(_ email: String) -> Bool{
        if let existingItem = getUserBy(email: email){
            if validateEmail(email, userData: existingItem) {
                faceIDAutentication()
            }
        }
        return false
    }
    func faceIDAutentication(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let text_reason = "We need to access your face"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: text_reason)
                { [weak self] success, authenticationError in DispatchQueue.main.async {
                    if success {
                        self?.delegate?.callSegue()
                    } else {
                        self?.delegate?.failedAuthentication(title: "Falha na autenticação", message: "Você não pode ser verificado")
                    }
                }
            }
        } else {
            self.delegate?.failedAuthentication(title: "Biometria Indisponível", message: "Seu dispositivo não é configurado para autenticação por biometria")
        }
    }
    func makeQuery(_ element: String) -> [String : Any]{
         return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: element,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
         ]
    }
}
