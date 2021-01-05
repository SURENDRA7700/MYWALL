//
//  TestViewController.swift
//  ViewPager-Swift
//
//  Created by Nishan Niraula on 4/13/19.
//  Copyright © 2019 Nishan. All rights reserved.
//

import UIKit

class DashBoardViewController: VCTemplate {

    var tabs = [ViewPagerTab]()
    var options: ViewPagerOptions?
    var pager:ViewPager?
    var userDashModdel : DashboardModel?

    
    override func loadView() {
        
        let newView = UIView()
        newView.backgroundColor = UIColor.white
        view = newView
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "DashBoard"
        let tabs1 = [
            ViewPagerTab(title: "GRIEVANCES", image: UIImage(named: "Grievances"), tabType: 0),
            ViewPagerTab(title: "REIMBURSEMENT", image: UIImage(named: "Reimbursement"), tabType: 1),
            ViewPagerTab(title: "LOC", image: UIImage(named: "LOC"), tabType: 2),
            ViewPagerTab(title: "PESHI-FILES", image: UIImage(named: "Peshi Files"), tabType: 3),
            ViewPagerTab(title: "ENDORSEMENT", image: UIImage(named: "Endorsement"), tabType: 4),
            ViewPagerTab(title: "LETTERS", image: UIImage(named: "Letters"), tabType: 5),
        ]
        
        
        let optionstest = ViewPagerOptions()
        if UIDevice.current.userInterfaceIdiom == .pad {
            optionstest.distribution = .equal
        }else{
            optionstest.distribution = .normal
        }
        optionstest.tabType = .basic
        optionstest.tabViewBackgroundDefaultColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        optionstest.tabViewBackgroundHighlightColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        optionstest.tabIndicatorViewBackgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1960784314, blue: 0.2196078431, alpha: 1)
        optionstest.tabViewTextDefaultColor = #colorLiteral(red: 0.1529411765, green: 0.1960784314, blue: 0.2196078431, alpha: 1)
        optionstest.tabViewTextHighlightColor = #colorLiteral(red: 0.1529411765, green: 0.1960784314, blue: 0.2196078431, alpha: 1)
        self.options = optionstest
        self.tabs = tabs1
        
        
        UserManager.isUserLoggedin()
        UserManager.getLoggedUserInfo()
        self.checkRoleForUserDashboardData()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    
    func checkRoleForUserDashboardData()
    {
        
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }

        let activityView = MyActivityView()
        activityView.displayLoader()

        
        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(myHelper.dashboardData, parameters) { (urlData) in
            
            activityView.dismissLoader()
            do {
                let rootDic = try JSONDecoder().decode(DashboardModel.self, from: urlData)
                DispatchQueue.main.async {
                    self.userDashModdel = rootDic
                    guard let options = self.options else { return }
                    self.pager = ViewPager(viewController: self)
                    self.pager?.setOptions(options: options)
                    self.pager?.setDataSource(dataSource: self)
                    self.pager?.setDelegate(delegate: self)
                    self.pager?.build()
                }

            } catch (let error) {
                activityView.dismissLoader()
                do {
                    let errorModel = try JSONDecoder().decode(ErrorModel.self, from: urlData)
                    ErrorManager.showErrorAlert(mainTitle: errorModel.error, subTitle: errorModel.errorDescription)
                }
                catch {
                    ErrorManager.showErrorAlert(mainTitle: "", subTitle: error.localizedDescription)
                }
            }
            
        }
        
        failure: { (errorString) in
            activityView.dismissLoader()
         //   ErrorManager.showErrorAlert(mainTitle: "", subTitle: errorString)

        }
        
        
    }
    

    
    deinit {
        print("Memory Deallocation")
    }
}

extension DashBoardViewController: ViewPagerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        
        let vc = ItemViewController()
        vc.itemText = "\(tabs[position].title)"
        vc.itemTabType = tabs[position]
        vc.userDashModdel = self.userDashModdel
        return vc
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension DashBoardViewController: ViewPagerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
    }
}
