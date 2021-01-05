//
//  MeetDropDownCell.swift
//  My Wall
//
//  Created by surendra on 20/12/20.
//

import UIKit

class MeetDropDownCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var meetTextField: ReasonFieldDropDown!
    @IBOutlet weak var meetDropDownAction: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
