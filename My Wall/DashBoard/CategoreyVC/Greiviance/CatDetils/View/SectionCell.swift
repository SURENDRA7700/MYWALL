//
//  SectionCell.swift
//  My Wall
//
//  Created by surendra on 08/12/20.
//

import UIKit

class SectionCell: UITableViewCell {

    
    @IBOutlet weak var wallNumberLabel: UILabel!
    @IBOutlet weak var wallNumberDesc: UILabel!
    @IBOutlet weak var wallChequelabel: UILabel!
    @IBOutlet weak var wallCheckLabelDesc: UILabel!
    @IBOutlet weak var wallAmontLabe1: UILabel!
    @IBOutlet weak var wallAmountLabelDesc: UILabel!
    
    
    @IBOutlet weak var wallTypeLabel: UILabel!
    @IBOutlet weak var wallTypeLabelDesc: UILabel!
    @IBOutlet weak var wallDateLabel: UILabel!
    @IBOutlet weak var wallDateLabelDesc: UILabel!
    
    @IBOutlet weak var wallRemarksLbel: UILabel!
    @IBOutlet weak var wallRemarksDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
