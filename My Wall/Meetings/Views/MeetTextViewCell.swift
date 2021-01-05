//
//  MeetTextViewCell.swift
//  My Wall
//
//  Created by surendra on 20/12/20.
//

import UIKit

class MeetTextViewCell: UITableViewCell,UITextViewDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textView.delegate = self
        textView.textColor = UIColor.lightGray

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
