//
//  MeetingFooterViewWall.swift
//  My Wall
//
//  Created by surendra on 20/12/20.
//

import UIKit

class MeetingFooterViewWall: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var cancel: CustomButton!
    @IBOutlet weak var save: CustomButton!
    
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
    }
      
      private func loadViewFromNib() -> UIView {
          let bundle = Bundle(for: type(of: self))
          let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
          let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
          return nibView
      }
}
