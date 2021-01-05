//
//  ErrorManager.swift
//  Rasedi
//
//  Created by Vijesh on 29/03/2018.
//  Copyright © 2018 DNet. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    func vibrate(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    /// Display  UITextField in red color, with a vibration
    public func displayError() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.layer.borderColor = UIColor.MyWall.errorColor.cgColor
        }) { (finish) in
            self.vibrate()
        }
    }
    
    /// Display  UITextField in red color, with a optional vibrate value
    public func displayError(vibrated: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.layer.borderColor = UIColor.red.cgColor
        }) { (finish) in
            if vibrated {
                self.vibrate()
            }
        }
    }
    
    /// Clear the error from UITextField
    public func clearError() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.layer.borderColor = UIColor.clear.cgColor
        }, completion: nil)
    }
    
}

extension UILabel {
    
    /// Display label in red color, with a vibrate
    public func displayErrorLabel() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }) { (finish) in
            self.vibrate()
        }
    }
    
    /// clear label, set to normal color
    public func clearErrorLabel() {
        if self.alpha == 1.0 {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.alpha = 0.0
            }, completion: nil)
        }
    }
    
    
}

class ErrorManager: NSObject {
    public static func showErrorAlert(mainTitle: String?, subTitle: String?) {
        let banner = MyBanner(title: mainTitle, subtitle: subTitle, image: UIImage.warningImage, backgroundColor: UIColor.MyWall.errorColor)
        banner.titleLabel.font = UIFont.primaryArabic(size: 18)
        banner.titleLabel.numberOfLines = 0

        banner.didDismissBlock = {
//            self.isErrorAlertDismissed = true
        }
        banner.show(duration: 1.5)
    }
    
    public static func showErrorAlert(mainTitle: String?, subTitle: String?, withDuration: TimeInterval?) {
        let banner = MyBanner(title: mainTitle, subtitle: subTitle, image: UIImage.warningImage, backgroundColor: UIColor.MyWall.errorColor)
        banner.titleLabel.font = UIFont.primaryArabic(size: 18)
        banner.didDismissBlock = {
            //            self.isErrorAlertDismissed = true
        }
        banner.show(duration: withDuration)
    }
    
    
    public  static func showSuccessAlert(mainTitle: String?, subTitle: String?) {
        let banner = MyBanner(title: mainTitle, subtitle: subTitle, image: UIImage.successImage, backgroundColor: UIColor.MyWall.successColor)
        banner.detailLabel.font = UIFont.primaryArabic(size: 18)
        banner.didDismissBlock = {
            
//            self.isErrorAlertDismissed = true
            //            self.dismissPage
        }
        banner.show(duration: 1.5)
    }
    

    public  static func showSuccessAlertWithMessageCode(messageCode: Any?, subTitle: String?) {
        guard let msgCode = messageCode else {return}
        let message = ErrorManager.getErrorFromErrorCode(code: msgCode)

        let banner = MyBanner(title: message, subtitle: subTitle, image: UIImage.successImage, backgroundColor: UIColor.MyWall.successColor)
        banner.titleLabel.font = UIFont.primaryArabic(size: 18)

        banner.detailLabel.font = UIFont.primaryArabic(size: 18)
        banner.titleLabel.numberOfLines = 0
        banner.didDismissBlock = {
            
            //            self.isErrorAlertDismissed = true
            //            self.dismissPage
        }
        banner.show(duration: 1.5)
    }
    public static func showErrorAlertWithMessageCode(messageCode: Any?, subTitle: String?, withDuration: TimeInterval = 1.5) {
        guard let msgCode = messageCode else {return}
        let message = ErrorManager.getErrorFromErrorCode(code: msgCode)
        let banner = MyBanner(title: message, subtitle: subTitle, image: UIImage.warningImage, backgroundColor: UIColor.MyWall.errorColor)
        banner.titleLabel.font = UIFont.primaryArabic(size: 18)
//        banner.titleLabel.adjustsFontSizeToFitWidth = true
        banner.titleLabel.numberOfLines = 0
        banner.didDismissBlock = {
            //            self.isErrorAlertDismissed = true
        }
        banner.show(duration: withDuration)
    }
    
    
    
    
    public  static func getErrorFromErrorCode(code: Any) -> String{
        return code as! String
    }
        
    
}
