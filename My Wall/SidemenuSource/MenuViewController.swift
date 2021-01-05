//
//  MenuViewController.swift
//  swifitsample
//
//  Created by surendra kumar k on 30/11/19.
//  Copyright © 2019 surendra kumar k. All rights reserved.
//

import UIKit
import SideMenuSwift

class MenuViewController: UIViewController {

    public static let sideMenuGap: CGFloat = 60.0

    var onCompletion: ((_ success: Bool) -> ())?
    
    let  presetDistance = sideMenuGap / 2

        let scrollView: UIScrollView = {
            let v = UIScrollView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        /**** To let ScrollView to scroll properly, its working fine for me ***/
        let scrollPositionLabl: UILabel = {
            let label = UILabel()
            label.text = ""
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        let fieldsContainer: UIView = {
            let view = UIView()
            view.alpha = 1.0
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    let fieldsContainerMain: UIView = {
        let view = UIView()
        view.alpha = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
        var logoImage: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.image = #imageLiteral(resourceName: "twitterIcon")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
    let userName: UILabel  = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.MyWall.appColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Sri K.T.Rama Rao"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let userDesignation: UILabel  = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.MyWall.appColor
        label.numberOfLines = 0
        label.textAlignment = .left
        let font = UIFont(name: "HelveticaNeue", size: 13)!
        label.font = font
        label.text = "Hon'ble Minister for MA & UD, Industries & Commerce, Information Technology, Electronics & Communications Government of Telangana"
        return label
    }()

    
        var sideMenuImg: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = #imageLiteral(resourceName: "sideMenu")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        struct menuItem: Codable {
            let thumb : String
            let Name : String
            let rightArrow : String
        }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 1.0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: -10)
        //        layout.item
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        //        cv.backgroundColor = .red
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        //        cv.alwaysBounceHorizontal = false
        cv.alwaysBounceVertical = true
        
        cv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10)
        return cv
    }()

        
    var MenuItems : [menuItem]!
    let Home = menuItem.init(thumb: "dashboardIcon", Name: "Dashboard", rightArrow: "RightArrow")
    let About = menuItem.init(thumb: "meetings", Name: "Meetings", rightArrow: "RightArrow")
    let News = menuItem.init(thumb: "endorsemwnt", Name: "Endorsement", rightArrow: "RightArrow")
    let Gallery = menuItem.init(thumb: "shareicon", Name: "Share Location", rightArrow: "RightArrow")
    let cellId = "cellId"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        sideMenuController?.cache(viewController: DashBoardViewController(), with: Home.Name)
        sideMenuController?.cache(viewController: MeetingsViewViewController(), with: About.Name)
        sideMenuController?.cache(viewController: EndorsementVC(), with: News.Name)
        sideMenuController?.cache(viewController: ShareLocationVC(), with: Gallery.Name)
//        MenuItems = [Home,About,News,Gallery]
        MenuItems = [Home,About]

        
        view.addSubview(scrollView)
        scrollView.keyboardDismissMode = .interactive
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.backgroundColor = .white
        
        
        scrollView.addSubview(fieldsContainerMain)
        fieldsContainerMain.translatesAutoresizingMaskIntoConstraints = false
        fieldsContainerMain.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        fieldsContainerMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:presetDistance).isActive = true
        fieldsContainerMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:0).isActive = true

        
        fieldsContainerMain.addSubview(fieldsContainer)
        fieldsContainer.backgroundColor = UIColor.MyWall.appColor
        fieldsContainer.translatesAutoresizingMaskIntoConstraints = false
        fieldsContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        fieldsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:presetDistance).isActive = true
        fieldsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:0).isActive = true
        fieldsContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true

        
        fieldsContainerMain.addSubview(logoImage)
//        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: presetDistance).isActive = true
        logoImage.topAnchor.constraint(equalTo: fieldsContainer.topAnchor, constant: 0).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 50).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoImage.layer.cornerRadius = 50
        logoImage.clipsToBounds = true
        
        fieldsContainerMain.addSubview(userName)
        userName.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 10).isActive = true
        userName.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 40).isActive = true
        userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        userName.textColor = .white
        
        fieldsContainerMain.addSubview(userDesignation)
        userDesignation.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 2).isActive = true
        userDesignation.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 40).isActive = true
        userDesignation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        userDesignation.textColor = .white
        userDesignation.adjustsFontSizeToFitWidth = true
//        userDesignation.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        fieldsContainerMain.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: fieldsContainer.bottomAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 580).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: presetDistance).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        self.collectionView.register(UINib(nibName: "MenuCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView.isScrollEnabled = false
    }


   
    
    override func viewDidLayoutSubviews() {
        fieldsContainerMain.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant:100).isActive = true
    }


}


extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCollectionCell
        let theMenuItem = MenuItems[indexPath.item]
        cell.ImgThumb.image = UIImage(imageLiteralResourceName: theMenuItem.thumb).withRenderingMode(.alwaysTemplate)
        cell.LblTitle.text = theMenuItem.Name
        cell.ImgTitle.image = UIImage(imageLiteralResourceName: theMenuItem.rightArrow).withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wid = collectionView.bounds.width - 20
        return CGSize(width: wid, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UserManager.sharedInstance.isfirstTime = true
        onCompletion!(true)
        let mItem = MenuItems[indexPath.item]
        sideMenuController?.setContentViewController(with: mItem.Name)
        sideMenuController?.hideMenu()
    }
}

