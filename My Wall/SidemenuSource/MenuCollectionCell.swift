//
//  MenuCollectionCell.swift
//  SSCA APP
//
//  Created by Mahroof on 27/03/2019.
//  Copyright © 2019 Dnet. All rights reserved.
//

import UIKit

class MenuCollectionCell: UICollectionViewCell {

    @IBOutlet weak var ImgThumb: UIImageView!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var ImgTitle: UIImageView!
    
    override func awakeFromNib() {
//        ImgThumb.image?.renderingMode = UIImage.RenderingMode.alwaysTemplate
        
        LblTitle.textColor = self.isSelected  ? UIColor.appColor : UIColor.menuTextColor
        ImgThumb.tintColor = self.isSelected  ? UIColor.appColor : UIColor.menuTextColor
        ImgTitle.tintColor = self.isSelected  ? UIColor.appColor : UIColor.menuTextColor
//        ImgThumb.backgroundColor = .white
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            // set color according to state
//            self.backgroundColor = self.isSelected ? .blue : .clear
            LblTitle.textColor = self.isSelected  ? UIColor.appColor : UIColor.menuTextColor
            ImgThumb.tintColor = self.isSelected  ? UIColor.appColor : UIColor.menuTextColor
            ImgTitle.tintColor = self.isSelected  ? UIColor.appColor : UIColor.menuTextColor

        }
    }

}
