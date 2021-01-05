//
//  AllNewsVC.swift
//  swifitsample
//
//  Created by surendra kumar k on 30/11/19.
//  Copyright © 2019 surendra kumar k. All rights reserved.
//

import UIKit

class EndorsementVC: VCTemplate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.titleLabel.text = "Endorsement"
        
        let itemLabel = UILabel()
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemLabel)
        itemLabel.textAlignment = .center
        itemLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        itemLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        itemLabel.text = "Coming Soon"


    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
