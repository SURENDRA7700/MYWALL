//
//  AbouViewViewController.swift
//  swifitsample
//
//  Created by surendra kumar k on 30/11/19.
//  Copyright © 2019 surendra kumar k. All rights reserved.
//

import UIKit

class MeetingsViewViewController: VCTemplate {

    let calendar = SwiftDemoViewController()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = "Meetings"
    }

    func showDummy(){
        let itemLabel = UILabel()
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemLabel)
        itemLabel.textAlignment = .center
        itemLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        itemLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        itemLabel.text = "Coming Soon"
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendar.parentVC = self
        let yframe = self.shareButton.frame.maxY + self.shareButton.frame.size.height/3
        calendar.view.frame=CGRect(x: 0, y: yframe, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        if UserManager.sharedInstance.isfirstTime {
            add(calendar)
        }
    }

    

}



public extension UIViewController {

    /// Adds child view controller to the parent.
    ///
    /// - Parameter child: Child view controller.
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    /// It removes the child view controller from the parent.
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
