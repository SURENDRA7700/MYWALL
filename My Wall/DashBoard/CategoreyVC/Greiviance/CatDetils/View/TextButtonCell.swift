//
//  TextButtonCell.swift
//  My Wall
//
//  Created by surendra on 05/12/20.
//

import UIKit

class TextButtonCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var shadowButton: DataButton!
    
    @IBOutlet weak var shadowView: ShadowCustomView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
        textView.textColor = UIColor.lightGray
        textView.isEditable = false
        
        let attributedString = NSAttributedString(string: shadowButton.titleLabel?.text ?? "", attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
            NSAttributedString.Key.foregroundColor : UIColor.blue,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        shadowButton.setAttributedTitle(attributedString, for: .normal)

        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }

    
}
