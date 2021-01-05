//
//  SignUpVC.swift
//  My Wall
//
//  Created by surendra on 15/12/20.
//

import UIKit

class SignUpVC: UIViewController {
    
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let fieldsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let loginTitle : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "SIGN UP"
        let boldHelveticaFont = UIFont(name: "HelveticaNeue", size: 25)?.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)
        label.font = UIFont(descriptor: boldHelveticaFont!, size: 25)
        return label
    }()

    
    let userNameStatcLabel : UILabel  = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.text = "Email"
        let boldHelveticaFont = UIFont(name: "HelveticaNeue", size: 16)?.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)
        label.font = UIFont(descriptor: boldHelveticaFont!, size: 16)
        return label
    }()
    
    
    let usernameField: HSUnderLineTextField = {
        let textField = HSUnderLineTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = UIReturnKeyType.default
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.placeholder = "Please enter email"
        textField.textAlignment = LangUtils.isLangArabic() ? .right : .left
        return textField
    }()
    
    
    let passwordStatsLabel : UILabel  = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.text = "PASSWORD"
        let boldHelveticaFont = UIFont(name: "HelveticaNeue", size: 16)?.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)
        label.font = UIFont(descriptor: boldHelveticaFont!, size: 16)
        return label
    }()
    
    
    let passwordField: HSUnderLineTextField = {
        let textField = HSUnderLineTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = UIReturnKeyType.default
        textField.keyboardType = .emailAddress
        textField.textAlignment = LangUtils.isLangArabic() ? .right : .left
        textField.isSecureTextEntry = true
        textField.placeholder = "Please enter password"
        return textField
    }()

    
    let loginButton: KetoButton = {
        let button = KetoButton(type: .custom)
        let fgpassword = "Sign Up"
        button.setTitle(fgpassword, for: .normal)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 18)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 30
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SIGN-UP"
        self.ConfigureNavBarDetils()
        self.configureView()

        // Do any additional setup after loading the view.
    }


    func configureView()
    {
        view.addSubview(scrollView)
        scrollView.keyboardDismissMode = .interactive
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.backgroundColor = UIColor.MyWall.White
        
        scrollView.addSubview(fieldsContainer)
        fieldsContainer.translatesAutoresizingMaskIntoConstraints = false
        fieldsContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:0).isActive = true
        fieldsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        fieldsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        fieldsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        
        fieldsContainer.addSubview(loginTitle)
        loginTitle.topAnchor.constraint(equalTo: fieldsContainer.topAnchor, constant: 80).isActive = true
        loginTitle.centerXAnchor.constraint(equalTo: fieldsContainer.centerXAnchor, constant: 0).isActive = true
        loginTitle.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 0).isActive = true
        loginTitle.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: 0).isActive = true

        
        fieldsContainer.addSubview(userNameStatcLabel)
        userNameStatcLabel.topAnchor.constraint(equalTo: loginTitle.bottomAnchor, constant: 30).isActive = true
        userNameStatcLabel.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 20).isActive = true
        userNameStatcLabel.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: -20).isActive = true

        fieldsContainer.addSubview(usernameField)
        usernameField.topAnchor.constraint(equalTo: userNameStatcLabel.bottomAnchor, constant: 5).isActive = true
        usernameField.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 20).isActive = true
        usernameField.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: -20).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: 44).isActive = true

        
        fieldsContainer.addSubview(passwordStatsLabel)
        passwordStatsLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 30).isActive = true
        passwordStatsLabel.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 20).isActive = true
        passwordStatsLabel.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: -20).isActive = true
        
        fieldsContainer.addSubview(passwordField)
        passwordField.topAnchor.constraint(equalTo: passwordStatsLabel.bottomAnchor, constant: 5).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 44).isActive = true

        
        fieldsContainer.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 50).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 30).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: -30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loginButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)


    }
   
    func validateFields() -> Bool {
        var validUserName: Bool = true
        var validPassword: Bool = true
        if let userName = usernameField.text {
            validUserName = isValidEmail(userName)
            if !validUserName {
                usernameField.displayErrorPlaceholder("Please enter valid email")
                if usernameField.text?.isEmpty == false {
                    ErrorManager.showErrorAlert(mainTitle: "Please enter valid email", subTitle: "")
                }
                usernameField.displayError()
            }
        }
        if let userPassword = passwordField.text {
            validPassword = userPassword.utf8.count > 0
            if !validPassword {
                passwordField.displayErrorPlaceholder("Please enter your Password")
                passwordField.displayError()
            }
        }
        return validUserName && validPassword
    }
    
    @objc  func loginClicked() {
        
        self.view.endEditing(true)
        guard validateFields() else {return}
        let activityView = MyActivityView()
        activityView.displayLoader()

        guard let userName = usernameField.text else {return}
        guard let userPassword = passwordField.text else {return}
        
        UserDefaults.standard.set(userName, forKey: "usernameField")
        UserDefaults.standard.set(userPassword, forKey: "passwordField")
        UserDefaults.standard.synchronize()
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.view.makeToast("Sign Up created Successfully....Admin contact you soon")
            activityView.dismissLoader()
        }
    }

    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

