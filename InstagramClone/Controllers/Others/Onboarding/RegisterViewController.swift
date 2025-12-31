//
//  RegisterViewController.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 31/12/25.
//

import UIKit

class RegisterViewController: UIViewController {
    struct Constants {
        static let cornerRadius :CGFloat = 8.0
    }
    
    private let userEmailField :UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address"
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame :CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.cornerRadius = Constants.cornerRadius
//        field.borderStyle = .roundedRect
        return field
    }()
    private let userNameField :UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame :CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.cornerRadius = Constants.cornerRadius
//        field.borderStyle = .roundedRect
        return field
    }()
    private let passwordField :UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
//        password.borderStyle = .roundedRect
        password.returnKeyType = .done
        password.backgroundColor = .secondarySystemBackground
        password.leftViewMode = .always
        password.leftView = UIView(frame :CGRect(x: 0, y: 0, width: 10, height: 0))
        password.autocapitalizationType = .none
        password.autocorrectionType = .no
        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor.secondaryLabel.cgColor
        password.layer.masksToBounds = true
        password.layer.cornerRadius = Constants.cornerRadius
        password.isSecureTextEntry = true
        return password
    }()
    
    private let signUpButton :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        signUpButton.addTarget(self, action: #selector(didRegistrationBtnTapped), for: .touchUpInside)
        userNameField.delegate = self
        userEmailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let padding: CGFloat = 10
        let fieldHeight: CGFloat = 52
        let contentWidth: CGFloat = view.bounds.width - (padding * 2)
        let topY: CGFloat = view.safeAreaInsets.top + 80

        userNameField.frame = CGRect(x: padding,
                                     y: topY,
                                     width: contentWidth,
                                     height: fieldHeight)

        userEmailField.frame = CGRect(x: padding,
                                      y: userNameField.bottom + 10,
                                      width: contentWidth,
                                      height: fieldHeight)

        passwordField.frame = CGRect(x: padding,
                                     y: userEmailField.bottom + 10,
                                     width: contentWidth,
                                     height: fieldHeight)

        signUpButton.frame = CGRect(x: padding,
                                    y: passwordField.bottom + 20,
                                    width: contentWidth,
                                    height: fieldHeight)
    }
    @objc private func didRegistrationBtnTapped(){
        userNameField.resignFirstResponder()
        userEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        AuthManager.shared.registerUser(username: userNameField.text, email: userEmailField.text, password: passwordField.text!) { inserted in
            if inserted {
                print("Successfully implemented")
            } else {
                print("Please check your input error occured")
            }
        }
        
    }
    private func addSubViews(){
        view.addSubview(userNameField)
        view.addSubview(userEmailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        
        guard let userName = userNameField.text,!userName.isEmpty,let userEmail = userEmailField.text,!userEmail.isEmpty,let password = passwordField.text,!password.isEmpty else {
            return
        }
        
    }

}
extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
                userEmailField.becomeFirstResponder()
        } else if textField == userEmailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true
        }
        return true
    }
}
