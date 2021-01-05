//
//  LetterDetilsVC.swift
//  My Wall
//
//  Created by surendra on 06/12/20.
//

import UIKit

class LetterDetilsVC: UIViewController {
    
    var dashBoardType : DashBoardType = .Letters
    var eachBlog : LeeterDashModelElement? = nil
    var letterModekObj : LetterDetailsModel? = nil


    
    var section1 : [menuItem]!
    var section2 : [menuItem]!
    var section3 : [menuItem]!
    var section4 : [menuItem]!
    var section5 : [menuItem]!
    var section6 : [menuItem]!

    
    let lonno = menuItem(Name: "Lon No :")
    let Date = menuItem(Name: "Date :")
    let category = menuItem(Name: "Category :")
    let status = menuItem(Name: "Status :")
    
    
    let Referencedby = menuItem(Name: "Referenced by :")
    let Referencephone = menuItem(Name: "Reference Phone :")
    let fileLOcation = menuItem(Name: "File LOcation :")
    
    
    let pettioner = menuItem(Name: "Pettitioner Type :")
    let pettionerName = menuItem(Name: "Pettitioner name :")
    let pettionerPhone = menuItem(Name: "Pettitioner Phone :")
    let subject = menuItem(Name: "Subject :")


    let department = menuItem(Name: "Department :")
    let dispatch = menuItem(Name: "Dispatch Mode:")
    let addresto = menuItem(Name: "Address To:")
    let replly = menuItem(Name: "Reply Received:")

    
    let Address1 = menuItem(Name: "Address :")
    let Hamlet = menuItem(Name: "Hamlet :")
    let District = menuItem(Name: "District :")
    let mandal = menuItem(Name: "Mandal :")
    let village = menuItem(Name: "Village :")

    let Remarks = menuItem(Name: "Remarks")
    
    
    var section1DetilsArray : [menuItem]!
    var section2DetilsArray : [menuItem]!
    var section3DetilsArray : [menuItem]!
    var section4DetilsArray : [menuItem]!
    var section5DetilsArray : [menuItem]!



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
        self.title = "Letters and Notes"
        

        section1 = [lonno,Date,category,status]
        section2 = [Referencedby,Referencephone,fileLOcation]
        section3 = [pettioner,pettionerName,pettionerPhone,subject]
        section4 = [department,dispatch,addresto,replly]
        section5 = [Address1,Hamlet,District,mandal,village]
        section6 = [Remarks]
        
        self.section1DetilsArray = []
        self.section2DetilsArray = []
        self.section3DetilsArray = []
        self.section4DetilsArray = []
        self.section5DetilsArray = []


        
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
        tableview.estimatedRowHeight = 60

        UserManager.getLoggedUserInfo()
        self.getCategoryData()


    }
    
    
    func getCategoryData()
    {
        
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }
        let userID :String = "\(eachBlog?.serialNo ?? 0)"
        
        let catUrl : String  =  myHelper.letterDetails + userID
        let activityView = MyActivityView()
        activityView.displayLoader()
        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(catUrl, parameters) { (urlData) in
            activityView.dismissLoader()
            do {
                let rootDicnew = try JSONDecoder().decode(LetterDetailsModel.self, from: urlData)
                self.letterModekObj = rootDicnew
                if self.letterModekObj != nil {
                    
                    
                    let lonno = menuItem(Name: rootDicnew.letter.lonNo ?? "")
                    
                    var createDateObj:String  = ""
                    if let dateStr = rootDicnew.letter.createDate {
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        let date: Date? = dateFormatterGet.date(from: dateStr)
                        createDateObj = dateFormatter.string(from: date!)
                    }
                    
                    let Date = menuItem(Name: createDateObj)
                    let category = menuItem(Name: rootDicnew.letter.type ?? "")
                    let status = menuItem(Name: rootDicnew.letter.status ?? "")
                    self.section1DetilsArray = [lonno,Date,category,status]
            

                    let Referencedby = menuItem(Name: rootDicnew.letter.referenceName ?? "")
                    let Referencephone = menuItem(Name: rootDicnew.letter.referenceMobile ?? "")
                    let fileLOcation = menuItem(Name: rootDicnew.letter.location ?? "")
                    self.section2DetilsArray = [Referencedby,Referencephone,fileLOcation]

                    
                    let pettioner = menuItem(Name: rootDicnew.letter.petitionerPosition ?? "")
                    let pettionerName = menuItem(Name: rootDicnew.letter.petitionerName ?? "")
                    let pettionerPhone = menuItem(Name: rootDicnew.letter.petitionerMobile ?? "")
                    let subject = menuItem(Name: rootDicnew.letter.petitionDetails ?? "")
                    self.section3DetilsArray = [pettioner,pettionerName,pettionerPhone,subject]

                    
                    let department = menuItem(Name: rootDicnew.letter.department ?? "")
                    let dispatch = menuItem(Name: rootDicnew.letter.dispatchMode ?? "")
                    let addresto = menuItem(Name: rootDicnew.letter.sentToOfficer ?? "")
                    let replly = menuItem(Name: rootDicnew.letter.replyRecieved ?? "")
                    self.section4DetilsArray = [department,dispatch,addresto,replly]

                    let Address1 = menuItem(Name: rootDicnew.letter.address ?? "")
                    let Hamlet = menuItem(Name: rootDicnew.letter.hamlet ?? "")
                    let District = menuItem(Name: rootDicnew.letter.district ?? "")
                    let mandal = menuItem(Name: rootDicnew.letter.mandal ?? "")
                    let village = menuItem(Name: rootDicnew.letter.village ?? "")
                    self.section5DetilsArray = [Address1,Hamlet,District,mandal,village]
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                    
                }else{
                    self.view.makeToast("No Results Found")
                }
                
            } catch (let error) {
                activityView.dismissLoader()
                do {
                    self.view.makeToast("View Letters and Notes - 409")
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



extension LetterDetilsVC: UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section1.count
        }else if section == 1{
            return section2.count
        }
        else if section == 2
        {
            return section3.count
        }
        else if section == 3
        {
            return section4.count
        }
        else if section == 4
        {
            return section5.count
        }
        else {
            if self.letterModekObj != nil {
                return section6.count
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
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.selectionStyle = .none
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
                cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
            }
            if indexPath.row == 3 {
                cell.gtitleDescription.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            }
            
            
            
            
            return cell
            
        }else if indexPath.section == 1 {
            items = section2
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.selectionStyle = .none
            cell.gtitleDescription.text = ""
            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section2DetilsArray.count > 0 {
                let theMenuItemDescription = self.section2DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            if indexPath.row == 3 {
                cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
            }
            
            if self.letterModekObj != nil {
                if indexPath.row == 1 {
                    let attributedString = NSAttributedString(string: cell.gtitleDescription.text ?? "", attributes:[
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1),
                        NSAttributedString.Key.underlineStyle:1.0
                    ])
                    cell.gtitleDescription.attributedText = attributedString
                    cell.descButton.menuObjName = cell.gtitleDescription.text
                    cell.descButton.addTarget(self, action: #selector(contactAction(sender:)), for: .touchUpInside)
                }
            }
            
            
            return cell
        }else if indexPath.section == 2 {
            items = section3
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.selectionStyle = .none
            cell.gtitleDescription.text = ""
            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section3DetilsArray.count > 0 {
                let theMenuItemDescription = self.section3DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            
            if self.letterModekObj != nil {
                if indexPath.row == 2 {
                    let attributedString = NSAttributedString(string: cell.gtitleDescription.text ?? "", attributes:[
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1),
                        NSAttributedString.Key.underlineStyle:1.0
                    ])
                    cell.gtitleDescription.attributedText = attributedString
                    cell.descButton.menuObjName = cell.gtitleDescription.text
                    cell.descButton.addTarget(self, action: #selector(contactAction(sender:)), for: .touchUpInside)
                }
            }
            
            return cell
        }
        else if indexPath.section == 3 {
            items = section4
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.selectionStyle = .none
            cell.gtitleDescription.text = ""
            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section4DetilsArray.count > 0 {
                let theMenuItemDescription = self.section4DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            
            
            return cell
        }
        else if indexPath.section == 4 {
            items = section5
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.selectionStyle = .none
            cell.gtitleDescription.text = ""
            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section5DetilsArray.count > 0 {
                let theMenuItemDescription = self.section5DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            
            
            
            return cell
        }
        
        else if indexPath.section == 5 {
            items = section6
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextButtonCell", for: indexPath) as! TextButtonCell
            cell.textView.textColor = UIColor.black
            cell.selectionStyle = .none
            
            if self.letterModekObj != nil {
                cell.textView.text = self.letterModekObj?.letter.remarks ?? ""
                if (self.letterModekObj?.uploadedFiles?.count)! > 0 {
                    cell.shadowView.isHidden = false
                    let uploadFileInfo = self.letterModekObj?.uploadedFiles?.first
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
            
            if cell.textView.text.isEmpty || cell.textView.text == "Remarks" {
                cell.textView.text = "Remarks"
                cell.textView.textColor = UIColor.lightGray
            }
            return cell
        }
        
        return cell
    }
    
    
    @objc func contactAction(sender:DataButton){
        guard let dailNumber = sender.menuObjName else { return }
        dialNumber(number: dailNumber)
    }

    @objc func navigateAcion(sender:DataButton){
        guard let dailNumber = sender.menuObjName else { return }
        if let url = URL(string: dailNumber) {
            UIApplication.shared.open(url)
        }
    }
    
    func dialNumber(number : String) {
     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }
    

    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0  || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 {
            
            if indexPath.section == 2 && indexPath.row == 1 {
                return UITableView.automaticDimension
            }
            if indexPath.section == 2 && indexPath.row == 3 {
                return UITableView.automaticDimension
            }
            if indexPath.section == 3 && indexPath.row == 2 {
                return UITableView.automaticDimension
            }
            
            return 60
        }
        if indexPath.section == 5 {
            if self.letterModekObj != nil {
                if (self.letterModekObj?.uploadedFiles?.count)! > 0 {
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
            
            return "Letters - Status"
            
        }else if section == 1{
            
            return "Reference Info"
        }
        else if section == 2
        {
            return "Pettition Info"
        }
        else if section == 3
        {
            return "Ltter / Notes / DO Letter Details"
        }
        else if section == 4
        {
            return "Address"
        }
        else {
            return "Remarks"
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
   
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.MyWall.appColor
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }

    

    
}




// MARK: - LetterDetailsModel
struct LetterDetailsModel: Codable {
    let letter: Letter
    let remarks: [JSONAny]
    let districts: [District]
    let mandals: [Mandal]
    let villages: [Village]
    let activities: [Activity]
    let uploadedFiles: [UploadedFileLetterArray]?
    let attachments: [JSONAny]
    let serialNoIdx: Int
}

// MARK: - Activity
struct Activity: Codable {
    let id, actCode, activityDescription, actTime: String?
    let actUserID: String?
    let grievanceID, employeeID, userID, contactID: String?
    let organizationID, policiesID, rolesID, reimbursementID: String?
    let locID, peshiFilesID, endorsementID: String?
    let lettersID: String?

    enum CodingKeys: String, CodingKey {
        case id, actCode
        case activityDescription = "description"
        case actTime
        case actUserID = "actUserId"
        case grievanceID = "grievanceId"
        case employeeID = "employeeId"
        case userID = "userId"
        case contactID = "contactId"
        case organizationID = "organizationId"
        case policiesID = "policiesId"
        case rolesID = "rolesId"
        case reimbursementID = "reimbursementId"
        case locID = "locId"
        case peshiFilesID = "peshiFilesId"
        case endorsementID = "endorsementId"
        case lettersID = "lettersId"
    }
}

// MARK: - Letter
struct Letter: Codable {
    let id: String?
    let serialNo: Int?
    let type, lonNo, createDate, petitionerPosition: String?
    let petitionerName: String?
    let petitionerPortFolio, constituency: String?
    let petitionerMobile, referenceName, referenceMobile, petitionDetails: String?
    let department, sentToOfficer, status: String?
    let location: String?
    let address, hamlet, village, mandal: String?
    let district: String?
    let recievedDate: String?
    let dispatchMode, dispatchedDate, remarks, replyRecieved: String?
}



// MARK: - UploadedFile
struct UploadedFileLetterArray: Codable {
    let id, fileName: String
    let filePath: String
    let uploadedDate, userName, tgID: String

    enum CodingKeys: String, CodingKey {
        case id, fileName, filePath, uploadedDate, userName
        case tgID = "tgId"
    }
}

