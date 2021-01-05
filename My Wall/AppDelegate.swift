//
//  AppDelegate.swift
//  My Wall
//
//  Created by surendra on 29/11/20.
//

import UIKit
import IQKeyboardManagerSwift
import SideMenuSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var isFirstTimeLaunch = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        IQKeyboardManager.shared.enable = true
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if error != nil {
                print("Request authorization failed!")
            } else {
                print("Request authorization succeeded!")
            }
        }
        return true
    }

   
    func applicationDidBecomeActive(_ application: UIApplication) {
        if UserManager.isUserLoggedin() {
//            self.loginClicked()
            self.validateExpiry()
        }
    }

    
    
    func displayScreen() {
        if UserDefaults.standard.value(forKey: "isLogin") != nil{
            self.gotoPagesSideMenu()
            print("******** gotoPagesSideMenu *************")
        }else{
            print("******** LoginVC *************")
            let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC{
                let rootNC = UINavigationController(rootViewController: vc)
                self.window?.rootViewController = rootNC
                self.window?.makeKeyAndVisible()
            }
        }
    }
    
    
    func gotoPagesSideMenu() {
       let controller = DashBoardViewController()
       let menuViewController = MenuViewController()
       menuViewController.onCompletion = { success in}
       window = UIWindow(frame: UIScreen.main.bounds)
       window?.rootViewController = SideMenuController(contentViewController: controller,
                                                       menuViewController: menuViewController)
       SideMenuController.preferences.basic.menuWidth = (window?.frame.size.width)! - 60
       SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
       window?.makeKeyAndVisible()
       
   }
    
    func validateExpiry(){
        print(UserManager.sharedInstance.currentUser?.accessToken ?? "")
        var timeInterval = NSDate().timeIntervalSince1970
        timeInterval = timeInterval + UserManager.sharedInstance.currentUser!.expiresIn
        let currentDate = NSDate()
        let serverdate = NSDate.init(timeIntervalSince1970: timeInterval)
        if serverdate.compare(currentDate as Date) == ComparisonResult.orderedDescending {
//            self.displayScreen()
        }else{
            UserManager.setuserLogout()
            let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC{
                let rootNC = UINavigationController(rootViewController: vc)
                self.window?.rootViewController = rootNC
                self.window?.makeKeyAndVisible()
            }
        }
    }
    
    
    @objc  func loginClicked() {
       // self.TempLogin()
        
        UserDefaults.standard.set("Basic aWFtY2xpZW50OnN5c3RlbTM4NTY3", forKey: "basicToken")
        UserDefaults.standard.synchronize()
        
        guard let userName:String = UserManager.sharedInstance.currentUserInfomation?.user.username else {
            return
        }
        
        guard let password:String = UserDefaults.standard.value(forKey: USERPASSWORD) as? String else {
            return
        }
        
        let parameters = ["username":userName, "password":password,"grant_type":"password"]
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
                DispatchQueue.main.async {
                    UserManager.setUserLogin(stUser: rootDic)
                    self.validateExpiry()
                }

            } catch (let error) {
                do {
                    ErrorManager.showErrorAlert(mainTitle: "invalid_grant", subTitle: "Bad credentials")
                }
            }

        })
        { (errorString) in
            activityView.dismissLoader()
            ErrorManager.showErrorAlert(mainTitle: "", subTitle: errorString)
        }
       

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
     
     
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
    }
    
}

