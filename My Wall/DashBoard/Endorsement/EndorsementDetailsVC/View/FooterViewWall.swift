//
//  FooterViewWall.swift
//  My Wall
//
//  Created by surendra on 06/12/20.
//

import UIKit

class FooterViewWall: UIView, UITextViewDelegate {

    @IBOutlet var view: UIView!
     @IBOutlet weak var cancel: CustomButton!
     @IBOutlet weak var submit: CustomButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var shadowButton: DataButton!
    @IBOutlet weak var shadowView: ShadowCustomView!
    
    @IBOutlet weak var buttonHeightConst: NSLayoutConstraint!
    
     
     override init(frame: CGRect) {
           super.init(frame: frame)
           nibSetup()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           nibSetup()
       }
       
     private func nibSetup() {
         view = loadViewFromNib()
         view.frame = bounds
         view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         view.translatesAutoresizingMaskIntoConstraints = true
         addSubview(view)
        
        textView.delegate = self
        textView.textColor = UIColor.lightGray
        let attributedString = NSAttributedString(string: shadowButton.titleLabel?.text ?? "", attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
            NSAttributedString.Key.foregroundColor : UIColor.blue,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        shadowButton.setAttributedTitle(attributedString, for: .normal)

     }
       
       private func loadViewFromNib() -> UIView {
           let bundle = Bundle(for: type(of: self))
           let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
           let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
           return nibView
       }

    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }

    

}
