//
//  TextViewTableViewCell.swift
//  My Wall
//
//  Created by surendra on 05/12/20.
//

import UIKit

class TextViewTableViewCell: UITableViewCell, UITextViewDelegate {

    
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
        textView.textColor = UIColor.lightGray
        textView.isEditable = false
        
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
