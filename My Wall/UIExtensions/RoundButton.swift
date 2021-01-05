//
//  RoundButton.swift
//  RoundButtonsTutorial
//
//  Created by Luke Lapresi on 10/2/17.
//  Copyright © 2017 Luke Lapresi. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCR(_value: cornerRadius)
        }
    }
    
    func refreshCR(_value: CGFloat) {
        layer.cornerRadius = _value
    }
    
    @IBInspectable var customBGColor: UIColor = UIColor.init(red: 0, green: 122/255, blue: 255/255, alpha: 1) {
        didSet {
            refreshColor(_color: customBGColor)
        }
    }
    
    func refreshColor(_color: UIColor) {
        let size: CGSize = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        _color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let bgImage: UIImage = (UIGraphicsGetImageFromCurrentImageContext() as UIImage?)!
        UIGraphicsEndImageContext()
        setBackgroundImage(bgImage, for: UIControl.State.normal)
        clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        print("init(frame:)")
        super.init(frame: frame);
        
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("init?(coder:)")
        super.init(coder: aDecoder)
        
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        print("prepareForInterfaceBuilder()")
        sharedInit()
    }
    
    func sharedInit() {
        refreshCR(_value: cornerRadius)
        refreshColor(_color: customBGColor)
        self.tintColor = UIColor.white
    }
}


@IBDesignable
class BoxView: UIView {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            setNeedsLayout()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            setNeedsLayout()
        }
    }
}


class ReasonFieldDropDown : RegisterField {
    let dropDown = DropDown()

    let dropDownButton: UIButton  = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let triggerbutton: UIButton  = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        self.configureXib()
    }
    
    func configureXib()
    {
        dropDownButton.setBackgroundImage(#imageLiteral(resourceName: "Arrow down-icon"), for: .normal) //down arrow
        dropDownButton.frame = CGRect(x: self.frame.size.width - 40 , y: 2, width: 30, height: 30)
        self.rightView = dropDownButton
        self.rightViewMode = .always

    }
    
    func configureDropDown() {
        dropDown.anchorView = self;
        dropDown.bottomOffset = CGPoint(x: 0, y: self.bounds.height + 52)

        self.addSubview(triggerbutton)
        triggerbutton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        triggerbutton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        triggerbutton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        triggerbutton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        triggerbutton.addTarget(self, action: #selector(showdropDown), for: .touchUpInside)
        
        
        let appearance = DropDown.appearance()
        appearance.cellHeight = 60
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor.MyWall.LightBlue
        appearance.cornerRadius = 10
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.6
        appearance.shadowRadius = 8
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
        if #available(iOS 11.0, *) {
            appearance.setupMaskedCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        }
    }
    
    @objc func showdropDown(){
        UIView.animate(withDuration: 0.2) {[weak self] in
            self?.dropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        }
        dropDown.show()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureXib()
    }

}



class chatField : RegisterField {
    
    let button: UIButton  = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.contentMode = .scaleAspectFit
        btn.setBackgroundImage(#imageLiteral(resourceName: "hidepassword"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        button.setBackgroundImage(#imageLiteral(resourceName: "endorsemwnt"), for: .normal) //down arrow
        button.frame = CGRect(x: self.frame.size.width - 40 , y: 5, width: 22, height: 22)
        button.addTarget(self, action: #selector(showpassword), for: .touchDown)
        button.addTarget(self, action: #selector(hidePasword), for: .touchUpInside)
        if(LangUtils.isLangArabic())
        {
            self.leftView = button
            self.leftViewMode = .always
        }else{
            self.rightView = button
            self.rightViewMode = .always
        }
    }
    @objc func showpassword(){
    }
    
    @objc func hidePasword(){
    }
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}


@IBDesignable
class CustomTextField: UITextField {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.primaryArabic(size: 15)
        self.textColor = UIColor.darkGray
        self.borderStyle = UITextField.BorderStyle.none
//        self.backgroundColor = UIColor.Areeb.darkColor
        self.autocorrectionType = UITextAutocorrectionType.no
        self.autocapitalizationType = .none
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.textAlignment = .right
        self.textColor = UIColor.MyWall.Black
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.MyWall.borderGray.cgColor
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
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

    
    func setFieldImageIconRight(imageName: String?) {
         guard let imageIcon = imageName else {
             return
         }
         let img = UIImage(named: imageIcon)?.withRenderingMode(.alwaysTemplate)
         let imageView = UIImageView(image: img)
         imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
         imageView.contentMode = .scaleAspectFit
         imageView.tintColor = UIColor.rgb(red: 160, green: 160, blue: 160)
         self.rightView = imageView
         self.rightViewMode = UITextField.ViewMode.always
         self.rightView?.clipsToBounds = true
     }
    
    

  @IBInspectable var cornerRadius: CGFloat = 0.0 {
      didSet {
          layer.cornerRadius = cornerRadius
          setNeedsLayout()
      }
  }

}


@IBDesignable class CustomButton: UIButton {
    
     var shadowLayer: CAShapeLayer!
     var fillColor: UIColor = UIColor.white // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            shadowLayer.shadowColor = UIColor.MyWall.Blue.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.6
            shadowLayer.shadowRadius = 3
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    func updateBGColor(){
        refreshColor(_color: customBGColor)
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            refreshCR(_value: cornerRadius)
        }
    }
    
    func refreshCR(_value: CGFloat) {
        layer.cornerRadius = _value
    }
    
    @IBInspectable var customBGColor: UIColor = UIColor.init(red: 0, green: 122/255, blue: 255/255, alpha: 1) {
        didSet {
            refreshColor(_color: customBGColor)
        }
    }
    
    func refreshColor(_color: UIColor) {
        let size: CGSize = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        _color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let bgImage: UIImage = (UIGraphicsGetImageFromCurrentImageContext() as UIImage?)!
        UIGraphicsEndImageContext()
        setBackgroundImage(bgImage, for: UIControl.State.normal)
        clipsToBounds = true
    }
    
    
    override init(frame: CGRect) {
           super.init(frame: frame);
           
           sharedInit()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           
           sharedInit()
       }
       
       
       func sharedInit() {
           refreshCR(_value: cornerRadius)
           refreshColor(_color: customBGColor)
           self.tintColor = UIColor.white
       }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            setNeedsLayout()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }

}


@IBDesignable class ShadowCustomView : UIView {
    
     var shadowLayer: CAShapeLayer!
       var shadowRadius: CGFloat = 4
       var displayShadow : Bool = true {
           didSet{
               shadowLayer = nil
           }
       }

       private var fillColor: UIColor = UIColor.white // the color applied to the shadowLayer, rather than the view's backgroundColor
       override func layoutSubviews() {
           super.layoutSubviews()

           if shadowLayer == nil {
               shadowLayer = CAShapeLayer()
             
               shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
               shadowLayer.fillColor = fillColor.cgColor

               shadowLayer.shadowColor = UIColor.MyWall.lightBlack.cgColor
               shadowLayer.shadowPath = shadowLayer.path
               shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
               shadowLayer.shadowOpacity = 0.6
               shadowLayer.shadowRadius = shadowRadius
               if displayShadow == true
               {
                   layer.insertSublayer(shadowLayer, at: 0)

               }
           }
       }
    
    
    func updateFillColor() {
        shadowLayer.fillColor = (self.fillColor as! CGColor)
       }
       
       func updateShadowColor(color : UIColor ){
           shadowLayer.shadowColor = color.cgColor
       }
        
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            setNeedsLayout()
        }
    }

    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            setNeedsLayout()
        }
    }
}


class HealthButton: UIButton {
    
    private var shadowLayer: CAShapeLayer!
    var cornerRadius: CGFloat = 8.0
    var shadowRadius: CGFloat = 6
    var fillColor: UIColor = UIColor.MyWall.borderGray
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.MyWall.borderGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.6
            shadowLayer.shadowRadius = shadowRadius
            
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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}



 


class CustomAlertView: UIView {
    
    let bgView: UIView = {
        let view = UIView()
        view.alpha = 1.0
        view.backgroundColor = UIColor.MyWall.AlertBgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    
    let iconView: UIImageView  = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "caution")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let warningLabel : UILabel  = {
        let label = UILabel()
        label.text = LangUtils.localizedOf("لقد نفذ رصيد الاستشارات الخاص بك")
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.primaryArabicBold(size: 12)
        label.textColor = UIColor.MyWall.Black
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        
    }
    
    func setupView(){
        self.backgroundColor = .white
        addSubview(bgView)
        if LangUtils.isLangArabic() {
            NSLayoutConstraint.activate([
                bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
                bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                bgView.topAnchor.constraint(equalTo: topAnchor),
                bgView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }else{
            NSLayoutConstraint.activate([
                bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                bgView.topAnchor.constraint(equalTo: topAnchor),
                bgView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        
        addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor,constant: 7),
            iconView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 30),
            iconView.heightAnchor.constraint(equalToConstant: 21),
            iconView.widthAnchor.constraint(equalToConstant: 25),
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        ])
        
        addSubview(warningLabel)
        NSLayoutConstraint.activate([
            warningLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            warningLabel.leadingAnchor.constraint(equalTo: iconView.leadingAnchor, constant: 40),
            warningLabel.heightAnchor.constraint(equalToConstant: 21),
            warningLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
        ])
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    
}


