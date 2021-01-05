//
//  EndorsementDetailsVC.swift
//  My Wall
//
//  Created by surendra on 06/12/20.
//

import UIKit

class EndorsementDetailsVC: UIViewController {

    
    var dashBoardType : DashBoardType = .Endorsement
    var eachBlog : EndorsementDashBoardElement? = nil
    var endorsementModekObj : EndorsementDetailsModel? = nil

    
    
    var section1 : [menuItem]!
    var section2 : [menuItem]!
    var section3 : [menuItem]!
    var section4 : [menuItem]!
    
    
    
    let endorsement = menuItem(Name: "Endorsement :")
    let Date = menuItem(Name: "Date :")
    let status = menuItem(Name: "Status :")
    
    let Referencedby = menuItem(Name: "Referenced by :")
    let Referencephone = menuItem(Name: "Reference Phone :")

    
    let pettioner = menuItem(Name: "Pettitioner Type :")
    let pettionerName = menuItem(Name: "Pettitioner name :")
    let pettionerPhone = menuItem(Name: "Pettitioner Phone :")
    let department = menuItem(Name: "Department :")
    let endorsedOff = menuItem(Name: "Endorsed Officer :")
    let replyreceived = menuItem(Name: "Reply Received :")

    let Address1 = menuItem(Name: "Address :")
    let Hamlet = menuItem(Name: "Hamlet :")
    let District = menuItem(Name: "District :")
    let mandal = menuItem(Name: "Mandal :")
    let village = menuItem(Name: "Village :")
    let pettioneDetails = menuItem(Name: "Pettition Details :")


    var section1DetilsArray : [menuItem]!
    var section2DetilsArray : [menuItem]!
    var section3DetilsArray : [menuItem]!
    var section4DetilsArray : [menuItem]!
    
    var customView = FooterViewWall()

    
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
        self.title = "Update Endorsement"

        section1 = [endorsement,Date,status]
        section2 = [Referencedby,Referencephone]
        section3 = [pettioner,pettionerName,pettionerPhone,department,endorsedOff,replyreceived]
        section4 = [Address1,Hamlet,District,mandal,village,pettioneDetails]

        
        self.section1DetilsArray = []
        self.section2DetilsArray = []
        self.section3DetilsArray = []
        self.section4DetilsArray = []

        
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
        tableview.estimatedRowHeight = 100

        let nibName3 = UINib(nibName: "FooterTableViewCell", bundle:nil)
        tableview.register(nibName3, forCellReuseIdentifier: "FooterTableViewCell")
   
        
        customView = FooterViewWall(frame: CGRect(x: 0, y: 0, width: tableview.frame.width, height: 250))
        tableview.tableFooterView = customView
        customView.cancel.addTarget(self, action: #selector(cancelAcrtion), for: .touchUpInside)
        customView.submit.addTarget(self, action: #selector(UpdateEndorseInfo), for: .touchUpInside)
        
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 60

        UserManager.getLoggedUserInfo()
        self.getCategoryData()


    }
    
    @objc func cancelAcrtion() {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func getCategoryData()
    {
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }
        let userID :String = "\(eachBlog?.serialNo ?? 0)"
        let catUrl : String  =  myHelper.endorsementDetails + userID
        let activityView = MyActivityView()
        activityView.displayLoader()
        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(catUrl, parameters) { (urlData) in
            activityView.dismissLoader()
            do {
                let rootDicnew = try JSONDecoder().decode(EndorsementDetailsModel.self, from: urlData)
                self.endorsementModekObj = rootDicnew
                
                if self.endorsementModekObj != nil {
                    
                    let endorsement = menuItem(Name: rootDicnew.endorsement.endorsementNo ?? "")
                    
                    var createDateObj:String  = ""
                    if let dateStr = rootDicnew.endorsement.createDate {
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        let date: Date? = dateFormatterGet.date(from: dateStr)
                        createDateObj = dateFormatter.string(from: date!)
                    }
                    
                    let Date = menuItem(Name: createDateObj )
                    let status = menuItem(Name: rootDicnew.endorsement.status ?? "")
                    self.section1DetilsArray = [endorsement,Date,status]
                    
                    let Referencedby = menuItem(Name: rootDicnew.endorsement.referredBy ?? "")
                    let Referencephone = menuItem(Name: rootDicnew.endorsement.refByPhone ?? "")
                    self.section2DetilsArray = [Referencedby,Referencephone]
                    
                    
                    let pettioner = menuItem(Name: rootDicnew.endorsement.petitionerCategory ?? "")
                    let pettionerName = menuItem(Name: rootDicnew.endorsement.petitionerName ?? "")
                    let pettionerPhone = menuItem(Name: rootDicnew.endorsement.petitionerMobile ?? "")
                    let department = menuItem(Name: rootDicnew.endorsement.department ?? "")
                    let endorsedOff = menuItem(Name: rootDicnew.endorsement.endorsedOfficer ?? "")
                    let replyreceived = menuItem(Name: rootDicnew.endorsement.replyReceived ?? "")
                    self.section3DetilsArray = [pettioner,pettionerName,pettionerPhone,department,endorsedOff,replyreceived]
                    
                    
                    let Address1 = menuItem(Name: rootDicnew.endorsement.address ?? "")
                    let Hamlet = menuItem(Name: rootDicnew.endorsement.hamlet ?? "")
                    let District = menuItem(Name: rootDicnew.endorsement.district ?? "")
                    let mandal = menuItem(Name: rootDicnew.endorsement.mandal ?? "")
                    let village = menuItem(Name: rootDicnew.endorsement.village ?? "")
                    let pettioneDetails = menuItem(Name: rootDicnew.endorsement.petitionDetails ?? "")
                    self.section4DetilsArray = [Address1,Hamlet,District,mandal,village,pettioneDetails]
                    
                    self.customView.textView.text = rootDicnew.endorsement.remarks
                    self.customView.textView.textColor = UIColor.black
                    if self.customView.textView.text.isEmpty{
                        self.customView.textView.text = "Remarks"
                        self.customView.textView.textColor = UIColor.lightGray
                    }
                    
                    
                    if (rootDicnew.uploadedFiles?.count)! > 0 {
                        self.customView.shadowView.isHidden = false
                        self.customView.buttonHeightConst.constant = 50

                        if (self.endorsementModekObj?.uploadedFiles?.count)! > 0 {
                            self.customView.isHidden = false
                            let uploadFileInfo = self.endorsementModekObj?.uploadedFiles?.first
                            let attributedString = NSAttributedString(string: uploadFileInfo?.fileName ?? "", attributes:[
                                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                                NSAttributedString.Key.foregroundColor : UIColor.blue,
                                NSAttributedString.Key.underlineStyle:1.0
                            ])
                            self.customView.shadowButton.setAttributedTitle(attributedString, for: .normal)
                            let UrlString = uploadFileInfo!.filePath  + "/" + uploadFileInfo!.fileName
                            self.customView.shadowButton.setTitle(UrlString, for: .normal)
                            self.customView.shadowButton.menuObjName = UrlString
                            self.customView.shadowButton.addTarget(self, action: #selector(self.navigateAcion(sender:)), for: .touchUpInside)
                        }
                        
                        
                    }
                    else{
                        self.customView.buttonHeightConst.constant = 0
                        self.customView.shadowView.isHidden = true
                    }
                    
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }else{
                    self.customView.buttonHeightConst.constant = 0
                    self.customView.shadowView.isHidden = true
                    self.view.makeToast("No Results Found")
                }
            } catch (let error) {
                activityView.dismissLoader()
                do {
                    self.view.makeToast("View Endorsement - 409")
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


extension EndorsementDetailsVC: UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
        else
        {
            return section4.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var items : [menuItem]!
        let cell = UITableViewCell()
        if indexPath.section == 0 {
            items = section1
             let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.text = ""
            cell.selectionStyle = .none
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            
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
            
            
            return cell

        }else if indexPath.section == 1 {
            items = section2
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrievancDetailsCell", for: indexPath) as! GrievancDetailsCell
            cell.gtitleDescription.text = ""
            cell.selectionStyle = .none
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            
            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section2DetilsArray.count > 0 {
                let theMenuItemDescription = self.section2DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            
            if self.endorsementModekObj != nil {
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
            cell.gtitleDescription.text = ""
            cell.selectionStyle = .none
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            
            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section3DetilsArray.count > 0 {
                let theMenuItemDescription = self.section3DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
            }
            
            if self.endorsementModekObj != nil {
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
            cell.gtitleDescription.text = ""
            cell.selectionStyle = .none
            cell.gtitleDescription.attributedText = NSAttributedString()
            cell.gtitleDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            
            let theMenuItem = items[indexPath.item]
            cell.gTtileLabel.text = theMenuItem.Name
            if self.section4DetilsArray.count > 0 {
                let theMenuItemDescription = self.section4DetilsArray[indexPath.item]
                cell.gtitleDescription.text = theMenuItemDescription.Name
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
            
            if indexPath.section == 3 && indexPath.row == 5 {
                return UITableView.automaticDimension
            }
            
            
            return 50
        }
        return 50
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            return "Endorsement - Entry"
            
        }else if section == 1{
            
            return "Reference Info"
        }
        else if section == 2
        {
            return "Pettition Info"
        }
        else
        {
            return "Address"
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

    
    @objc func UpdateEndorseInfo(){
        
        guard let remarks:String = customView.textView.text else {
            customView.textView.displayError()
            return
        }
        guard let userName:String = UserManager.sharedInstance.currentUserInfomation?.user.username else {
            return
        }

        customView.textView.clearError()
        var parameters = self.endorsementModekObj?.endorsement.dictionary
        parameters?["remarks"] = remarks
            
        let dateObj = Foundation.Date().string(format: "yyyy-MM-dd HH:MM")
        let endorseDict: [String: Any] = ["endorsement": parameters ??
                                            [:], "username" : userName, "actTime" : dateObj]
        
        let catUrl : String  =  myHelper.endorsementupdate
        let activityView = MyActivityView()
        activityView.displayLoader()
        
        ApiService.sharedManager.startPostApiServiceWithBearerTokenWithRawData(catUrl, endorseDict, success: { (urlData) in
            activityView.dismissLoader()
            do {
                let val = String(data: urlData, encoding: String.Encoding.utf8)
                ErrorManager.showSuccessAlert(mainTitle: "", subTitle: "Remarks updated successfully")
                print("")
            } catch  {
                activityView.dismissLoader()
                ErrorManager.showErrorAlert(mainTitle: "", subTitle: error.localizedDescription)
            }
            
        })
        { (errorString) in
            activityView.dismissLoader()
            ErrorManager.showErrorAlert(mainTitle: "", subTitle: errorString)
        }
        
    }

    
    
    
}




//do {
//    let dictObj =  try self.endorsementModekObj?.endorsement.asDictionary()
//    print(dictObj)
//} catch  {
//
//}

extension String {

func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension Dictionary {
    var jsonStringRepresentation: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }

        return String(data: theJSONData, encoding: .ascii)
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}


extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}


struct EndorsementDetailsModel: Codable {
    let endorsement: Endorsement
    let districts: [District]
    let mandals, villages, activities: [JSONAny]
    let namesByPositionList: JSONAny?
    let fileSerialNo: Int
    let uploadedFiles: [UploadedFile]?
    let attachments, endorsementRemarks: [JSONAny]
}


// MARK: - Endorsement
struct Endorsement: Codable {
    let id: String?
    let serialNo: Int?
    let endorsementNo, status, petitionerCategory, petitionerName: String?
    let petitionerPortFolio, constituency: String?
    let petitionerMobile, createDate: String?
    let receivedDate: String?
    let referredBy, petitionDetails, endorsedOfficer, department: String?
    let address, hamlet, village, mandal: String?
    let district: String?
    let state, country: String?
    let remarks, replyReceived, refByPhone: String?
    let hasAttachment, hasFiles: Bool?
}


