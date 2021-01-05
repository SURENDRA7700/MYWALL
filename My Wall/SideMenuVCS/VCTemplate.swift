//
//  VCTemplate.swift
//  SSCA APP
//
//  Created by Mahroof on 17/03/2019.
//  Copyright © 2019 Dnet. All rights reserved.
//

import UIKit
import Toast_Swift
import HSPopupMenu

class VCTemplate: UIViewController {
    var menuArray: [HSMenu] = []

    
    @objc let sideMenuButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .clear
        btn.setImage(#imageLiteral(resourceName: "burger"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.clipsToBounds = true
        return btn
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.primaryEnglishBold(size: 18)
        return lbl
    }()
    
    let shareButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.clipsToBounds = true
        return btn
    }()
    
    let ktrButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.clipsToBounds = true
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.MyWall.appColor
        
        let menu1 = HSMenu(icon: nil, title: "Exit")
        let menu2 = HSMenu(icon: nil, title: "logout")
        menuArray = [menu1, menu2]

        
        view.addSubview(sideMenuButton)
        sideMenuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        sideMenuButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        sideMenuButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sideMenuButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sideMenuButton.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
        sideMenuButton.setImage(#imageLiteral(resourceName: "burger").withRenderingMode(.alwaysTemplate), for: .normal)
        sideMenuButton.imageView?.tintColor = UIColor.white

        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        view.addSubview(shareButton)
        shareButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        shareButton.addTarget(self, action: #selector(showshare(_:forEvent:)), for: .touchUpInside)
        shareButton.setImage(#imageLiteral(resourceName: "More-options").withRenderingMode(.alwaysTemplate), for: .normal)
        shareButton.imageView?.tintColor = UIColor.white
        shareButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 30).isActive = true


        view.addSubview(ktrButton)
        ktrButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        ktrButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        ktrButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ktrButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -20).isActive = true
        ktrButton.setImage(#imageLiteral(resourceName: "ktr-png-5"), for: .normal)
        ktrButton.layer.cornerRadius = 15
        ktrButton.clipsToBounds = true
        

        
        // Do any additional setup after loading the view.
    }
    
    @objc func showshare(_ sender: UIButton, forEvent event: UIEvent){
        
        let popupMenu = HSPopupMenu(menuArray: menuArray, arrowPoint: sender.center)
        popupMenu.popUp()
        popupMenu.delegate = self

        
    }

        
    @objc func showshareTemp(){
        // text to share
        let text = "https://scca19.sadr.org"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
//        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func showSideMenu(){
        self.sideMenuController?.revealMenu()
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


extension VCTemplate: HSPopupMenuDelegate {
    func popupMenu(_ popupMenu: HSPopupMenu, didSelectAt index: Int) {
        
        if index == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  exit(0)
                 }
            }
        }
        if index == 1 {
            UserManager.setuserLogout()
        }
        print("selected index is: " + "\(index)")
    }
}
