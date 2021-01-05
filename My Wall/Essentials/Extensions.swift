//
//  Extensions.swift
//  GACA
//
//  Created by Mahroof on 17/11/2018.
//  Copyright © 2018 Mahroof. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
}


public extension UIImage {
    
    static let successImage = UIImage(named: "success")
    static let warningImage = UIImage(named: "warning")
    
    func flip() -> UIImage {
        let image = UIImage(cgImage: self.cgImage!, scale: self.scale, orientation: UIImage.Orientation.upMirrored)
        return image
    }
    
    func fixedOrientation() -> UIImage? {
        
        guard imageOrientation != UIImage.Orientation.up else {
            //This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        
        guard let cgImage = self.cgImage else {
            //CGImage is not available
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil //Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
            break
        case .up, .upMirrored:
            break
        }
        
        //Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
}
}


extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width,y: 0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addMiddleBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:self.frame.size.width/2, y:0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
}

extension UITextField {
    
    func setCustomPlaceHolder(_ placeholder: String?, fontSize: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.minimumLineHeight = (self.font?.lineHeight)! - ((self.font?.lineHeight)! - (UIFont.primaryArabic(size: fontSize).lineHeight)) / 2.0
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: UIColor.clear,
                          NSAttributedString.Key.font : UIFont.primaryArabic(size: fontSize)]
        self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
    }
    
    func setCustomPlaceHolder(_ placeholder: String?, fontSize: CGFloat, color: UIColor) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.minimumLineHeight = (self.font?.lineHeight)! - ((self.font?.lineHeight)! - (UIFont.primaryArabic(size: fontSize).lineHeight)) / 2.0
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: color,
                          NSAttributedString.Key.font : UIFont.primaryArabic(size: fontSize)]
        self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
    }
    
    func displayErrorPlaceholder(_ placeholder: String?) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                          NSAttributedString.Key.foregroundColor: UIColor.MyWall.errorColor,
                          NSAttributedString.Key.font : UIFont.primaryArabic(size: 11)]
        if let val = placeholder {
            self.attributedPlaceholder = NSAttributedString(string: val, attributes: attributes)
        }
    }
}

public extension String {
    
    func weekDay() -> String {
        let df = DateFormatter()
        //        df.locale = NSLocale(localeIdentifier: "ar_SA") as Locale
        df.dateFormat = "yyyy-MM-dd"
        
        let dfWeekDay = DateFormatter()
        dfWeekDay.dateFormat = "EEEE"
//        dfWeekDay.locale = NSLocale(localeIdentifier: "ar_SA") as Locale
        if let date = df.date(from: self){
            return dfWeekDay.string(from: date)
        }else{
            return ""
        }
        
    }
    
    
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    
    
    /*
     Validate email string
     - parameter email: A String that rappresent an email address
     - returns: A Boolean value indicating whether an email is valid. */
    func isValidEmail() -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidGACAEmail() -> Bool {
        let validDomains = ["gaca.gov.sa"]
        if let domain = self.components(separatedBy: "@").last, validDomains.contains(domain) {
            return true
        }else{
            return false
        }
    }
    
    //let validDomains = ["gmail.com", "yahoo.com", "comcast.net", "hotmail.com", "msn.com", "verizon.net"]
 
    
    public var validPhoneNumber:Bool {
        let types:NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count)).first?.phoneNumber {
            return match == self
        }else{
            return false
        }
    }
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
}

public extension DispatchQueue {
    class func delayWithSeconds(_ seconds: TimeInterval, completion: @escaping (() -> Void) ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}

extension Date {
    func getMonth() -> Int {
//        let date = self
        let calendar = Calendar.current
        
//        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: self)
//        let day = calendar.component(.day, from: date)
        return month
    }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    func weekDayString() -> String {
        let df = DateFormatter()
//        df.locale = NSLocale(localeIdentifier: "ar_SA") as Locale
        df.dateFormat = "dd-MM-YYYY"
        
        let dfWeekDay = DateFormatter()
        dfWeekDay.dateFormat = "EEEE"
        dfWeekDay.locale = NSLocale(localeIdentifier: "ar_SA") as Locale
        
        
        return "\(dfWeekDay.string(from: self)) \(df.string(from: self))" 
    }
    
    func formattedString() -> String {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-YYYY"
        return df.string(from: self)
    }
    
    func cartAPIformat() -> String {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df.string(from: self)
    }
}

extension NSAttributedString{
    class func addCommonLineSpacing(text : String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        // *** Set Attributed String to your label ***
        return attributedString
        
    }
}

extension UIViewController{
    func HideNavBar() {
        self.navigationController?.navigationBar.isHidden = true;
    }
    func ShowNavBar() {
        self.navigationController?.navigationBar.isHidden = false;
//        self.navigationItem.setHidesBackButton(true, animated: true);
//        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
//        backButton.setImage(UIImage(named: "arrow"), for: .normal)
//        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        
    }
    
    
//    @objc func backAction () {
//        self.navigationController?.popViewController(animated: true)
//    }
//
}

extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}


extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }

}
