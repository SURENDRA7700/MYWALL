//
//  GrievancDetailsCell.swift
//  My Wall
//
//  Created by surendra on 05/12/20.
//

import UIKit

class GrievancDetailsCell: UITableViewCell {

    @IBOutlet weak var gTtileLabel: UILabel!
    @IBOutlet weak var gtitleDescription: UILabel!
    @IBOutlet weak var descButton: DataButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class DataButton: UIButton {
    
    var menuObj :menuItem?
    var menuObjName :String?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


