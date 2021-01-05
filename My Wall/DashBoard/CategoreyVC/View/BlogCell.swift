//
//  BlogCell.swift
//  ketoGinik
//
//  Created by surendra kumar k on 12/06/20.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

class BlogCell: UITableViewCell {

    
    @IBOutlet weak var firstLabelTitle: UILabel!
    @IBOutlet weak var secLabelTitle: UILabel!
    @IBOutlet weak var thirdLabelTtle: UILabel!
    @IBOutlet weak var fourthLabelTitle: UILabel!
    @IBOutlet weak var ficeLabelTitle: UILabel!

    
    @IBOutlet weak var firstLabelTitleDesc: UILabel!
    @IBOutlet weak var secLabelTitleDesc: UILabel!
    @IBOutlet weak var thirdLabelTtleDesc: UILabel!
    @IBOutlet weak var fourthLabelTitleDesc: UILabel!
    @IBOutlet weak var ficeLabelTitleDesc: UILabel!

    @IBOutlet weak var shadowView: ShadowCustomView!

    
    
    var blogBtn: BlogBuuton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func UpdateLayoutShadow()
    {
        if self.shadowView.shadowLayer != nil {
            self.shadowView.shadowLayer.removeFromSuperlayer()
        }
        self.shadowView.shadowLayer = nil
        self.shadowView.setNeedsLayout()
    }
    
}


class BlogBuuton: UIButton {
    var eachItem: Any?
}
