//
//  ItemViewController.swift
//  ViewPager-Swift
//
//  Created by Nishan on 2/9/16.
//  Copyright © 2016 Nishan. All rights reserved.
//

import UIKit
import Charts



enum DashBoardType : Int {
    case Grievances
    case Reimbursement
    case LOC
    case PeshiFiles
    case Endorsement
    case Letters
}

struct DashboardDataStruct {
    let MyWallcolorCode : UIColor
    let MyWallItemTitle : String
}

class ItemViewController: UIViewController,ChartViewDelegate {
    
    var itemTabType : ViewPagerTab!
    var dashBoardType : DashBoardType = .Grievances
    let ItemsArray : [NSString] = []
    var dashboardDict = [String : [DashboardDataStruct]]()
    var barChart: BarChartView!
    var elements: [String]!

    var userDashModdel : DashboardModel?

    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alwaysBounceVertical = false
        return v
    }()
    
    let fieldsContainer: UIView = {
        let view = UIView()
        //        view.alpha = 0.0
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution  = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    
    lazy var MyWallMidSecondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution  = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var MyWallBottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution  = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    let statusButton: KetoButton = {
        let button = KetoButton(type: .custom)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 14)
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 0
        button.fillColor = UIColor.MyWall.appColor
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
        return button
    }()
    
    
    let topFirstButton: KetoButton = {
        let button = KetoButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 14)
        button.titleLabel?.textAlignment = .center
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 8
        button.fillColor = UIColor.MyWall.successGreen
        return button
    }()
    
    
    

    let topSecondButton: KetoButton = {
        let button = KetoButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 14)
        button.titleLabel?.textAlignment = .center
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 8
        button.fillColor = UIColor.MyWall.errorColor
        return button
    }()
    
    
    let midFirstButton: KetoButton = {
        let button = KetoButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 14)
        button.titleLabel?.textAlignment = .center
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 8
        button.fillColor = #colorLiteral(red: 0.1254901961, green: 0.2745098039, blue: 0.9607843137, alpha: 1)
        return button
    }()
    
    

    let midSecondButton: KetoButton = {
        let button = KetoButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 14)
        button.titleLabel?.textAlignment = .center
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 8
        button.fillColor = #colorLiteral(red: 0.5058823529, green: 0.168627451, blue: 0.5019607843, alpha: 1)
        return button
    }()
    
    
    let myWallBottomFirstButton: KetoButton = {
        let button = KetoButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 14)
        button.titleLabel?.textAlignment = .center
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 8
        button.fillColor = #colorLiteral(red: 0.9921568627, green: 0.9725490196, blue: 0.3176470588, alpha: 1)
        return button
    }()
    
    

    let myWallBottomSecondButton: KetoButton = {
        let button = KetoButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.MyWall.White, for: .normal)
        button.titleLabel!.font =  UIFont.primaryEnglishBold(size: 14)
        button.titleLabel?.textAlignment = .center
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 8
        button.fillColor = #colorLiteral(red: 0.1568627451, green: 0.3764705882, blue: 0.5647058824, alpha: 1)
        return button
    }()
    
    let chartView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        
        let newView = UIView()
        newView.backgroundColor = UIColor.white
        view = newView
    }

    var itemText: String!
    
    
    var myWallTopViewHeightConstraint : NSLayoutConstraint?
    var myWallMidViewHeightConstraint : NSLayoutConstraint?
    var myWallBottomViewHeightConstraint : NSLayoutConstraint?

    var myWallTopViewTopConstraint : NSLayoutConstraint?
    var myWallMidViewTopConstraint : NSLayoutConstraint?
    var myWallBottomViewTopConstraint : NSLayoutConstraint?

     
    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.isUserLoggedin()
        UserManager.getLoggedUserInfo()
        self.checkRoleForUserDashboardData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    func checkRoleForUserDashboardData()
    {
        self.configureView()
        self.prepareModel()
        self.hdndleUserInterface()
        return
        
        let activityView = MyActivityView()
        activityView.displayLoader()
        
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }

        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(myHelper.dashboardData, parameters) { (urlData) in
            
            activityView.dismissLoader()
            do {
                let rootDic = try JSONDecoder().decode(DashboardModel.self, from: urlData)
                DispatchQueue.main.async {
                    self.userDashModdel = rootDic
                    self.configureView()
                    self.prepareModel()
                    self.hdndleUserInterface()
                }

            } catch (let error) {
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
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    func prepareModel()
    {
        let grievanceArray = [
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1), MyWallItemTitle: "Total"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0.4666666667, green: 0.01176470588, blue: 0.4666666667, alpha: 1), MyWallItemTitle: "Under Process"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1), MyWallItemTitle: "Solved"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), MyWallItemTitle: "Closed")
        ]
        dashboardDict["0"] = grievanceArray
        
        
        let reimbursementArray = [
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1), MyWallItemTitle: "Total"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0.4666666667, green: 0.01176470588, blue: 0.4666666667, alpha: 1), MyWallItemTitle: "Pending"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1), MyWallItemTitle: "Sanctioned"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), MyWallItemTitle: "Rejected")
        ]
        dashboardDict["1"] = reimbursementArray
        

        let locArray = [
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1), MyWallItemTitle: "Total"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0.4666666667, green: 0.01176470588, blue: 0.4666666667, alpha: 1), MyWallItemTitle: "Pending"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1), MyWallItemTitle: "Sanctioned"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), MyWallItemTitle: "Rejected")
        ]
        dashboardDict["2"] = locArray
        

        let peshiFilesArray = [
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1), MyWallItemTitle: "Total"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0.4666666667, green: 0.01176470588, blue: 0.4666666667, alpha: 1), MyWallItemTitle: "Under Process"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1), MyWallItemTitle: "Approved"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.05490196078, alpha: 1), MyWallItemTitle: "Lie Over"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), MyWallItemTitle: "Returned")
        ]
        dashboardDict["3"] = peshiFilesArray
        
        let endorsementArray = [
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1), MyWallItemTitle: "Total"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0.5294117647, green: 0.8078431373, blue: 0.9215686275, alpha: 1), MyWallItemTitle: "New"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0.4666666667, green: 0.01176470588, blue: 0.4666666667, alpha: 1), MyWallItemTitle: "Pending"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1), MyWallItemTitle: "Dispatched"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 1, green: 0.6470588235, blue: 0, alpha: 1), MyWallItemTitle: "Hold"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), MyWallItemTitle: "Lie Over")
        ]
        dashboardDict["4"] = endorsementArray
        
        let lettersArray = [
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1), MyWallItemTitle: "Total"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0.5294117647, green: 0.8078431373, blue: 0.9215686275, alpha: 1), MyWallItemTitle: "New"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0.4666666667, green: 0.01176470588, blue: 0.4666666667, alpha: 1), MyWallItemTitle: "Pending"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1), MyWallItemTitle: "Dispatched"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 1, green: 0.6470588235, blue: 0, alpha: 1), MyWallItemTitle: "Hold"),
            DashboardDataStruct(MyWallcolorCode: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), MyWallItemTitle: "Lie Over")
        ]
        dashboardDict["5"] = lettersArray
        
        
    }
    
    
    func configureView()
    {
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        scrollView.addSubview(fieldsContainer)
        fieldsContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:0).isActive = true
        fieldsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        fieldsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        fieldsContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        
        
        fieldsContainer.addSubview(statusButton)
        statusButton.topAnchor.constraint(equalTo: fieldsContainer.topAnchor, constant:10).isActive = true
        statusButton.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 0).isActive = true
        statusButton.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: 0).isActive = true
        statusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let StatusString = "\(itemText ?? "") - Status"
        statusButton.setTitle(StatusString, for: .normal)
        
        
        fieldsContainer.addSubview(topStackView)
        topStackView.addArrangedSubview(topFirstButton)
        topStackView.addArrangedSubview(topSecondButton)
        topStackView.semanticContentAttribute  = .forceLeftToRight
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 0),
            topStackView.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: 0),
            topStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        topFirstButton.addTarget(self, action: #selector(gotoDashBoardInfo(sender:)),for: .touchUpInside)
        topSecondButton.addTarget(self, action: #selector(gotoDashBoardInfo(sender:)),for: .touchUpInside)

        
        myWallTopViewHeightConstraint = topStackView.heightAnchor.constraint(equalToConstant: 50)
        myWallTopViewHeightConstraint?.isActive = true
        myWallTopViewTopConstraint = topStackView.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: 10)
        myWallTopViewTopConstraint?.isActive = true
        
        
        
        
        fieldsContainer.addSubview(MyWallMidSecondStackView)
        MyWallMidSecondStackView.addArrangedSubview(midFirstButton)
        MyWallMidSecondStackView.addArrangedSubview(midSecondButton)
        MyWallMidSecondStackView.semanticContentAttribute  = .forceLeftToRight
        NSLayoutConstraint.activate([
            MyWallMidSecondStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            MyWallMidSecondStackView.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 0),
            MyWallMidSecondStackView.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: 0),
            MyWallMidSecondStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        myWallMidViewHeightConstraint = MyWallMidSecondStackView.heightAnchor.constraint(equalToConstant: 50)
        myWallMidViewHeightConstraint?.isActive = true
        myWallMidViewTopConstraint = MyWallMidSecondStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10)
        myWallMidViewTopConstraint?.isActive = true
        
        
        midFirstButton.addTarget(self, action: #selector(gotoDashBoardInfo(sender:)),for: .touchUpInside)
        midSecondButton.addTarget(self, action: #selector(gotoDashBoardInfo(sender:)),for: .touchUpInside)


        
        fieldsContainer.addSubview(MyWallBottomStackView)
        MyWallBottomStackView.addArrangedSubview(myWallBottomFirstButton)
        MyWallBottomStackView.addArrangedSubview(myWallBottomSecondButton)
        MyWallBottomStackView.semanticContentAttribute  = .forceLeftToRight
        NSLayoutConstraint.activate([
            MyWallBottomStackView.topAnchor.constraint(equalTo: MyWallMidSecondStackView.bottomAnchor, constant: 10),
            MyWallBottomStackView.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 0),
            MyWallBottomStackView.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: 0),
            MyWallBottomStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        myWallBottomFirstButton.addTarget(self, action: #selector(gotoDashBoardInfo(sender:)),for: .touchUpInside)
        myWallBottomSecondButton.addTarget(self, action: #selector(gotoDashBoardInfo(sender:)),for: .touchUpInside)

        
        myWallBottomViewHeightConstraint = MyWallBottomStackView.heightAnchor.constraint(equalToConstant: 50)
        myWallBottomViewHeightConstraint?.isActive = true
        
        myWallBottomViewTopConstraint = MyWallBottomStackView.topAnchor.constraint(equalTo: MyWallMidSecondStackView.bottomAnchor, constant: 10)
        myWallBottomViewTopConstraint?.isActive = true
        
        /*
        fieldsContainer.addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: MyWallBottomStackView.bottomAnchor, constant: 10),
            chartView.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 0),
            chartView.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: 0),
            chartView.bottomAnchor.constraint(equalTo: fieldsContainer.bottomAnchor, constant: -5),
            
        ]) */
        
        barChart = BarChartView()
        fieldsContainer.addSubview(barChart)
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.delegate = self
        NSLayoutConstraint.activate([
            barChart.topAnchor.constraint(equalTo: MyWallBottomStackView.bottomAnchor, constant: 10),
            barChart.leadingAnchor.constraint(equalTo: fieldsContainer.leadingAnchor, constant: 0),
            barChart.trailingAnchor.constraint(equalTo: fieldsContainer.trailingAnchor, constant: 0),
            barChart.bottomAnchor.constraint(equalTo: fieldsContainer.bottomAnchor, constant: -5),
            
        ])
        
        fieldsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        
    }
    
    func hdndleUserInterface(){
        self.dashBoardType = DashBoardType(rawValue: self.itemTabType.tabType)!
        switch self.dashBoardType {
        case .Grievances:
            do {
                let grievances : [DashboardDataStruct] = self.dashboardDict["0"]!
                self.topFirstButton.setTitle(" \(grievances[0].MyWallItemTitle) :  \(self.userDashModdel?.noOfGrievances ?? 0) ", for: .normal)
                                
                self.topSecondButton.setTitle(" \(grievances[1].MyWallItemTitle) :  \(self.userDashModdel?.noOfInProgress ?? 0) ", for: .normal)
                                
                self.midFirstButton.setTitle(" \(grievances[2].MyWallItemTitle) : \(self.userDashModdel?.noOfSolved ?? 0) ", for: .normal)
                
                self.midSecondButton.setTitle(" \(grievances[3].MyWallItemTitle) :  \(self.userDashModdel?.noOnHold ?? 0)", for: .normal)
                
                                
                self.topFirstButton.fillColor = grievances[0].MyWallcolorCode
                self.topSecondButton.fillColor = grievances[1].MyWallcolorCode
                self.midFirstButton.fillColor = grievances[2].MyWallcolorCode
                self.midSecondButton.fillColor = grievances[3].MyWallcolorCode
                
                self.topFirstButton.dashboardObj = grievances[0]
                self.topSecondButton.dashboardObj = grievances[1]
                self.midFirstButton.dashboardObj = grievances[2]
                self.midSecondButton.dashboardObj = grievances[3]

                
                
                myWallBottomViewTopConstraint?.constant = 0
                myWallBottomViewHeightConstraint?.constant = 0
                
                elements = ["1", "2", "3"]
                let unitsSold : [Double] = [Double(self.userDashModdel?.noOfInProgress ?? 0),
                                            Double(self.userDashModdel?.noOfSolved ?? 0),
                                            Double(self.userDashModdel?.noOnHold ?? 0)]
                
                let labels : [String] = [grievances[1].MyWallItemTitle
                                         , grievances[2].MyWallItemTitle,
                                         grievances[3].MyWallItemTitle]
                
                let colors : [UIColor] = [grievances[1].MyWallcolorCode,
                                          grievances[2].MyWallcolorCode,
                                          grievances[3].MyWallcolorCode]
                setChart(dataPoints: elements, values: unitsSold ,lables: labels, colorsArray: colors)
                
                
            }
            break
        case .Reimbursement:
            do{
                let reimbursement : [DashboardDataStruct] = self.dashboardDict["1"]!

                self.topFirstButton.setTitle(" \(reimbursement[0].MyWallItemTitle) : \(self.userDashModdel?.totalReimbursements ?? 0) ", for: .normal)
                self.topSecondButton.setTitle(" \(reimbursement[1].MyWallItemTitle) : \(self.userDashModdel?.totalReimbursementPending ?? 0) ", for: .normal)
                self.midFirstButton.setTitle(" \(reimbursement[2].MyWallItemTitle) : \(self.userDashModdel?.totalReimbursementSanctioned ?? 0) ", for: .normal)
                self.midSecondButton.setTitle(" \(reimbursement[3].MyWallItemTitle) : \(self.userDashModdel?.totalReimbursementRejected ?? 0) ", for: .normal)
                
                

                self.topFirstButton.fillColor = reimbursement[0].MyWallcolorCode
                self.topSecondButton.fillColor = reimbursement[1].MyWallcolorCode
                self.midFirstButton.fillColor = reimbursement[2].MyWallcolorCode
                self.midSecondButton.fillColor = reimbursement[3].MyWallcolorCode
                myWallBottomViewTopConstraint?.constant = 0
                myWallBottomViewHeightConstraint?.constant = 0
                
                
                self.topFirstButton.dashboardObj = reimbursement[0]
                self.topSecondButton.dashboardObj = reimbursement[1]
                self.midFirstButton.dashboardObj = reimbursement[2]
                self.midSecondButton.dashboardObj = reimbursement[3]

                
                
                elements = ["1", "2", "3"]
                let unitsSold : [Double] = [Double(self.userDashModdel?.totalReimbursementPending ?? 0),
                                            Double(self.userDashModdel?.totalReimbursementSanctioned ?? 0),
                                            Double(self.userDashModdel?.totalReimbursementRejected ?? 0)]

                
                let labels : [String] = [reimbursement[1].MyWallItemTitle
                                         , reimbursement[2].MyWallItemTitle,
                                         reimbursement[3].MyWallItemTitle]
                let colors : [UIColor] = [reimbursement[1].MyWallcolorCode,
                                          reimbursement[2].MyWallcolorCode,
                                          reimbursement[3].MyWallcolorCode]
                setChart(dataPoints: elements, values: unitsSold ,lables: labels, colorsArray: colors)


            }
            break
        case .LOC:
            do {
                
                let LOC : [DashboardDataStruct] = self.dashboardDict["2"]!

                self.topFirstButton.setTitle(" \(LOC[0].MyWallItemTitle) : \(self.userDashModdel?.totalLOC ?? 0) ", for: .normal)
                self.topSecondButton.setTitle(" \(LOC[1].MyWallItemTitle) : \(self.userDashModdel?.totalLOCPending ?? 0) ", for: .normal)
                self.midFirstButton.setTitle(" \(LOC[2].MyWallItemTitle) : \(self.userDashModdel?.totalLOCSanctioned ?? 0) ", for: .normal)
                self.midSecondButton.setTitle(" \(LOC[3].MyWallItemTitle) : \(self.userDashModdel?.totalLOCRejected ?? 0) ", for: .normal)

                self.topFirstButton.fillColor = LOC[0].MyWallcolorCode
                self.topSecondButton.fillColor = LOC[1].MyWallcolorCode
                self.midFirstButton.fillColor = LOC[2].MyWallcolorCode
                self.midSecondButton.fillColor = LOC[3].MyWallcolorCode

                myWallBottomViewTopConstraint?.constant = 0
                myWallBottomViewHeightConstraint?.constant = 0
                
                self.topFirstButton.dashboardObj = LOC[0]
                self.topSecondButton.dashboardObj = LOC[1]
                self.midFirstButton.dashboardObj = LOC[2]
                self.midSecondButton.dashboardObj = LOC[3]

                
                
                elements = ["1", "2", "3"]
                let unitsSold : [Double] = [Double(self.userDashModdel?.totalLOCPending ?? 0),
                                            Double(self.userDashModdel?.totalLOCSanctioned ?? 0),
                                            Double(self.userDashModdel?.totalLOCRejected ?? 0)]

                
                let labels : [String] = [LOC[1].MyWallItemTitle
                                         , LOC[2].MyWallItemTitle,
                                         LOC[3].MyWallItemTitle]
                let colors : [UIColor] = [LOC[1].MyWallcolorCode,
                                          LOC[2].MyWallcolorCode,
                                          LOC[3].MyWallcolorCode]
                setChart(dataPoints: elements, values: unitsSold ,lables: labels, colorsArray: colors)

                
            }
            break
        case .PeshiFiles:
            do {
                
                let PeshiFiles : [DashboardDataStruct] = self.dashboardDict["3"]!

                self.topFirstButton.setTitle(" \(PeshiFiles[0].MyWallItemTitle) : \(self.userDashModdel?.totalPeshiFiles ?? 0) ", for: .normal)
                self.topSecondButton.setTitle(" \(PeshiFiles[1].MyWallItemTitle) : \(self.userDashModdel?.totalPeshiFilesPending ?? 0) ", for: .normal)
                self.midFirstButton.setTitle(" \(PeshiFiles[2].MyWallItemTitle) : \(self.userDashModdel?.totalPeshiFilesApproved ?? 0) ", for: .normal)
                self.midSecondButton.setTitle(" \(PeshiFiles[3].MyWallItemTitle) : \(self.userDashModdel?.totalPeshiFilesLieOver ?? 0) ", for: .normal)
                self.myWallBottomFirstButton.setTitle(" \(PeshiFiles[4].MyWallItemTitle) : \(self.userDashModdel?.totalPeshiFilesReturned ?? 0) ", for: .normal)
                
                

                self.topFirstButton.fillColor = PeshiFiles[0].MyWallcolorCode
                self.topSecondButton.fillColor = PeshiFiles[1].MyWallcolorCode
                self.midFirstButton.fillColor = PeshiFiles[2].MyWallcolorCode
                self.midSecondButton.fillColor = PeshiFiles[3].MyWallcolorCode
                self.myWallBottomFirstButton.fillColor = PeshiFiles[4].MyWallcolorCode
                
                self.topFirstButton.dashboardObj = PeshiFiles[0]
                self.topSecondButton.dashboardObj = PeshiFiles[1]
                self.midFirstButton.dashboardObj = PeshiFiles[2]
                self.midSecondButton.dashboardObj = PeshiFiles[3]
                self.myWallBottomFirstButton.dashboardObj = PeshiFiles[4]

                self.midSecondButton.setTitleColor(UIColor.MyWall.appColor, for: .normal)
                

                self.myWallBottomSecondButton.isHidden = true

                elements = ["1", "2", "3","4"]
                let unitsSold : [Double] = [Double(self.userDashModdel?.totalPeshiFilesPending ?? 0),
                                            Double(self.userDashModdel?.totalPeshiFilesApproved ?? 0),
                                            Double(self.userDashModdel?.totalPeshiFilesLieOver ?? 0),
                                            Double(self.userDashModdel?.totalPeshiFilesReturned ?? 0)]

                
                let labels : [String] = [PeshiFiles[1].MyWallItemTitle
                                         , PeshiFiles[2].MyWallItemTitle,
                                         PeshiFiles[3].MyWallItemTitle,
                                         PeshiFiles[4].MyWallItemTitle]
                
                let colors : [UIColor] = [PeshiFiles[1].MyWallcolorCode,
                                          PeshiFiles[2].MyWallcolorCode,
                                          PeshiFiles[3].MyWallcolorCode,
                                          PeshiFiles[4].MyWallcolorCode]
                
                setChart(dataPoints: elements, values: unitsSold ,lables: labels, colorsArray: colors)

                
            }
            break
        case .Endorsement:
            do{
                
                let Endorsement : [DashboardDataStruct] = self.dashboardDict["4"]!
                self.topFirstButton.setTitle(" \(Endorsement[0].MyWallItemTitle) : \(self.userDashModdel?.totalEndorsements ?? 0) ", for: .normal)
                self.topSecondButton.setTitle(" \(Endorsement[1].MyWallItemTitle) : \(self.userDashModdel?.totalEndorsementsNew ?? 0) ", for: .normal)
                self.midFirstButton.setTitle(" \(Endorsement[2].MyWallItemTitle) : \(self.userDashModdel?.totalEndorsementsPendng ?? 0) ", for: .normal)
                self.midSecondButton.setTitle(" \(Endorsement[3].MyWallItemTitle) : \(self.userDashModdel?.totalEndorsementsDispatched ?? 0) ", for: .normal)
                self.myWallBottomFirstButton.setTitle(" \(Endorsement[4].MyWallItemTitle) : \(self.userDashModdel?.totalEndorsementsHold ?? 0) ", for: .normal)
                self.myWallBottomSecondButton.setTitle(" \(Endorsement[5].MyWallItemTitle) : \(self.userDashModdel?.totalEndorsementsLieOver ?? 0) ", for: .normal)

                self.topFirstButton.fillColor = Endorsement[0].MyWallcolorCode
                self.topSecondButton.fillColor = Endorsement[1].MyWallcolorCode
                self.midFirstButton.fillColor = Endorsement[2].MyWallcolorCode
                self.midSecondButton.fillColor = Endorsement[3].MyWallcolorCode
                self.myWallBottomFirstButton.fillColor = Endorsement[4].MyWallcolorCode
                self.myWallBottomSecondButton.fillColor = Endorsement[5].MyWallcolorCode
                
                
                self.topFirstButton.dashboardObj = Endorsement[0]
                self.topSecondButton.dashboardObj = Endorsement[1]
                self.midFirstButton.dashboardObj = Endorsement[2]
                self.midSecondButton.dashboardObj = Endorsement[3]
                self.myWallBottomFirstButton.dashboardObj = Endorsement[4]
                self.myWallBottomSecondButton.dashboardObj = Endorsement[5]

                self.topSecondButton.setTitleColor(UIColor.MyWall.appColor, for: .normal)

                
                
                elements = ["1", "2", "3","4","5"]
                let unitsSold : [Double] = [Double(self.userDashModdel?.totalEndorsementsNew ?? 0),
                                            Double(self.userDashModdel?.totalEndorsementsPendng ?? 0),
                                            Double(self.userDashModdel?.totalEndorsementsDispatched ?? 0),
                                            Double(self.userDashModdel?.totalEndorsementsHold ?? 0),
                                            Double(self.userDashModdel?.totalEndorsementsLieOver ?? 0)]

                
                let labels : [String] = [Endorsement[1].MyWallItemTitle
                                         , Endorsement[2].MyWallItemTitle,
                                         Endorsement[3].MyWallItemTitle,
                                         Endorsement[4].MyWallItemTitle,
                                         Endorsement[5].MyWallItemTitle]
                
                let colors : [UIColor] = [Endorsement[1].MyWallcolorCode,
                                          Endorsement[2].MyWallcolorCode,
                                          Endorsement[3].MyWallcolorCode,
                                          Endorsement[4].MyWallcolorCode,
                                          Endorsement[5].MyWallcolorCode]
                
                setChart(dataPoints: elements, values: unitsSold ,lables: labels, colorsArray: colors)

                
            }
            break
        case .Letters:
            do  {
                
                let Letters : [DashboardDataStruct] = self.dashboardDict["5"]!
                self.topFirstButton.setTitle(" \(Letters[0].MyWallItemTitle) : \(self.userDashModdel?.totalLettersAndNotes ?? 0) ", for: .normal)
                self.topSecondButton.setTitle(" \(Letters[1].MyWallItemTitle) : \(self.userDashModdel?.totalLettersAndNotesNew ?? 0) ", for: .normal)
                self.midFirstButton.setTitle(" \(Letters[2].MyWallItemTitle) : \(self.userDashModdel?.totalLettersAndNotesPending ?? 0) ", for: .normal)
                self.midSecondButton.setTitle(" \(Letters[3].MyWallItemTitle) : \(self.userDashModdel?.totalLettersAndNotesDispatched ?? 0) ", for: .normal)
                self.myWallBottomFirstButton.setTitle(" \(Letters[4].MyWallItemTitle) : \(self.userDashModdel?.totalLettersAndNotesHold ?? 0) ", for: .normal)
                self.myWallBottomSecondButton.setTitle(" \(Letters[5].MyWallItemTitle) : \(self.userDashModdel?.totalLettersAndNotesLieOver ?? 0) ", for: .normal)

                self.topFirstButton.fillColor = Letters[0].MyWallcolorCode
                self.topSecondButton.fillColor = Letters[1].MyWallcolorCode
                self.midFirstButton.fillColor = Letters[2].MyWallcolorCode
                self.midSecondButton.fillColor = Letters[3].MyWallcolorCode
                self.myWallBottomFirstButton.fillColor = Letters[4].MyWallcolorCode
                self.myWallBottomSecondButton.fillColor = Letters[5].MyWallcolorCode
                
                self.topFirstButton.dashboardObj = Letters[0]
                self.topSecondButton.dashboardObj = Letters[1]
                self.midFirstButton.dashboardObj = Letters[2]
                self.midSecondButton.dashboardObj = Letters[3]
                self.myWallBottomFirstButton.dashboardObj = Letters[4]
                self.myWallBottomSecondButton.dashboardObj = Letters[5]

                self.topSecondButton.setTitleColor(UIColor.MyWall.appColor, for: .normal)

                
                
                elements = ["1", "2", "3","4","5"]
                let unitsSold : [Double] = [Double(self.userDashModdel?.totalLettersAndNotesNew ?? 0),
                                            Double(self.userDashModdel?.totalLettersAndNotesPending ?? 0),
                                            Double(self.userDashModdel?.totalLettersAndNotesDispatched ?? 0),
                                            Double(self.userDashModdel?.totalLettersAndNotesHold ?? 0),
                                            Double(self.userDashModdel?.totalLettersAndNotesLieOver ?? 0)]

                
                
                let labels : [String] = [Letters[1].MyWallItemTitle
                                         , Letters[2].MyWallItemTitle,
                                         Letters[3].MyWallItemTitle,
                                         Letters[4].MyWallItemTitle,
                                         Letters[5].MyWallItemTitle]
                
                let colors : [UIColor] = [Letters[1].MyWallcolorCode,
                                          Letters[2].MyWallcolorCode,
                                          Letters[3].MyWallcolorCode,
                                          Letters[4].MyWallcolorCode,
                                          Letters[5].MyWallcolorCode]
                
                setChart(dataPoints: elements, values: unitsSold ,lables: labels, colorsArray: colors)
                
            }
            break
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true

    }
    
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        
    }

    
    func setChart(dataPoints: [String], values: [Double],lables:[String],colorsArray:[UIColor])
    {
        barChart.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<values.count
        {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [Double(values[i])])
            dataEntries.append(dataEntry)
        }
        let chartDataSet:BarChartDataSet!
        chartDataSet = BarChartDataSet(entries: dataEntries, label: "BarChart Data")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChart.xAxis.granularityEnabled = true
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelCount = 30
        barChart.xAxis.granularity = 2
        barChart.leftAxis.enabled = true
        barChart.leftAxis.axisMinimum = 0
//        barChart.leftAxis.axisMinimum = Double(values.min()! - 0.1)
        barChart.leftAxis.axisMaximum = Double(values.max()! + 0.05)
        barChart.pinchZoomEnabled = true
        barChart.scaleYEnabled = true
        barChart.scaleXEnabled = true
        barChart.highlighter = nil
        barChart.doubleTapToZoomEnabled = true
        barChart.chartDescription?.text = ""
        barChart.rightAxis.enabled = false
        let labels = lables
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
        barChart.xAxis.labelPosition = .top
        barChart.data = chartData
        barChart.xAxis.granularity = 1
        barChart.data?.setDrawValues(false)
        barChart.setScaleEnabled(false)
        

        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutQuart)
        chartDataSet.colors = colorsArray
    }
    
    
    @objc func gotoDashBoardInfo(sender:KetoButton){
        self.dashBoardType = DashBoardType(rawValue: self.itemTabType.tabType)!
        
        
        switch self.dashBoardType {
        case .Grievances:
            do {
                
                let catVC = CategoryVC()
                let aObjNavi = UINavigationController(rootViewController: catVC)
                aObjNavi.modalPresentationStyle = .fullScreen
                catVC.itemTabType = self.itemTabType
                catVC.dashBoardType = self.dashBoardType
                if sender.dashboardObj.MyWallItemTitle == "Total" {
                    catVC.catTitile = "GRIEVANCES (All)"
                    catVC.catTUrl = myHelper.grievanceall
                }
                else if sender.dashboardObj.MyWallItemTitle == "Under Process"{
                    catVC.catTitile = "GRIEVANCES (Under Process)"
                    catVC.catTUrl = myHelper.grievanceallUnderProcess

                }
                else if sender.dashboardObj.MyWallItemTitle == "Solved"{
                    catVC.catTitile = "GRIEVANCES (Solved)"
                    catVC.catTUrl = myHelper.grievanceallSolved
                }
                else {
                    catVC.catTitile = "GRIEVANCES (Closed)"
                    catVC.catTUrl = myHelper.grievanceallClosed
                }
                
                self.present(aObjNavi, animated: true, completion: nil)

            }
            break
        case .Reimbursement:
            do{

                let catVC = ReimbrusementVC()
                let aObjNavi = UINavigationController(rootViewController: catVC)
                aObjNavi.modalPresentationStyle = .fullScreen
                catVC.itemTabType = self.itemTabType
                catVC.dashBoardType = self.dashBoardType

                if sender.dashboardObj.MyWallItemTitle == "Total" {
                    catVC.catTitile = "REIMBURSEMENT (All)"
                    catVC.catTUrl = myHelper.Reimbursementall
                }
                else if sender.dashboardObj.MyWallItemTitle == "Pending"{
                    catVC.catTitile = "REIMBURSEMENT (Pending)"
                    catVC.catTUrl = myHelper.ReimbursementallPending
                }
                else if sender.dashboardObj.MyWallItemTitle == "Sanctioned"{
                    catVC.catTitile = "REIMBURSEMENT (Sanctioned)"
                    catVC.catTUrl = myHelper.ReimbursementallSanctioned
                }
                else {
                    catVC.catTitile = "REIMBURSEMENT (Rejected)"
                    catVC.catTUrl = myHelper.ReimbursementallRejected
                }
                
                self.present(aObjNavi, animated: true, completion: nil)
                
            }
            break
        case .LOC:
            do {
                
                let catVC = ReimbrusementVC()
                let aObjNavi = UINavigationController(rootViewController: catVC)
                aObjNavi.modalPresentationStyle = .fullScreen
                catVC.itemTabType = self.itemTabType
                catVC.dashBoardType = self.dashBoardType

                if sender.dashboardObj.MyWallItemTitle == "Total" {
                    catVC.catTitile = "LOC (All)"
                    catVC.catTUrl = myHelper.LOCall
                }
                else if sender.dashboardObj.MyWallItemTitle == "Pending"{
                    catVC.catTitile = "LOC (Pending)"
                    catVC.catTUrl = myHelper.LOCallPending
                }
                else if sender.dashboardObj.MyWallItemTitle == "Sanctioned"{
                    catVC.catTitile = "LOC (Sanctioned)"
                    catVC.catTUrl = myHelper.LOOCallSanctioned
                }
                else {
                    catVC.catTitile = "LOC (Rejected)"
                    catVC.catTUrl = myHelper.LOCallRejected
                }
                
                self.present(aObjNavi, animated: true, completion: nil)

                
            }
            break
        case .PeshiFiles:
            do {
                
                let catVC = peshiVC()
                let aObjNavi = UINavigationController(rootViewController: catVC)
                aObjNavi.modalPresentationStyle = .fullScreen
                catVC.itemTabType = self.itemTabType
                catVC.dashBoardType = self.dashBoardType
                
                
                if sender.dashboardObj.MyWallItemTitle == "Total" {
                    catVC.catTitile = "PESHI-FILES (All)"
                    catVC.catTUrl = myHelper.peshi
                }
                else if sender.dashboardObj.MyWallItemTitle == "Under Process"{
                    catVC.catTitile = "PESHI-FILES( Under Process)"
                    catVC.catTUrl = myHelper.peshiUnderProcess
                }
                else if sender.dashboardObj.MyWallItemTitle == "Approved"{
                    catVC.catTitile = "PESHI-FILES (Approved)"
                    catVC.catTUrl = myHelper.peshiallApproved
                }
                else if sender.dashboardObj.MyWallItemTitle == "Lie Over"{
                    catVC.catTitile = "PESHI-FILES (Lie Over)"
                    catVC.catTUrl = myHelper.peshiLieOver
                }
                else {
                    catVC.catTitile = "PESHI-FILES (Returned)"
                    catVC.catTUrl = myHelper.peshiallReturned
                }
                self.present(aObjNavi, animated: true, completion: nil)


                
            }
            break
        case .Endorsement:
            do{
                
                let catVC = EndorseDashBoardVC()
                let aObjNavi = UINavigationController(rootViewController: catVC)
                aObjNavi.modalPresentationStyle = .fullScreen
                catVC.itemTabType = self.itemTabType
                catVC.dashBoardType = self.dashBoardType
                
                
                if sender.dashboardObj.MyWallItemTitle == "Total" {
                    catVC.catTitile = "ENDORSEMENT (All)"
                    catVC.catTUrl = myHelper.endorsementAll
                }
                else if sender.dashboardObj.MyWallItemTitle == "New"{
                    catVC.catTitile = "ENDORSEMENT (New)"
                    catVC.catTUrl = myHelper.endosementNew
                }
                else if sender.dashboardObj.MyWallItemTitle == "Pending"{
                    catVC.catTitile = "ENDORSEMENT (Pending)"
                    catVC.catTUrl = myHelper.endosementPending
                }
                else if sender.dashboardObj.MyWallItemTitle == "Dispatched"{
                    catVC.catTitile = "ENDORSEMENT (Dispatched)"
                    catVC.catTUrl = myHelper.endosementDispatched
                }
                else if sender.dashboardObj.MyWallItemTitle == "Hold"{
                    catVC.catTitile = "ENDORSEMENT (Hold)"
                    catVC.catTUrl = myHelper.endosementHold
                }
                else {
                    catVC.catTitile = "ENDORSEMENT (Lie Over)"
                    catVC.catTUrl = myHelper.endosementLieOver
                }
                self.present(aObjNavi, animated: true, completion: nil)

                
            }
            break
        case .Letters:
            do  {
                
                let catVC = LetterDashBoardVC()
                let aObjNavi = UINavigationController(rootViewController: catVC)
                aObjNavi.modalPresentationStyle = .fullScreen
                catVC.itemTabType = self.itemTabType
                catVC.dashBoardType = self.dashBoardType
                
                if sender.dashboardObj.MyWallItemTitle == "Total" {
                    catVC.catTitile = "LETTERS (All)"
                    catVC.catTUrl = myHelper.letterAll
                }
                else if sender.dashboardObj.MyWallItemTitle == "New"{
                    catVC.catTitile = "LETTERS (New)"
                    catVC.catTUrl = myHelper.letterNew
                }
                else if sender.dashboardObj.MyWallItemTitle == "Pending"{
                    catVC.catTitile = "LETTERS (Pending)"
                    catVC.catTUrl = myHelper.letterPending
                }
                else if sender.dashboardObj.MyWallItemTitle == "Dispatched"{
                    catVC.catTitile = "LETTERS (Dispatched)"
                    catVC.catTUrl = myHelper.letterDispatched
                }
                else if sender.dashboardObj.MyWallItemTitle == "Hold"{
                    catVC.catTitile = "LETTERS (Hold)"
                    catVC.catTUrl = myHelper.letterHold
                }
                else {
                    catVC.catTitile = "LETTERS (Lie Over)"
                    catVC.catTUrl = myHelper.letterLieOver
                }
                self.present(aObjNavi, animated: true, completion: nil)

            }
            break
        }
        

        
    }

}



struct DashboardModel: Codable {
    
    let noOfGrievances, currentMonthGrievances, currentMonthAddressedGrievances, pendingGrievances: Int
    let pendingMoreThanAMonth, noOfNewGrievances, noOfInProgress: Int
    let noOfSolved,noOfWaiting,noOfClosed,noOfPartlySolved,noOnHold,noAssignedToCMRF,noAssignedToNRI : Int
    let noAssignedToPeshi,noAssignedToGeneral,noAssignedToGHMC,noAssignedToHMWS,totalPeshiFiles : Int
    let totalPeshiFilesApproved,totalPeshiFilesLieOver,totalPeshiFilesPending,totalPeshiFilesReturned : Int
    let totalReimbursements,totalReimbursementPending,totalReimbursementRejected,totalReimbursementSanctioned:Int
    let totalLOC,totalLOCPending,totalLOCRejected,totalLOCSanctioned,totalEndorsements,totalEndorsementsNew:Int
    let totalEndorsementsDispatched,totalEndorsementsHold,totalEndorsementsLieOver,totalEndorsementsPendng: Int
    let totalLetters,totalLettersNew,totalLettersDispatched,totalLettersHold,totalLettersLieOver,totalLettersPendng:Int
    let totalDOs,totalDONew,totalDODispatched,totalDOHold,totalDOLieOver,totalDOPendng,totalNotes:Int
    
    let totalNotesNew,totalNotesDispatched,totalNotesHold,totalNotesLieOver,totalNotesPendng : Int
    
    let totalLettersAndNotes,totalLettersAndNotesNew,totalLettersAndNotesDispatched : Int
    
    let totalLettersAndNotesHold,totalLettersAndNotesLieOver,totalLettersAndNotesPending : Int
        
}

