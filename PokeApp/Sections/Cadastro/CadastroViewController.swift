//
//  CadastroViewController.swift
//  PokeApp
//
//  Created by Usr_Prime on 16/03/22.
//

import UIKit

class CadastroViewController: KeyboardViewController {
    
    let viewModel = CadastroViewModel()

    @IBOutlet weak var registerBackground: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameRequirementsLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailRequirementsLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordRequirementsLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        registerBackground.layer.cornerRadius = 35
        nameTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderWidth = 0.5
        enterButton.layer.cornerRadius = 10
    }
    @IBAction func registerButtonClick(_ sender: Any) {
        self.viewModel.registerUser(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
    }
}
extension CadastroViewController: CadastroViewDelegate {
    func showError(message: String, field: RegisterFields) {
        self.enterButton.backgroundColor = .red
        switch field {
        case .name:
            nameRequirementsLabel.text = message
            nameTextField.layer.borderColor = UIColor.red.cgColor
        case .email:
            emailRequirementsLabel.text = message
            emailTextField.layer.borderColor = UIColor.red.cgColor
        case .password:
            passwordRequirementsLabel.text = message
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    func registerSuccessful() {
        self.navigationController?.popViewController(animated: true)
    }
    func setFieldsToDefault() {
        nameTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        
        nameRequirementsLabel.text = ""
        emailRequirementsLabel.text = ""
        passwordRequirementsLabel.text = ""
    }
}
