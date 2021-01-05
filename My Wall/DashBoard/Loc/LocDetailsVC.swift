//
//  LocDetailsVC.swift
//  My Wall
//
//  Created by surendra on 09/12/20.
//

import UIKit

class LocDetailsVC: UIViewController {

    var dashBoardType : DashBoardType = .Grievances
    var eachBlog : ReimbrusementModelElement? = nil
    var ReimbursementObj : LOCDetailsModel? = nil

    
    var section1 : [menuItem]!
    var section2 : [menuItem]!
    var section3 : [menuItem]!
    var section4 : [menuItem]!
    var section5 : [menuItem]!
    var section6 : [menuItem]!
    var section7 : [menuItem]!

    
    var section1DetilsArray : [menuItem]!
    var section2DetilsArray : [menuItem]!
    var section3DetilsArray : [menuItem]!
    var section4DetilsArray : [menuItem]!
    var section5DetilsArray : [menuItem]!

    

    
    let File = menuItem(Name: "File :")
    let Date = menuItem(Name: "Date :")
    let status = menuItem(Name: "Status :")
    
    let Referencedby = menuItem(Name: "Referenced by :")
    let personPhone = menuItem(Name: "Reference Phone :")
    
    
    let Applicant = menuItem(Name: "Applicant Name :")
    let Relation = menuItem(Name: "Relation :")
    let Sex = menuItem(Name: "Sex :")
    let age = menuItem(Name: "Age :")
    let Phone = menuItem(Name: "Phone :")
    let Aadhar = menuItem(Name: "Aadhar :")
    
    let Probblem = menuItem(Name: "Probblem :")
    let Hospital = menuItem(Name: "Hospital :")
    let Address = menuItem(Name: "Address :")
    let Amount = menuItem(Name: "Amount :")

    
    let Address1 = menuItem(Name: "Address :")
    let Hamlet = menuItem(Name: "Hamlet :")
    let District = menuItem(Name: "District :")
    let mandal = menuItem(Name: "Mandal :")
    let village = menuItem(Name: "Village :")


    let Sanction = menuItem(Name: "Sanction Details")

    let Remarks = menuItem(Name: "Remarks")
    
    


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
        
//        self.ConfigureNavBar()
        self.ConfigureNavBarDetils()

        
        if self.dashBoardType == .Reimbursement {
            self.title = "Reimbrusement"
        }
        
        if self.dashBoardType == .LOC {
            self.title = "Loc"
        }
        
        section1 = [File,Date,status]
        section2 = [Referencedby,personPhone]
        section3 = [Applicant,Relation,Sex,age,Phone,Aadhar]
        section4 = [Probblem,Hospital,Address,Amount]
        section5 = [Address1,Hamlet,District,mandal,village]
        section6 = [Sanction]
        section7 = [Remarks]

        
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

        let nibName3 = UINib(nibName: "SectionCell", bundle:nil)
        tableview.register(nibName3, forCellReuseIdentifier: "SectionCell")

        
        
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
//        guard let userName:String = UserManager.sharedInstance.currentUserInfomation?.user.username else {
//            return
//        }
        guard let userID :String = eachBlog?.fileNo else {
            return
        }
        
         var catUrl : String = ""
    
        if self.dashBoardType == .LOC {
             catUrl  =  myHelper.reimbursementDetails + userID + "/" + "LOC"
        }
        
        let activityView = MyActivityView()
        activityView.displayLoader()
        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(catUrl, parameters) { (urlData) in
            activityView.dismissLoader()
            do {
                let rootDicnew = try JSONDecoder().decode(LOCDetailsModel.self, from: urlData)
                self.ReimbursementObj = rootDicnew
                if rootDicnew.reimbursement.fileNo!.count > 0 {
                    
                    let File = menuItem(Name: rootDicnew.reimbursement.fileNo ?? "" )
                    let Date = menuItem(Name: rootDicnew.reimbursement.date ?? "" )
                    let status = menuItem(Name: rootDicnew.reimbursement.status ?? "")
                    self.section1DetilsArray = [File,Date,status]
                    
                    let Referencedby = menuItem(Name: rootDicnew.reimbursement.refBy ?? "")
                    let personPhone = menuItem(Name: rootDicnew.reimbursement.refPhone ?? "")
                    self.section2DetilsArray = [Referencedby,personPhone]
                    
                    let Applicant = menuItem(Name: rootDicnew.reimbursement.patientName ?? "")
                    let Relation = menuItem(Name: rootDicnew.reimbursement.relativeName ?? "")
                    let Sex = menuItem(Name: rootDicnew.reimbursement.sex ?? "")
                    let age = menuItem(Name: rootDicnew.reimbursement.age ?? "")
                    let Phone = menuItem(Name: rootDicnew.reimbursement.pPhone ?? "")
                    let Aadhar = menuItem(Name: rootDicnew.reimbursement.aadhar ?? "")
                    self.section3DetilsArray = [Applicant,Relation,Sex,age,Phone,Aadhar]
                    
                    
                    let Probblem = menuItem(Name: rootDicnew.reimbursement.desease ?? "")
                    let Hospital = menuItem(Name: rootDicnew.reimbursement.hospitalName ?? "")
                    let Address = menuItem(Name: rootDicnew.reimbursement.hospAddress ?? "")
                    let Amount = menuItem(Name: "\(rootDicnew.reimbursement.treatmentAmount)")
                    self.section4DetilsArray = [Probblem,Hospital,Address,Amount]
                    
                    let Address1 = menuItem(Name: rootDicnew.reimbursement.pAddress ?? "")
                    let Hamlet = menuItem(Name: rootDicnew.reimbursement.hamlet ?? "")
                    let District = menuItem(Name: rootDicnew.reimbursement.district ?? "")
                    let mandal = menuItem(Name: rootDicnew.reimbursement.mandal ?? "")
                    let village = menuItem(Name: rootDicnew.reimbursement.village ?? "")
                    self.section5DetilsArray = [Address1,Hamlet,District,mandal,village]
                    
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


    

    func ConfigureNavBar(){
        navigationController?.navigationBar.barTintColor = UIColor.MyWall.appColor
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc func backAction () {
        self.dismiss(animated: true, completion: nil)
    }

}

extension LocDetailsVC: UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
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
        else if section == 5
        {
            return self.ReimbursementObj?.sanctionedDetails.count ?? 0
        }
        else {
            if self.ReimbursementObj != nil {
                return section7.count
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

            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            cell.selectionStyle = .none

            if self.section1DetilsArray.count > 0 {
                let theMenuItemDescription = self.section1DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            

            if indexPath.row == 2 {
                cell.gtitleDescription.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            }
            if  indexPath.row == 0 {
                cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
            }
            return cell


        }else if indexPath.section == 1 {
            items = section2
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.gtitleDescription.attributedText = NSAttributedString()

            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            cell.selectionStyle = .none
            if self.section2DetilsArray.count > 0 {
                let theMenuItemDescription = self.section2DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }

            return cell
        }else if indexPath.section == 2 {
            items = section3
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            cell.selectionStyle = .none

            if self.section3DetilsArray.count > 0 {
                let theMenuItemDescription = self.section3DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }

            if self.ReimbursementObj != nil {
                if theMenuItem.Name == "Phone :" {
                    let attributedString = NSAttributedString(string: cell.gtitleDescription.text ?? "", attributes:[
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1),
                        NSAttributedString.Key.underlineStyle:1.0
                    ])
                    cell.gtitleDescription.attributedText = attributedString
                    cell.descButton.menuObjName = cell.gtitleDescription.text
                    cell.descButton.addTarget(self, action: #selector(contactAction(sender:)), for: .touchUpInside)
                }
                
                if indexPath.row == 1 {
                    var relativeNameObj : String =  ""
                    if (eachBlog?.relation != nil) && (eachBlog?.relation != "null")  {
                        relativeNameObj = "\(eachBlog?.relation ?? "")" + " " + "\(eachBlog?.relativeName ?? "")"
                    }else{
                        relativeNameObj = eachBlog?.relativeName ?? ""
                    }
                    cell.gtitleDescription.text = relativeNameObj

                }
            }

            return cell
        }
        else if indexPath.section == 3 {
            items = section4
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            cell.selectionStyle = .none
            if self.section4DetilsArray.count > 0 {
                let theMenuItemDescription = self.section4DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            
            if self.ReimbursementObj != nil {
                if theMenuItem.Name == "Amount :" {
                    if cell.gtitleDescription.text != "" {
                        let Amount = cell.gtitleDescription.text! + ".0 /-"
                        let attributedString = NSAttributedString(string: Amount , attributes:[
                            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1),
                            NSAttributedString.Key.underlineStyle:1.0
                        ])
                        cell.gtitleDescription.attributedText = attributedString
                        cell.descButton.menuObjName = cell.gtitleDescription.text
                        // cell.descButton.addTarget(self, action: #selector(contactAction(sender:)), for: .touchUpInside)
                    }
                }
            }

            return cell
        }
        else if indexPath.section == 4 {
            items = section5
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            cell.selectionStyle = .none
            if self.section5DetilsArray.count > 0 {
                let theMenuItemDescription = self.section5DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }

            return cell
        }
        
        else if indexPath.section == 5 {
            items = section6
            let sanctionObj  = self.ReimbursementObj?.sanctionedDetails[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SectionCell
            cell.selectionStyle = .none
            cell.wallNumberDesc.text = sanctionObj?.sanctionedNo
            cell.wallCheckLabelDesc.text = sanctionObj?.chequeNo
            cell.wallAmountLabelDesc.text = "\(sanctionObj?.sanctionedAmt ?? 0)"
            cell.wallTypeLabelDesc.text = sanctionObj?.additionalFund
            cell.wallDateLabelDesc.text = sanctionObj?.sanctionedDate
            cell.wallRemarksDesc.text = sanctionObj?.sanctionRemarks
            return cell
        }
        else if indexPath.section == 6 {
            items = section7
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextButtonCell", for: indexPath) as! TextButtonCell
            cell.textView.textColor = UIColor.black
            cell.selectionStyle = .none
            
            if self.ReimbursementObj != nil {
                cell.textView.text = self.ReimbursementObj?.reimbursement.remarks

                if (self.ReimbursementObj?.uploadedFiles?.count)! > 0 {
                    cell.shadowView.isHidden = false
                    let uploadFileInfo = self.ReimbursementObj?.uploadedFiles?.first
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
            return 60
        }
        if indexPath.section == 5
        {
            return 100
        }
        if indexPath.section == 6
        {
            if self.ReimbursementObj != nil {
                if (self.ReimbursementObj?.uploadedFiles?.count)! > 0 {
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
            
            return "CMRF - Entry"
            
        }else if section == 1{
            
            return "Reference Info"
        }
        else if section == 2
        {
            return "Applicant Info"
        }
        else if section == 3
        {
            return "Technical Info"
        }
        else if section == 4
        {
            return "Address"
        }
        else if section == 5
        {
            return "Sanctioned Details"
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








struct LOCDetailsModel: Codable {
    let reimbursement: ReimbursementModel
    let sanctionedDetails: [SanctionedDetailModel]
    let statuses: [StatusModel]
    let districts: [DistrictModel]
    let mandals: [MandalModel]
    let villages: [VillageModel]
    let fileIdxNo: Int
    let uploadedFiles: [UploadedFileModel]?
    let sanctionedFiles, cmrfRemarks: [JSONAny]
}

// MARK: - District
struct DistrictModel : Codable {
    let id: Int
    let districtName: String
}

// MARK: - Mandal
struct MandalModel: Codable {
    let id: Int
    let mandalName: String
}

// MARK: - Reimbursement
struct ReimbursementModel: Codable {
    let id, fileNo, cmrfType, status: String?
    let date: String?
    let applicationDate: String?
    let refBy: String?
    let refPhone: String?
    let salutation, patientName, sex, relation: String?
    let relativeName, pPhone: String?
    let altPhone, aadhar: String?
    let age: String?
    let pAddress, hamlet: String?
    let village, mandal, district, state: String?
    let country, pincode: String?
    let desease, hospitalName, hospAddress: String?
    let additionalRequest: Bool?
    let previousSanctionedAmt: Int?
    let previousAmtInWords: String?
    let treatmentAmount: Int
    let amtInWords, peshiLrNo: String?
    let peshiDate, remarks, signedDate, fileLocation: String?
}

// MARK: - SanctionedDetail
struct SanctionedDetailModel: Codable {
    let id: String
    let sanctionedAmt: Int
    let sactinedAmtInWords, sanctionedDate, sanctionedNo: String
    let chequeNo: String?
    let chequeDate: String
    let sanctionRemarks: String?
    let additionalFund, cmrfObjID: String

    enum CodingKeys: String, CodingKey {
        case id, sanctionedAmt, sactinedAmtInWords, sanctionedDate, sanctionedNo, chequeNo, chequeDate, sanctionRemarks, additionalFund
        case cmrfObjID = "cmrfObjId"
    }
}

// MARK: - Status
struct StatusModel: Codable {
    let id, listName, listItem: String
    let status: String?
}

// MARK: - UploadedFile
struct UploadedFileModel: Codable {
    let id, fileName: String
    let filePath: String
    let uploadedDate, userName, tgID: String

    enum CodingKeys: String, CodingKey {
        case id, fileName, filePath, uploadedDate, userName
        case tgID = "tgId"
    }
}

// MARK: - Village
struct VillageModel: Codable {
    let id: Int
    let villageName: String
}
