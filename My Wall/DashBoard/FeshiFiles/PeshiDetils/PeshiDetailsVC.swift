//
//  PeshiDetailsVC.swift
//  My Wall
//
//  Created by surendra on 06/12/20.
//

import UIKit

class PeshiDetailsVC: UIViewController {
    
    
    var dashBoardType : DashBoardType = .Grievances
    var eachBlog : PeshModelNewElement? = nil
    var peshiObj : PeshiDetailsModel? = nil
    

    var section1 : [menuItem]!
    var section2 : [menuItem]!
    var section3 : [menuItem]!

    
    let File = menuItem(Name: "File :")
    let Date = menuItem(Name: "Subject :")
    let status = menuItem(Name: "Status :")
    let department = menuItem(Name: "Department :")
    let receivedFrom = menuItem(Name: "Received From :")
    let receivedDate = menuItem(Name: "Received Date :")
    let returnTo = menuItem(Name: "Return To :")
    let returnDate = menuItem(Name: "Return Date :")
    let assignedTo = menuItem(Name: "Assignted To :")
    let fileLocation = menuItem(Name: "File Location :")

    let remarks = menuItem(Name: "Remarks")
    
    let ministerRemarks = menuItem(Name: "Minister Remarks")
    var section1DetilsArray : [menuItem]!


    lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.delegate = (self as UITableViewDelegate)
        tableView.dataSource = (self as UITableViewDataSource)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ConfigureNavBarDetils()
        self.title = "Peshi File"
        
        
        section1 = [File,Date,status,department,receivedFrom,receivedDate,returnTo,returnDate,assignedTo,fileLocation]
        section2 = [remarks]
        section3 = [ministerRemarks]
        self.section1DetilsArray = []


        
        view.addSubview(tableview)
        tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        let nibName = UINib(nibName: "GrievancDetailsCell", bundle:nil)
        tableview.register(nibName, forCellReuseIdentifier: "GrievancDetailsCell")

        let nibName1 = UINib(nibName: "TextViewTableViewCell", bundle:nil)
        tableview.register(nibName1, forCellReuseIdentifier: "TextViewTableViewCell")
        
        let nibName2 = UINib(nibName: "TextButtonCell", bundle:nil)
        tableview.register(nibName2, forCellReuseIdentifier: "TextButtonCell")


        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 50

        UserManager.getLoggedUserInfo()
        self.getCategoryData()

        
    }

    
    func getCategoryData()
    {
        
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }
        guard let userID :String = eachBlog?.fileNo else {
            return
        }
         var catUrl : String = ""
            catUrl  =  myHelper.peshiDetails + userID
        
        let activityView = MyActivityView()
        activityView.displayLoader()
        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(catUrl, parameters) { (urlData) in
            activityView.dismissLoader()
            do {
                let rootDicnew = try JSONDecoder().decode(PeshiDetailsModel.self, from: urlData)
                self.peshiObj = rootDicnew
                if rootDicnew.peshiFiles.fileNo!.count > 0 {
                    
                    let File = menuItem(Name: rootDicnew.peshiFiles.fileNo ?? "")
                    let Date = menuItem(Name: rootDicnew.peshiFiles.subject ?? "")
                    let status = menuItem(Name: rootDicnew.peshiFiles.status ?? "")
                    let department = menuItem(Name: rootDicnew.peshiFiles.department ?? "")
                    let receivedFrom = menuItem(Name: rootDicnew.peshiFiles.receivedFrom ?? "")
                    let receivedDate = menuItem(Name: rootDicnew.peshiFiles.receivedDate ?? "")
                    let returnTo = menuItem(Name: rootDicnew.peshiFiles.returnedTo ?? "")
                    let returnDate = menuItem(Name: rootDicnew.peshiFiles.returnedDate ?? "")
                    let assignedTo = menuItem(Name: rootDicnew.peshiFiles.assignedTo ?? "")
                    let fileLocation = menuItem(Name: rootDicnew.peshiFiles.fileLocation ?? "")

                    self.section1DetilsArray = [File,Date,status,department,receivedFrom,receivedDate,returnTo,returnDate,assignedTo,fileLocation]

                    
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                    
                }
                
            } catch (let error) {
                activityView.dismissLoader()
                do {
//                    let errorModel = try JSONDecoder().decode(ErrorModel.self, from: urlData)
                    self.view.makeToast("View Reimbursement and LOC - 409")
                }
                catch {
                    ErrorManager.showErrorAlert(mainTitle: "", subTitle: error.localizedDescription)
                }
            }
            
        }
        
        failure: { (errorString) in
            activityView.dismissLoader()
            ErrorManager.showErrorAlert(mainTitle: "", subTitle: errorString)

        }
        
        
    }
    
    



}



extension UIViewController
{
    func ConfigureNavBarDetils(){
        navigationController?.navigationBar.barTintColor = UIColor.MyWall.appColor
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(backActionDetails), for: .touchUpInside)
        backButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        
        let rightbackButton = UIButton(type: .custom)
        rightbackButton.setImage(UIImage.init(named: "ktr30"), for: .normal)
        rightbackButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightbackButton.layer.cornerRadius = 15
        rightbackButton.clipsToBounds = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightbackButton)


        
        
    }

    @objc func backActionDetails () {
        self.dismiss(animated: true, completion: nil)
    }
}




extension PeshiDetailsVC: UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return section1.count
        }
        else if section == 1
        {
            return section2.count
        }
        else {
            if self.peshiObj != nil {
                return section3.count
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var items : [menuItem]!
        let cell = UITableViewCell()
        
        if indexPath.section == 0 {
            items = section1
             let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.text = ""

            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section1DetilsArray.count > 0 {
                let theMenuItemDescription = self.section1DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
           
            if  indexPath.row == 0 {
                cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
            }
            
            if indexPath.row == 2 {
                cell.gtitleDescription.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            }

            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1 {
            items = section2
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewTableViewCell", for: indexPath) as! TextViewTableViewCell
            cell.selectionStyle = .none
            cell.textView.textColor = UIColor.black
            cell.textView.text = self.peshiObj?.peshiFiles.remarks
            cell.selectionStyle = .none
            if cell.textView.text.isEmpty || cell.textView.text == "Remarks" {
                cell.textView.text = "Remarks"
                cell.textView.textColor = UIColor.lightGray
            }
            return cell

        }
        else if indexPath.section == 2 {
            items = section3
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextButtonCell", for: indexPath) as! TextButtonCell
            cell.textView.textColor = UIColor.black
            cell.selectionStyle = .none

            if self.peshiObj != nil {
                cell.textView.text = self.peshiObj?.peshiFiles.ministerRemarks
                if (self.peshiObj?.uploadedFiles?.count)! > 0 {
                    cell.shadowView.isHidden = false
                    let uploadFileInfo = self.peshiObj?.uploadedFiles?.first
                    let attributedString = NSAttributedString(string: uploadFileInfo?.fileName ?? "", attributes:[
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                        NSAttributedString.Key.foregroundColor : UIColor.blue,
                        NSAttributedString.Key.underlineStyle:1.0
                    ])
                    cell.shadowButton.setAttributedTitle(attributedString, for: .normal)
                    let UrlString = uploadFileInfo!.filePath  + "/" + uploadFileInfo!.fileName
                    cell.shadowButton.menuObjName = UrlString
                    cell.shadowButton.addTarget(self, action: #selector(navigateAcion(sender:)), for: .touchUpInside)
                }else{
                    cell.shadowView.isHidden = true
                }

            }else{
                cell.shadowView.isHidden = true
            }
            
            if cell.textView.text.isEmpty || cell.textView.text == "Minister Remarks" {
                cell.textView.text = "Minister Remarks"
                cell.textView.textColor = UIColor.lightGray
            }

            
            return cell
        }
        return cell
    }
    
    
    @objc func navigateAcion(sender:DataButton){
        guard let dailNumber = sender.menuObjName else { return }
        if let url = URL(string: dailNumber) {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                return UITableView.automaticDimension
            }
            return 60
        }
        if indexPath.section == 1
        {
            return 100
        }
        if indexPath.section == 2
        {
            if self.peshiObj != nil {
                if (self.peshiObj?.uploadedFiles?.count)! > 0 {
                    return 180
                }else{
                    return 100
                }
            }else{
                return 100
            }
        }
        
        return 50
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Peshi Files - Status"
        }else if section == 1{
            return "Remarks"
        }
        else {
            return "Minister Remarks"
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
   
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
        }
        if indexPath.section == 1
        {
            return 100
        }
        if indexPath.section == 2
        {
            return 160
        }
        
        return 50
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.MyWall.appColor
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }

    

    
}




struct PeshiDetailsModel: Codable {
    let peshiFiles: PeshiFiles
    let fileNo: Int
    let statusLists, deptLists: [ListModel]
    let uploadedFiles: [UploadedFile]?
}

// MARK: - List
struct ListModel: Codable {
    let id, listName, listItem: String
    let status: String?
}

// MARK: - PeshiFiles
struct PeshiFiles: Codable {
    let id, fileNo, fileNoString, status: String?
    let subject, assignedTo, department, receivedFrom: String?
    let receivedDate: String?
    let returnedTo: String?
    let returnedDate, ministerRemarks, remarks: String?
    let fileLocation: String?
}

