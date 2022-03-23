//
//  ViewController.swift
//  PokeApp
//
//  Created by Usr_Prime on 16/03/22.
//

import UIKit

class LoginViewController: UIViewController {
    let viewModel = LoginViewModel()

    @IBOutlet weak var loginBackground: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var notFoundLabel: UILabel!
    
    func setupView() {
        loginBackground.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderWidth = 0.5
        enterButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupView()
       
        emailTextField.text = viewModel.getLastAccessedEmail()
    }
    @IBAction func loginButtonClick(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        self.viewModel.authenticate(email: email, password: password)
    }
    @IBAction func registerButtonsClick(_ sender: Any) {
        self.performSegue(withIdentifier: "Cadastrar", sender: nil)
    }
}
extension LoginViewController: LoginViewDelegate {
    func setFieldsToDefault() {
        emailTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        notFoundLabel.text = ""
    }
    func showError(with message: String) {
        notFoundLabel.text = message
        enterButton.backgroundColor = .orange
    }
    func callSegue() {
        self.performSegue(withIdentifier: "cameIn", sender: nil)
    }
    func failedAuthentication(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
