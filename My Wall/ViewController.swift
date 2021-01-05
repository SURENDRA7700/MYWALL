//
//  ViewController.swift
//  My Wall
//
//  Created by surendra on 29/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    var splashViewCopy :CBZSplashView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
//        if UserDefaults.standard.value(forKey: "isLogin") == nil{
//            let splashView :CBZSplashView = CBZSplashView.init(icon: #imageLiteral(resourceName: "twitterIcon"), backgroundColor: UIColor.white)
//            splashView.animationDuration = 1.4;
//            splashView.iconStartSize = CGSize(width: 100, height: 100)
//            splashViewCopy = splashView
//            self.view.addSubview(splashView)
//            self.splashViewCopy.startAnimation()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.view.backgroundColor = .white
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.isFirstTimeLaunch = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.isFirstTimeLaunch = true
        appDelegate.displayScreen()

//        if (self.splashViewCopy != nil) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.isFirstTimeLaunch = true
//                appDelegate.displayScreen()
//            }
//        }
       
   }

    
    

}

