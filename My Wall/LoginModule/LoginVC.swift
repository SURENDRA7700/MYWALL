//
//  LoginVC.swift
//  My Wall
//
//  Created by surendra on 29/11/20.
//

import UIKit
import SideMenuSwift

class LoginVC: UIViewController {

    var window: UIWindow?

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
    
    
   
    let logoImageView: UrlImageView  = {
        let imageView = UrlImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "twitterIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    
    let userName: UILabel  = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Sri K.T.Rama Rao"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    let userDesignation: UILabel  = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        let font = UIFont(name: "HelveticaNeue", size: 16.0)!
        label.font = font
        label.text = "Hon'ble Minister for MA & UD, Industries & Commerce, Information Technology, Electronics & Communications Government of Telangana"
        return label
    }()
    
    let topView = UIView()
    let bottomView = UIView()
    
    let shadowView : ShadowCustomView = {
        let shadowVw = ShadowCustomView()
        shadowVw.backgroundColor = UIColor.white
        shadowVw.translatesAutoresizingMaskIntoConstraints = false
        return shadowVw
    }()

    
    let loginTitle : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "LOG IN"
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
        label.text = "USER NAME"
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
        return textField
    }()

    
    let tmsButtn: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.textAlignment = .center
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "blank-check-box"), for: .normal)
        return button
    }()
    
    
    let showPassWord : UILabel  = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.primaryEnglish(size: 18)
        label.text = "Show Password"
        label.textColor = UIColor.MyWall.Black
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    
    
    let loginButton: KetoButton = {
        let button = KetoButton(type: .custom)
        let fgpassword = "LOGIN"
        button.setTitle(fgpassword, for: .normal)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 18)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 30
        return button
    }()
    
    
    let signUpButton: KetoButton = {
        let button = KetoButton(type: .custom)
        let fgpassword = "SIGNUP"
        button.setTitle(fgpassword, for: .normal)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 18)
        button.titleLabel?.textAlignment = .center
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 30
        return button
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.ConfigureViews()
    }
    
    
    func ConfigureViews()
    {
        self.navigationController?.navigationBar.isHidden = true
        UINavigationBar.appearance().barTintColor = UIColor.MyWall.appColor
        UINavigationBar.appearance().tintColor = UIColor.MyWall.appColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        self.view.backgroundColor = UIColor.MyWall.appColor

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

        
        topView.backgroundColor = UIColor.MyWall.appColor
        topView.translatesAutoresizingMaskIntoConstraints   = false
        fieldsContainer.addSubview(topView)
        topView.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: 0).isActive = true
        topView.topAnchor.constraint(equalTo: fieldsContainer.topAnchor, constant: 0).isActive = true
//        topView.heightAnchor.constraint(equalTo: fieldsContainer.heightAnchor, multiplier: 0.5).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 260).isActive = true

        

        
        topView.addSubview(logoImageView)
        logoImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 0).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoImageView.layer.cornerRadius = 50
        logoImageView.clipsToBounds = true

        topView.addSubview(userName)
        userName.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 15).isActive = true
        userName.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 0).isActive = true
        userName.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0).isActive = true
        userName.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0).isActive = true
        
        topView.addSubview(userDesignation)
        userDesignation.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 15).isActive = true
        userDesignation.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 0).isActive = true
        userDesignation.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0).isActive = true
        userDesignation.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0).isActive = true
        
        
        bottomView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bottomView.translatesAutoresizingMaskIntoConstraints   = false
        fieldsContainer.addSubview(bottomView)
        bottomView.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: 0).isActive = true
        bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
//        bottomView.heightAnchor.constraint(equalTo: fieldsContainer.heightAnchor, multiplier: 0.65).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 500).isActive = true


        bottomView.addSubview(shadowView)
        shadowView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 40).isActive = true
        shadowView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 0).isActive = true
        shadowView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 30).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -30).isActive = true
        shadowView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.75).isActive = true

        shadowView.addSubview(loginTitle)
        loginTitle.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 30).isActive = true
        loginTitle.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 0).isActive = true
        loginTitle.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 0).isActive = true
        loginTitle.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 0).isActive = true

        shadowView.addSubview(userNameStatcLabel)
        userNameStatcLabel.topAnchor.constraint(equalTo: loginTitle.bottomAnchor, constant: 30).isActive = true
        userNameStatcLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20).isActive = true
        userNameStatcLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -20).isActive = true

        shadowView.addSubview(usernameField)
        usernameField.topAnchor.constraint(equalTo: userNameStatcLabel.bottomAnchor, constant: 5).isActive = true
        usernameField.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20).isActive = true
        usernameField.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -20).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: 44).isActive = true

        shadowView.addSubview(passwordStatsLabel)
        passwordStatsLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 30).isActive = true
        passwordStatsLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20).isActive = true
        passwordStatsLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -20).isActive = true
        
        shadowView.addSubview(passwordField)
        passwordField.topAnchor.constraint(equalTo: passwordStatsLabel.bottomAnchor, constant: 5).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 44).isActive = true

        shadowView.addSubview(tmsButtn)
        NSLayoutConstraint.activate([
            tmsButtn.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20),
            tmsButtn.topAnchor.constraint(equalTo: passwordField.bottomAnchor,constant: 20),
            tmsButtn.heightAnchor.constraint(equalToConstant: 20),
            tmsButtn.widthAnchor.constraint(equalToConstant: 20)
        ])
        tmsButtn.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)

        
        shadowView.addSubview(showPassWord)
        NSLayoutConstraint.activate([
            showPassWord.leadingAnchor.constraint(equalTo: tmsButtn.leadingAnchor, constant: 35),
            showPassWord.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -20),
            showPassWord.topAnchor.constraint(equalTo: passwordField.bottomAnchor,constant: 23),
            showPassWord.centerYAnchor.constraint(equalTo: tmsButtn.centerYAnchor, constant: 0)
        ])
        
        bottomView.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -25).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 30).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loginButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        
        bottomView.addSubview(signUpButton)
        signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 30).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -30).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        signUpButton.addTarget(self, action: #selector(sighUpClicked), for: .touchUpInside)

        
        self.scrollView.contentSize.height = 860


    }

    @objc  func sighUpClicked() {
        
        let signUpVC = SignUpVC()
        signUpVC.modalPresentationStyle = .fullScreen
        let rootNC = UINavigationController(rootViewController: signUpVC)
        self.present(rootNC, animated: true, completion: nil)
        
    }


        
    func validateFields() -> Bool {
        var validUserName: Bool = true
        var validPassword: Bool = true
        if let userName = usernameField.text {
            validUserName = userName.utf8.count > 0
            if !validUserName {
                usernameField.displayErrorPlaceholder("Please enter your email")
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

    
    func loginTOHomeScreen()
    {
        let userDefaults = UserDefaults.standard
        userDefaults.set("isLogin", forKey: "isLogin")
        userDefaults.synchronize()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.displayScreen()
    }

    @objc  func loginClicked() {
       // self.TempLogin()
        
        self.view.backgroundColor = UIColor.MyWall.appColor
        self.view.endEditing(true)
        guard validateFields() else {return}
        guard let userName = usernameField.text else {return}
        guard let userPassword = passwordField.text else {return}
        UserDefaults.standard.set("Basic aWFtY2xpZW50OnN5c3RlbTM4NTY3", forKey: "basicToken")
        UserDefaults.standard.synchronize()
        
        let parameters = ["username":userName, "password":userPassword,"grant_type":"password"]
        usernameField.clearError()
        passwordField.clearError()
        let activityView = MyActivityView()
        activityView.displayLoader()
        
        
        ApiService.sharedManager.startPostApiServiceWithToken(myHelper.userLogin, parameters, success: { (urlData) in
            activityView.dismissLoader()
            
            do {
                let rootDic = try JSONDecoder().decode(LoginModal.self, from: urlData)
                guard (rootDic.accessToken.utf8.count != 0) else {
                    ErrorManager.showErrorAlert(mainTitle: "", subTitle: "errorstring")
                    return
                }
                

                DispatchQueue.main.async { [self] in
                    let defaults = UserDefaults.standard
                    defaults.set(userPassword, forKey: USERPASSWORD)
                    defaults.synchronize()

                    UserManager.setUserLogin(stUser: rootDic)
                    self.checkRoleForUser()
//                    self.loginTOHomeScreen()
                }

            } catch  {
                do {
                    let errorModel = try JSONDecoder().decode(ErrorModel.self, from: urlData)
                    ErrorManager.showErrorAlert(mainTitle: errorModel.error, subTitle: errorModel.errorDescription)
                }
                catch {
                    ErrorManager.showErrorAlert(mainTitle: "invalid_grant", subTitle: error.localizedDescription)
                }
            }

        })
        { (errorString) in
            activityView.dismissLoader()
            ErrorManager.showErrorAlert(mainTitle: "", subTitle: errorString)
        }
       

    }
    
    
    func checkRoleForUser()
    {
        
        let activityView = MyActivityView()
        activityView.displayLoader()
        
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }

        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(myHelper.userLoginsettingspolicies, parameters) { (urlData) in
            
            activityView.dismissLoader()
            do {
                let rootDic = try JSONDecoder().decode(LoginUserModel.self, from: urlData)
                guard (rootDic.user.roles.count > 0) else {
                    ErrorManager.showErrorAlert(mainTitle: "", subTitle: "errorstring")
                    return
                }
                DispatchQueue.main.async {
                    let roleSYS_ADMIN = rootDic.user.roles.first
                    let roleADMIN = rootDic.user.roles[1]
                    if roleSYS_ADMIN == "" || roleADMIN == "ADMIN" {
                        UserManager.setUserLoginInfo(stUser: rootDic)
                        self.loginTOHomeScreen()
                    }else{
                        ErrorManager.showErrorAlert(mainTitle: "", subTitle: "Unauthorized user")
                    }
                }

            } catch (let error) {
                do {
                    let errorModel = try JSONDecoder().decode(ErrorModel.self, from: urlData)
                    ErrorManager.showErrorAlert(mainTitle: errorModel.error, subTitle: errorModel.errorDescription)
                }
                catch {
                    ErrorManager.showErrorAlert(mainTitle: "", subTitle: error.localizedDescription)
                }
            }
            
        }
        
        failure: { (errorString) in
            
            
        }
        
        
    }
    
    
    
    
    

    

    
    @objc func resetPassword(){
        

    }
    
    
    @objc func showPassword(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
            self.passwordField.isSecureTextEntry = false
        }else{
            sender.setImage(#imageLiteral(resourceName: "blank-check-box"), for: .normal)
            self.passwordField.isSecureTextEntry = true
        }
    }
    
   
    
    
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

}



struct LoginModal: Codable {
    let accessToken, tokenType, refreshToken: String
    let expiresIn: Double
    let scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case scope
    }
}





struct LoginUserModel: Codable {
    let user: User
    let policies: [Policy]
}

// MARK: - Policy
struct Policy: Codable {
    let id, object: String
    let canCreate, canView: Bool
    let roleID: String
    let editable: Bool

    enum CodingKeys: String, CodingKey {
        case id, object, canCreate, canView
        case roleID = "roleId"
        case editable
    }
}

// MARK: - User
struct User: Codable {
    let id, username, password: String
    let firstTimeLogin, active: Bool
    let roles: [String]
}


extension UIView {
    
    func textDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }

}


extension UIButton {
    
    func dropShaow() {
        layer.shadowColor = UIColor.MyWall.appColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 6
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }

}
