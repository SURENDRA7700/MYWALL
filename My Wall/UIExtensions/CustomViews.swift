//
//  CustomViews.swift
//  Rasedi
//
//  Created by Vijesh on 29/03/2018.
//  Copyright © 2018 DNet. All rights reserved.
//

import UIKit
import Kingfisher



class NormalField: UITextField {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.primaryEnglish(size: 12)
        self.textColor = UIColor.darkGray
        self.borderStyle = UITextField.BorderStyle.none
        
        
        self.layer.cornerRadius = 6.0
        self.layer.borderWidth = 0.5
        
        
        
        self.backgroundColor = UIColor.white
        self.autocorrectionType = UITextAutocorrectionType.no
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.textAlignment = NSTextAlignment.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 6
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 6
        return leftViewRect
    }
    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
//    }
    
}



class IconRegisterField: RegisterField {

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 10
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 5
        return leftViewRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        //        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 55))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 55))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 55))
    }
    
    func setRightViewIcon(imageName: String?)  {
        guard let imageIcon = imageName else {return}

        let img = UIImage(named: imageIcon)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.black

        self.rightView = imageView
        self.rightViewMode = UITextField.ViewMode.always
        self.rightView?.clipsToBounds = true
        
    }
    
    
    
}



extension UILabel{
    
    func makeCompanyLabel(isBottom: Bool = true)  {
        let lineView = UIView()
        self.addSubview(lineView)
        if isBottom == false {
            lineView.bottomAnchor.constraint(equalTo: self.topAnchor, constant:0).isActive = true
        }else{
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:0).isActive = true
        }
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        lineView.trailingAnchor.constraint(equalToSystemSpacingAfter: self.trailingAnchor, multiplier: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.backgroundColor = UIColor.lightGray
        
        textAlignment = .center
//        self.textColor = UIColor.secondaryColor
    }
}


class HSUnderLineTextField: UITextField , UITextFieldDelegate {

    let border = CALayer()

    @IBInspectable open var lineColor : UIColor = UIColor.black {
        didSet{
            border.borderColor = lineColor.cgColor
        }
    }

    @IBInspectable open var selectedLineColor : UIColor = UIColor.black {
        didSet{
        }
    }


    @IBInspectable open var lineHeight : CGFloat = CGFloat(1.0) {
        didSet{
            border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        }
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate=self;
        border.borderColor = lineColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])


        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineHeight
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    
    required init?(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)
        self.delegate=self;
        border.borderColor = lineColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])


        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineHeight
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        self.delegate = self
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        border.borderColor = selectedLineColor.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        border.borderColor = lineColor.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}





class RegisterField: UITextField {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.primaryEnglish(size: 15)
        self.borderStyle = UITextField.BorderStyle.line
        self.autocorrectionType = UITextAutocorrectionType.no
        self.autocapitalizationType = .none
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.textAlignment = .right
        self.textColor = UIColor.MyWall.Black
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.MyWall.borderGray.cgColor
        self.clipsToBounds = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 5
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 5
        return leftViewRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    
    func setFieldImageIcon(imageName: String?) {
        guard let imageIcon = imageName else {
            return
        }
        let img = UIImage(named: imageIcon)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.rgb(red: 160, green: 160, blue: 160)
        self.leftView = imageView
        self.leftViewMode = UITextField.ViewMode.always
        self.leftView?.clipsToBounds = true
    }

    

  

}

class mobileField: RegisterField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        //        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
    }
    

    
    
}


class PasswordField: RegisterField {
    
    
    let btnShowHidePassword: UIButton  = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        //        imageView.alpha = 0
        btn.contentMode = .scaleAspectFit
        btn.setBackgroundImage(#imageLiteral(resourceName: "hidepassword"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    

    
    required init(frame: CGRect) {
        super.init(frame: frame)
        self.isSecureTextEntry = true
        let button = UIButton(type: .custom)
        button.setBackgroundImage(#imageLiteral(resourceName: "hidepassword"), for: .normal)
        button.frame = CGRect(x: self.frame.size.width - 40 , y: 5, width: 22, height: 22)
        button.addTarget(self, action: #selector(showpassword), for: .touchDown)
        button.addTarget(self, action: #selector(hidePasword), for: .touchUpInside)
        
        self.rightView = button
        self.rightViewMode = .always
        
    }
    
    @objc func showpassword(){

        self.isSecureTextEntry = false;

    }
    
    @objc func hidePasword(){
        self.isSecureTextEntry = true;
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FullWidthTextField: UITextField {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: "Cairo", size: 15.0)
        self.textColor = UIColor.darkGray
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 0.3
//        self.layer.borderColor = UIColor.normalColor.cgColor
        self.autocorrectionType = UITextAutocorrectionType.no
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 5
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 5
        return leftViewRect
    }
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 30, 0, 30))
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 30, 0, 30))
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 30, 0, 30))
//    }
    
}


class DropDownField: UITextField {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.primaryArabic(size: 15)

        self.textColor = UIColor.white
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 2.0
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor = UIColor.disableColor.cgColor
        self.autocorrectionType = UITextAutocorrectionType.no
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.textAlignment = NSTextAlignment.center
        
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    
//    override func selectionRects(for range: UITextRange) -> [Any] {
//        return []
//    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 4
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 4
        return leftViewRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        //        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    func setBottomLine()  {
        //        guard let imageIcon = imageName else {return}
        //
        //        let img = UIImage(named: imageIcon)?.withRenderingMode(.alwaysTemplate)
        //        let imageView = UIImageView(image: img)
        //        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //        imageView.contentMode = .scaleAspectFit
        //        imageView.tintColor = UIColor.black
        //
        //        self.rightView = imageView
        //        self.rightViewMode = UITextField.ViewMode.always
        //        self.rightView?.clipsToBounds = true
        
        let lineView = UIView()
        self.addSubview(lineView)
        lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:0).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        lineView.trailingAnchor.constraint(equalToSystemSpacingAfter: self.trailingAnchor, multiplier: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.backgroundColor = UIColor.lightGray
    }
    
    
}



extension DropDownField {
    
    func setFieldImageIcon(imageName: String?) {
        
        guard let imageIcon = imageName else {return}
        
        let img = UIImage(named: imageIcon)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.rgb(red: 150, green: 150, blue: 150)
        
//        if LangUtils.isLangArabic() {
//
            self.leftView = imageView
            self.leftViewMode = UITextField.ViewMode.always
            self.leftView?.clipsToBounds = true
//
//        } else {
//
//            self.rightView = imageView
//            self.rightViewMode = UITextField.ViewMode.always
//            self.rightView?.clipsToBounds = true
//        }
        
    }
    
    func setRightViewIcon(imageName: String?)  {
        guard let imageIcon = imageName else {return}

        let img = UIImage(named: imageIcon)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.rgb(red: 150, green: 150, blue: 150)
        
        self.rightView = imageView
        self.rightViewMode = UITextField.ViewMode.always
        self.rightView?.clipsToBounds = true
    }
    
    func setRightFieldICon(imageName: String?) {
        
        guard let imageIcon = imageName else {return}
        
        let img = UIImage(named: imageIcon)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.rgb(red: 150, green: 150, blue: 150)
        
//        if LangUtils.isLangArabic() {
//
//            self.leftView = imageView
//            self.leftViewMode = UITextField.ViewMode.always
//            self.leftView?.clipsToBounds = true
//
//        } else {
//
            self.rightView = imageView
            self.rightViewMode = UITextField.ViewMode.always
            self.rightView?.clipsToBounds = true
//        }
        
    }
}

class IconDropdown: DropDownField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 10
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 10
        return leftViewRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        //        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 40))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 40))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 10))
    }
    
    
    
}

extension UIView{
    func addGradientAlpha() {
        self.alpha = 0.6
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.9)
        let whiteColor = UIColor.white
        gradient.colors = [whiteColor.withAlphaComponent(1.0).cgColor, whiteColor.withAlphaComponent(0.0).cgColor]
        gradient.locations = [NSNumber(value: 0.0),NSNumber(value: 1.0)]
        
        gradient.frame = self.bounds
        self.layer.mask = gradient
        self.isHidden = false;
    }
    
}


class borderViews: UIView {
    
    let topLine: UIView = {
        let view = UIView()
        view.alpha = 1.0
        //        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.alpha = 1.0
        //        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 4.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.rgb(red: 210, green: 210, blue: 210).cgColor
        
        self.addSubview(topLine)
        topLine.topAnchor
    }
    
//    override func setNeedsLayout() {
//        <#code#>
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WebImageView: UIImageView {
    
    var imageUrlString: String?
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolderImage: UIImage?, asTemplate: Bool = false) {
        self.imageUrlString = URLString
        if let url = URL(string: URLString) {
            if imageUrlString == URLString {
                self.kf.indicatorType = .activity
                self.kf.setImage(with: url, placeholder: placeHolderImage, options: [.transition(.fade(0.2))])
                
//                self.kf.setImage(with: url, placeholder: placeHolderImage, options: [.transition(.fade(0.2))], progressBlock: asTemplate)
            }
        }
    }
}

class LineRegisterField: DropDownField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 10
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 10
        return leftViewRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        //        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    
}



class DateTextField: UITextField {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: "Cairo", size: 15.0)
        self.textColor = UIColor.darkGray
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 4.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.rgb(red: 210, green: 210, blue: 210).cgColor
        self.autocorrectionType = UITextAutocorrectionType.no
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.textAlignment = NSTextAlignment.center
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
//
//    override func selectionRects(for range: UITextRange) -> [Any] {
//        return []
//    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 10
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 10
        return leftViewRect
    }
    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 10, 0, 10))
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 10, 0, 10))
//    }
//    
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 10, 0, 10))
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class UrlImageView: UIImageView {
    var imageUrlString: String?
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolderImage: UIImage?) {
        self.imageUrlString = URLString
        if let url = URL(string: URLString) {
            if imageUrlString == URLString {
//                self.kf.indicatorType = .activity
                self.kf.setImage(with: url, placeholder: placeHolderImage, options: [.transition(.fade(0.2))])
                
                
            }
        }
    }
}

class PaddingLabel: UILabel {
    var topInset: CGFloat = 0.0
    var bottomInset: CGFloat = 0.0
    var leftInset: CGFloat = 0.0
    var rightInset: CGFloat = 10.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in:rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}




class KetoImageButton: KetoButton {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setImage(img:UIImage)  {
        self.setImage(img: img)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
           self.setImage(image.withRenderingMode(renderMode), for: .normal)
           self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: image.size.width / 2)
           self.contentHorizontalAlignment = .left
           self.imageView?.contentMode = .scaleAspectFit
       }

    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    

    
}


class KetoButton: UIButton {
    
    private var shadowLayer: CAShapeLayer!
    var cornerRadius: CGFloat = 8.0
    var shadowRadius: CGFloat = 6
    var fillColor: UIColor = UIColor.MyWall.appColor // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    var dashboardDict = [String : [DashboardDataStruct]]()
    var dashboardObj = DashboardDataStruct(MyWallcolorCode: .appColor, MyWallItemTitle: "")

     
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
          
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor

//            shadowLayer.shadowColor = UIColor.MyWall.appColor.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//            shadowLayer.shadowOpacity = 0.6
//            shadowLayer.shadowRadius = shadowRadius

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    func updateFillColor(){
        shadowLayer.fillColor = fillColor.cgColor
    }
    
    func updateShadowColor(color : UIColor ){
        shadowLayer.shadowColor = color.cgColor
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.clear
//        self.addSubview(btnShowHidePassword)
//        btnShowHidePassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
//        btnShowHidePassword.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        btnShowHidePassword.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        btnShowHidePassword.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
//        btnShowHidePassword.addTarget(self, action: #selector(showpassword), for: .touchDown)
//        btnShowHidePassword.addTarget(self, action: #selector(hidePasword), for: .touchCancel)
//

        }
    
    required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)
             
         }
       
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

class CornerShadowView: UIView {
    
    var shadowLayer: CAShapeLayer!
    var cornerRadius: CGFloat = 8.0
    var shadowRadius: CGFloat = 6
    var borderLayer : CAShapeLayer!

//    var displayShadow : Bool = true {
//        didSet{
//            shadowLayer = nil
//        }
//    }

    var fillColor: UIColor = UIColor.white // the color applied to the shadowLayer, rather than the view's backgroundColor
     
    override func layoutSubviews() {
        super.layoutSubviews()

//        if shadowLayer == nil {
            for item in self.layer.sublayers ?? [] where item.name == "myShadowLayer" {
                item.removeFromSuperlayer()
            }
            shadowLayer = CAShapeLayer()
          
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor

            shadowLayer.shadowColor = UIColor.MyWall.borderGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.6
            shadowLayer.shadowRadius = shadowRadius
            //if displayShadow == true
            //{
            shadowLayer.name = "myShadowLayer"
                layer.insertSublayer(shadowLayer, at: 0)

            //}
//        }
    }
    
    func updateFillColor(){
        if shadowLayer == nil {
            shadowLayer.fillColor = fillColor.cgColor
        }
    }
    
    func addBorder() {
        //setup Border for Mask
        //        if borderLayer == nil {
        if borderLayer != nil {
            borderLayer.removeFromSuperlayer()
        }
        borderLayer = CAShapeLayer()
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        borderLayer.lineWidth = 1
        borderLayer.strokeColor = UIColor.MyWall.Blue.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
        //        }
        
    }
    func removeBorder() {
        if borderLayer != nil{
            borderLayer.removeFromSuperlayer()

        }
    }
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.clear
//        self.addSubview(btnShowHidePassword)
//        btnShowHidePassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
//        btnShowHidePassword.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        btnShowHidePassword.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        btnShowHidePassword.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
//        btnShowHidePassword.addTarget(self, action: #selector(showpassword), for: .touchDown)
//        btnShowHidePassword.addTarget(self, action: #selector(hidePasword), for: .touchCancel)
//

        }
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
