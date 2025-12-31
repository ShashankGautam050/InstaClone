//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 31/12/25.
//

import UIKit
import SafariServices
class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius :CGFloat = 8.0
    }
    private let userEmailField :UITextField = {
        let field = UITextField()
        field.placeholder = "Email/Username"
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
    
    private let loginButton :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    private let terms :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terms & Conditions", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let privacy :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let createAccount :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Users? Create Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let headerView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "instaBG"))
        view.addSubview(backgroundImageView)
        return view
    }()
    
    // MARK - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        userEmailField.delegate = self
        passwordField.delegate = self
        addSubViews()
        
        terms.addTarget(self, action: #selector(didTermsBtnTapped), for: .touchUpInside)
        privacy.addTarget(self, action: #selector(didPrivacyBtnTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didloginBtnTapped), for: .touchUpInside)
        createAccount.addTarget(self, action: #selector(didCreateAccountBtnTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // add frames for all the ui objects here
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0)
        userEmailField.frame = CGRect(x: 25, y: headerView.bottom + 60, width: view.width - 50, height: 52)
        
        passwordField.frame = CGRect(x: 25, y: userEmailField.bottom + 20, width: view.width - 50, height: 52)
        
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 20, width: view.width - 50, height: 52)
        createAccount.frame = CGRect(x: 25, y: loginButton.bottom + 20, width: view.width - 50, height: 52)
        privacy.frame = CGRect(x: 25, y: view.bottom - view.safeAreaInsets.bottom - 50, width: view.width - 50, height: 52)
        terms.frame = CGRect(x: 25, y: view.bottom - view.safeAreaInsets.bottom - 80, width: view.width - 50, height: 52)
        configureHeaderView()
        
        
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let imageView = headerView.subviews.first as? UIImageView else {
            return
        }
        
        imageView.frame = headerView.bounds
        // add instagram Logo
        
        let instaLogoImageView = UIImageView(image: UIImage(named: "insta"))
        headerView.addSubview(instaLogoImageView)
        instaLogoImageView.contentMode = .scaleAspectFit
        instaLogoImageView.tintColor = .white
        instaLogoImageView.backgroundColor = .clear
        
        instaLogoImageView.frame = CGRect(x: headerView.width/4.0 , y: view.safeAreaInsets.top, width: headerView.width/2.0, height: headerView.height - view.safeAreaInsets.top)
    }
    private func addSubViews(){
        view.addSubview(headerView)
        view.addSubview(userEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(terms)
        view.addSubview(createAccount)
        view.addSubview(privacy)
    }
    @objc private func didloginBtnTapped(){
        userEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let userEmail = userEmailField.text, !userEmail.isEmpty, let userPassword = passwordField.text, !userPassword.isEmpty else {
            print("null or empty")
            return
        }
        
        // login Logic
        
        var userName : String?
        var userMail : String?
        
        if userEmail.contains(".com") {
            userMail = userEmail
        } else {
            userName = userEmail
        }
        
        AuthManager.shared.loginUser(username: userName, email: userMail, password: self.passwordField.text!) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.dismiss(animated: true,completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "InstaCLone", message: "we are unable to login with the provided credentials", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    @objc private func didPrivacyBtnTapped(){
        guard let url = URL(string: "https://help.instagram.com/196883487377501/") else {
            return
        }
        
        let vc =  SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTermsBtnTapped(){
        guard let url = URL(string: "https://help.instagram.com/termsofuse") else {
            return
        }
        
        let vc =  SFSafariViewController(url: url)
        present(vc, animated: true)
    }
        
   @objc private func didCreateAccountBtnTapped(){
        let vc = RegisterViewController()
       vc.title = "Create Account"
       present(UINavigationController(rootViewController: vc), animated: true)
    }
   
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userEmailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

