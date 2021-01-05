//
//  GreivanceDetailsVC.swift
//  My Wall
//
//  Created by surendra on 05/12/20.
//

import UIKit


struct menuItem: Codable {
    let Name : String
}

class GreivanceDetailsVC: UIViewController {

    var section1 : [menuItem]!
    var section2 : [menuItem]!
    var section3 : [menuItem]!
    var section4 : [menuItem]!
    var section5 : [menuItem]!
    var eachBlog : CategoryModelElement? = nil
    var grievienceObj : GrivianceDetailsModelObject? = nil

    
    var section1DetilsArray : [menuItem]!
    var section2DetilsArray : [menuItem]!
    var section3DetilsArray : [menuItem]!


    
    let grievance = menuItem(Name: "Grievance :")
    let titleObj = menuItem(Name: "Title :")
    let status = menuItem(Name: "Status :")
    let date = menuItem(Name: "Date :")
    let source = menuItem(Name: "Source :")
    let organization = menuItem(Name: "Organization :")
    let assigntedto = menuItem(Name: "Assigned To :")
    let gistofcase = menuItem(Name: "Gist Of Case :")

    
    let person = menuItem(Name: "Person :")
    let personPhone = menuItem(Name: "Person Phone :")
    let relationTo = menuItem(Name: "Relation To :")
    let contactName = menuItem(Name: "Contact Name :")
    let contactPhone = menuItem(Name: "Contact Phone :")
    let twitterLink = menuItem(Name: "Twitter Link :")
    let emailID = menuItem(Name: "Email Id :")

    let address = menuItem(Name: "Address :")
    let hamlet = menuItem(Name: "Hamlet :")
    let district = menuItem(Name: "District :")
    let mandal = menuItem(Name: "Mandal :")
    let village = menuItem(Name: "Village :")
    
    let solution = menuItem(Name: "Solution")
    let minTwwet = menuItem(Name: "Minister Tweet")


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
        
        self.title = "Grivience"
        self.ConfigureNavBarDetils()
//        self.ConfigureNavBar()

        section1 = [grievance,titleObj,status,date,source,organization,assigntedto,gistofcase]
        section2 = [person,personPhone,relationTo,contactName,contactPhone,twitterLink,emailID]
        section3 = [address,hamlet,district,mandal,village]
        section4 = [solution]
        section5 = [address]
        
        self.section1DetilsArray = []
        self.section2DetilsArray = []
        self.section3DetilsArray = []


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
        guard let userName:String = UserManager.sharedInstance.currentUserInfomation?.user.username else {
            return
        }
        
        guard let userID :String = eachBlog?.tgID else {
            return
        }
        
        let catUrl : String =  myHelper.grievanceaDetails + userID + "/" + userName
        
        let activityView = MyActivityView()
        activityView.displayLoader()
        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(catUrl, parameters) { (urlData) in
            activityView.dismissLoader()
            do {
                let rootDicnew = try JSONDecoder().decode(GrivianceDetailsModelObject.self, from: urlData)
                self.grievienceObj = rootDicnew
                if rootDicnew.twitterGrievance.tgID!.count > 0 {
                    
                    let grievance = menuItem(Name:self.grievienceObj?.twitterGrievance.tgID ?? "" )
                    let titleObj = menuItem(Name: self.grievienceObj?.twitterGrievance.title ?? "")
                    let status = menuItem(Name: self.grievienceObj?.twitterGrievance.status ?? "")
                    let date = menuItem(Name: self.grievienceObj?.twitterGrievance.tweetTime ?? "")
                    let source = menuItem(Name: self.grievienceObj?.twitterGrievance.source ?? "")
                    let organization = menuItem(Name: self.grievienceObj?.twitterGrievance.orgName ?? "")
                    let assigntedto = menuItem(Name: self.grievienceObj?.twitterGrievance.assignedTo ?? "")
                    let gistofcase = menuItem(Name: self.grievienceObj?.twitterGrievance.gistOfCase ?? "")

                    self.section1DetilsArray = [grievance,titleObj,status,date,source,organization,assigntedto,gistofcase]
                    

                    let person = menuItem(Name: self.grievienceObj?.twitterGrievance.person ?? "")
                    let personPhone = menuItem(Name: self.grievienceObj?.twitterGrievance.personPhone ?? "")
                    let relationTo = menuItem(Name: self.grievienceObj?.twitterGrievance.relationToContact ?? "")
                    let contactName = menuItem(Name: self.grievienceObj?.twitterGrievance.contactName ?? "")
                    let contactPhone = menuItem(Name: self.grievienceObj?.twitterGrievance.contactNo ?? "")
                    let twitterLink = menuItem(Name: self.grievienceObj?.twitterGrievance.twitterLink ?? "")
                    let emailID = menuItem(Name: self.grievienceObj?.twitterGrievance.contactEmail ?? "")

                    self.section2DetilsArray = [person,personPhone,relationTo,contactName,contactPhone,twitterLink,emailID]
                    
                    
                    let address = menuItem(Name: self.grievienceObj?.twitterGrievance.address ?? "")
                    let hamlet = menuItem(Name: self.grievienceObj?.twitterGrievance.hamlet ?? "")
                    let district = menuItem(Name: self.grievienceObj?.twitterGrievance.district ?? "")
                    let mandal = menuItem(Name: self.grievienceObj?.twitterGrievance.mandal ?? "")
                    let village = menuItem(Name: self.grievienceObj?.twitterGrievance.village ?? "")
                    self.section3DetilsArray = [address,hamlet,district,mandal,village]

                    
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }else{
                    self.view.makeToast("No Results Found")
                }
            } catch (let error) {
                activityView.dismissLoader()
                do {
                    let errorModel = try JSONDecoder().decode(ErrorModel.self, from: urlData)
                    self.view.makeToast("View Grievance - 409")
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


extension GreivanceDetailsVC: UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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
        else {
            return section5.count
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
            if self.section1DetilsArray.count > 0 {
                let theMenuItemDescription = self.section1DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            cell.selectionStyle = .none
            if theMenuItem.Name.contains("Grievance") {
                cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
            }
            if theMenuItem.Name.contains("Status") {
                cell.gtitleDescription.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                cell.gtitleDescription.font = UIFont(name:"HelveticaNeue-Bold", size: 14)
            }
            return cell


        }else if indexPath.section == 1 {
            items = section2
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section2DetilsArray.count > 0 {
                let theMenuItemDescription = self.section2DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            cell.selectionStyle = .none
            if theMenuItem.Name.contains("Person Phone") {
                let attributedString = NSAttributedString(string: cell.gtitleDescription.text ?? "", attributes:[
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                    NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1),
                    NSAttributedString.Key.underlineStyle:1.0
                ])
                cell.gtitleDescription.attributedText = attributedString
                cell.descButton.menuObjName = cell.gtitleDescription.text
                cell.descButton.addTarget(self, action: #selector(contactAction(sender:)), for: .touchUpInside)
            }
            if theMenuItem.Name.contains("Contact Phone") {
                let attributedString = NSAttributedString(string: cell.gtitleDescription.text ?? "", attributes:[
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                    NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1),
                    NSAttributedString.Key.underlineStyle:1.0
                ])
                cell.gtitleDescription.attributedText = attributedString
                cell.descButton.menuObjName = cell.gtitleDescription.text
                cell.descButton.addTarget(self, action: #selector(contactAction(sender:)), for: .touchUpInside)
            }
            
            if indexPath.row == 5 {
                let attributedString = NSAttributedString(string: cell.gtitleDescription.text ?? "", attributes:[
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                    NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1),
                    NSAttributedString.Key.underlineStyle:1.0
                ])
                cell.gtitleDescription.attributedText = attributedString
                cell.descButton.menuObjName = cell.gtitleDescription.text
                cell.descButton.addTarget(self, action: #selector(navigateAcion(sender:)), for: .touchUpInside)
            }
            

            return cell
        }else if indexPath.section == 2 {
            items = section3
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            
            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section3DetilsArray.count > 0 {
                let theMenuItemDescription = self.section3DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            cell.selectionStyle = .none

            return cell
        }
        else if indexPath.section == 3 {
            items = section4
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewTableViewCell", for: indexPath) as! TextViewTableViewCell

            cell.textView.text = self.grievienceObj?.twitterGrievance.resolution
            cell.textView.textColor = UIColor.black
            if cell.textView.text.isEmpty {
                cell.textView.text = "Solution"
                cell.textView.textColor = UIColor.lightGray
            }
            cell.selectionStyle = .none
            return cell

        }
        else if indexPath.section == 4 {
            items = section5
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextButtonCell", for: indexPath) as! TextButtonCell
            cell.shadowView.isHidden = true
            cell.textView.textColor = UIColor.black
            
            if self.grievienceObj != nil {
                cell.textView.text = self.grievienceObj?.twitterGrievance.ministerTweet
                cell.selectionStyle = .none
                if (self.grievienceObj?.uploadedFiles?.count)! > 0 {
                    cell.shadowView.isHidden = false
                    let uploadFileInfo = self.grievienceObj?.uploadedFiles?.first
                    let attributedString = NSAttributedString(string: uploadFileInfo?.fileName ?? "", attributes:[
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                        NSAttributedString.Key.foregroundColor : UIColor.blue,
                        NSAttributedString.Key.underlineStyle:1.0
                    ])
                    cell.shadowButton.setAttributedTitle(attributedString, for: .normal)
                    let UrlString = uploadFileInfo!.filePath + uploadFileInfo!.fileName
                    cell.shadowButton.menuObjName = UrlString
                    cell.shadowButton.addTarget(self, action: #selector(navigateAcion(sender:)), for: .touchUpInside)
                }else{
                    cell.shadowView.isHidden = true
                }
            }
            
            if cell.textView.text.isEmpty {
                cell.textView.text = "Minister Tweet"
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
    
    
    @objc func navigateAcion(sender:DataButton){
        guard let dailNumber = sender.menuObjName else { return }
        if let url = URL(string: dailNumber) {
            UIApplication.shared.open(url)
        }
    }

  

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0  || indexPath.section == 1 || indexPath.section == 2 {
            
            if indexPath.section == 0 && indexPath.row == 7 {
                return UITableView.automaticDimension
            }
            
            if indexPath.section == 1 && indexPath.row == 5 {
                return UITableView.automaticDimension
            }

            return 60
        }
        if indexPath.section == 3
        {
            return 100
        }
        if indexPath.section == 4
        {
            if self.grievienceObj != nil {
                if (self.grievienceObj?.uploadedFiles?.count)! > 0 {
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
            return "Grievances - Status"
        }else if section == 1{
            return "Contact Info"
        }
        else if section == 2
        {
            return "Address"
        }
        else if section == 3
        {
            return "Solution"
        }
        else {
            return "Minister Tweet"
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
   
    
    
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        if indexPath.section == 0  || indexPath.section == 1 || indexPath.section == 2 {
//            return UITableView.automaticDimension
//        }
//        if indexPath.section == 3
//        {
//            return 100
//        }
//        if indexPath.section == 4
//        {
//            return 160
//        }
//
//        return 50
//
//    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.MyWall.appColor
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }

    

    
}




/*

struct GrivianceDetailsModelObject: Codable {
    let twitterGrievance: TwitterGrievance
    let states: [StateArray]
    let stateDistrisctList: [StateDistrisctList]
    let grievanceNotesList: [JSONAny]
    let distMandalsList: [DistMandalsList]
    let mandalVillagesList: [MandalVillagesList]
    let orgList: [[String: String?]]
    let statusList, sourceList: [List]
    let grivAct: [GrivAct]
    let assignedToList: [AssignedToList]
    let uploadedFiles: [UploadedFile]?
    let username: String
}

// MARK: - AssignedToList
struct AssignedToList: Codable {
    let id: Int
    let assignedTo: String
}

// MARK: - DistMandalsList
struct DistMandalsList: Codable {
    let id: Int
    let mandalName: String
}

// MARK: - GrivAct
struct GrivAct: Codable {
    let id, actCode, grivActDescription, actTime: String?
    let actUserID, grievanceID: String?
    let employeeID, userID, contactID, organizationID: JSONAny?
    let policiesID, rolesID, reimbursementID, locID: JSONAny?
    let peshiFilesID, endorsementID, lettersID: JSONAny?

    enum CodingKeys: String, CodingKey {
        case id, actCode
        case grivActDescription = "description"
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

// MARK: - MandalVillagesList
struct MandalVillagesList: Codable {
    let id: Int
    let villageName: String
}

// MARK: - List
struct List: Codable {
    let id: String
    let listName: ListName
    let listItem: String
    let status: JSONNull?
}

enum ListName: String, Codable {
    case grievanceStatus = "GRIEVANCE STATUS"
    case source = "SOURCE"
}

// MARK: - StateDistrisctList
struct StateDistrisctList: Codable {
    let id: Int
    let districtName: String
}

// MARK: - State
struct StateArray: Codable {
    let id: Int
    let stateName: String
}

// MARK: - TwitterGrievance
struct TwitterGrievance: Codable {
    let id, tgID, orgName, title: String?
    let tweetID, tweetDesc, desc, createDate: String?
    let orginatorName, twitterLink, assignedTo, status: String?
    let tweetTime, person, personPhone, relationToContact: String?
    let contactName, contactNo: String?
    let contractTID: JSONAny?
    let contactEmail, gistOfCase, address: String?
    let hamlet: String?
    let village, mandal, district, state: String?
    let country, pincode, source, document: String?
    let ministerTweet: String?
    let minTweetTime: JSONAny?
    let createdBy, resolution, contactID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case tgID = "tgId"
        case orgName, title
        case tweetID = "tweetId"
        case tweetDesc, desc, createDate, orginatorName, twitterLink, assignedTo, status, tweetTime, person, personPhone, relationToContact, contactName, contactNo
        case contractTID = "contractTId"
        case contactEmail, gistOfCase, address, hamlet, village, mandal, district, state, country, pincode, source, document, ministerTweet, minTweetTime, createdBy, resolution
        case contactID = "contactId"
    }
}

// MARK: - UploadedFile
struct UploadedFile: Codable {
    let id, fileName: String
    let filePath: String
    let uploadedDate, userName, tgID: String

    enum CodingKeys: String, CodingKey {
        case id, fileName, filePath, uploadedDate, userName
        case tgID = "tgId"
    }
}

*/
struct GrivianceDetailsModelObject: Codable {
    let twitterGrievance: TwitterGrievance
    let states: [StateArray]
    let stateDistrisctList: [StateDistrisctList]
    let grievanceNotesList: [JSONAny]
    let distMandalsList: [DistMandalsList]
    let mandalVillagesList: [JSONAny]
    let orgList: [[String: String?]]
    let statusList, sourceList: [List]
    let grivAct: [GrivAct]
    let assignedToList: [AssignedToList]
    let uploadedFiles: [UploadedFile]?
    let username: String
}

// MARK: - AssignedToList
struct AssignedToList: Codable {
    let id: Int
    let assignedTo: String
}

// MARK: - DistMandalsList
struct DistMandalsList: Codable {
    let id: Int
    let mandalName: String
}

// MARK: - GrivAct
struct GrivAct: Codable {
    let id, actCode, grivActDescription, actTime: String
    let actUserID, grievanceID: String
    let employeeID, userID, contactID, organizationID: JSONNull?
    let policiesID, rolesID, reimbursementID, locID: JSONNull?
    let peshiFilesID, endorsementID, lettersID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, actCode
        case grivActDescription = "description"
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

// MARK: - List
struct List: Codable {
    let id: String
    let listName: ListName
    let listItem: String
    let status: String?
}

enum ListName: String, Codable {
    case grievanceStatus = "GRIEVANCE STATUS"
    case source = "SOURCE"
}

// MARK: - StateDistrisctList
struct StateDistrisctList: Codable {
    let id: Int
    let districtName: String
}

// MARK: - State
struct StateArray: Codable {
    let id: Int
    let stateName: String
}

// MARK: - TwitterGrievance
struct TwitterGrievance: Codable {
    let id, tgID, orgName, title: String?
    let tweetID, tweetDesc, desc, createDate: String?
    let orginatorName, twitterLink, assignedTo, status: String?
    let tweetTime, person: String?
    let personPhone: String?
    let relationToContact, contactName, contactNo: String?
    let contractTID: String?
    let contactEmail, gistOfCase, address: String?
    let hamlet: String?
    let village, mandal, district, state: String?
    let country, pincode, source, document: String?
    let ministerTweet: String?
    let minTweetTime: String?
    let createdBy, resolution, contactID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case tgID = "tgId"
        case orgName, title
        case tweetID = "tweetId"
        case tweetDesc, desc, createDate, orginatorName, twitterLink, assignedTo, status, tweetTime, person, personPhone, relationToContact, contactName, contactNo
        case contractTID = "contractTId"
        case contactEmail, gistOfCase, address, hamlet, village, mandal, district, state, country, pincode, source, document, ministerTweet, minTweetTime, createdBy, resolution
        case contactID = "contactId"
    }
}

struct UploadedFile: Codable {
    let id, fileName: String
    let filePath: String
    let uploadedDate, userName, tgID: String

    enum CodingKeys: String, CodingKey {
        case id, fileName, filePath, uploadedDate, userName
        case tgID = "tgId"
    }
}
