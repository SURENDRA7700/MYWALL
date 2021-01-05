//
//  ReimbrusementVC.swift
//  My Wall
//
//  Created by surendra on 05/12/20.
//

import UIKit

class ReimbrusementVC: UIViewController {

    var catTitile : String = ""
    var catTUrl : String = ""
    var itemTabType : ViewPagerTab!
    var dashBoardType : DashBoardType = .Grievances

    
    var blogsArray : [ReimbrusementModelElement]? = []
    var filterArray : [ReimbrusementModelElement]? = []
    var orgArray : [ReimbrusementModelElement]? = []
    
    var searchBarHeright: NSLayoutConstraint?

    lazy  var searchField:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search ..."
        searchBar.sizeToFit()
        searchBar.showsCancelButton = false;
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.tintColor = UIColor.lightGray
        searchBar.autocapitalizationType = .none
        return searchBar

    }()

    
    lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.delegate = (self as UITableViewDelegate)
        tableView.dataSource = (self as UITableViewDataSource)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    private var navigationBar: UINavigationBar!
    private var customNavigationItem: UINavigationItem!
    
    @objc func backAction () {
        self.dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.navigationBar.barTintColor = UIColor.MyWall.appColor
//        UINavigationBar.appearance().tintColor = .white
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().isTranslucent = false
//
//        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
//        backButton.setImage(UIImage(named: "arrow"), for: .normal)
//        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
//        backButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        self.ConfigureNavBarDetils()
        self.ConfigureViews()
        self.title = self.catTitile

        UserManager.isUserLoggedin()
        self.getCategoryData()

        // Do any additional setup after loading the view.
    }
    
    
    func getCategoryData()
    {
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }
        let activityView = MyActivityView()
        activityView.displayLoader()
        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(catTUrl, parameters) { (urlData) in
            activityView.dismissLoader()
            do {
                let rootDicnew = try JSONDecoder().decode(ReimbrusementModel.self, from: urlData)
                if rootDicnew.count > 0
                {
                    DispatchQueue.main.async {
                        self.orgArray = rootDicnew
                        self.orgArray?.reverse()
                        self.blogsArray = self.orgArray
                        self.tableview.reloadData()
                    }
                }else{
                    
                    self.view.makeToast("No records Found")
//                    ErrorManager.showErrorAlert(mainTitle: "", subTitle: "No records FOund")
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
            ErrorManager.showErrorAlert(mainTitle: "", subTitle: errorString)

        }
        
        
    }

    

    func ConfigureViews()
    {
        view.addSubview(searchField)
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        searchBarHeright = searchField.heightAnchor.constraint(equalToConstant: 50)
        searchBarHeright?.isActive = true
        searchField.delegate = self
        searchField.layer.borderWidth = 2
        searchField.layer.borderColor = UIColor.MyWall.appColor.cgColor

        view.addSubview(tableview)
        tableview.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        let nibName = UINib(nibName: "BlogCell", bundle:nil)
        tableview.register(nibName, forCellReuseIdentifier: "BlogCell")
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 500

        //Bsckground refresh

    }
    
    


}


extension ReimbrusementVC:UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.blogsArray!.count >= 1 {
            return self.blogsArray!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogCell
        cell.UpdateLayoutShadow()
        var eachBlog : ReimbrusementModelElement? = nil
        eachBlog = self.blogsArray?[indexPath.row]
        switch self.dashBoardType {
        case .Grievances:
            do {
                if eachBlog != nil  {

                    
                }
                
            }
            break
        case .Reimbursement:
            do{

                cell.firstLabelTitle.text = "File :"
                cell.secLabelTitle.text = "Patient Name :"
                cell.thirdLabelTtle.text = "Relation :"
                cell.fourthLabelTitle.text = "Status :"
                cell.ficeLabelTitle.text = "Address"
                
                cell.firstLabelTitleDesc.text = eachBlog?.fileNo
                cell.secLabelTitleDesc.text = eachBlog?.patientName
                
                
                var relativeNameObj : String =  ""
                if (eachBlog?.relation != nil) && (eachBlog?.relation != "null")  {
                    relativeNameObj = "\(eachBlog?.relation ?? "")" + " " + "\(eachBlog?.relativeName ?? "")"
                }else{
                    relativeNameObj = eachBlog?.relativeName ?? ""
                }
                cell.thirdLabelTtleDesc.text = relativeNameObj
                
                
                cell.fourthLabelTitleDesc.text = eachBlog?.status
                var address : String = "\(eachBlog?.pAddress ?? "") \(eachBlog?.village ?? "") \(eachBlog?.mandal ?? "") \(eachBlog?.district ?? "") "
                address = address.trimmingCharacters(in: .whitespaces)
                cell.ficeLabelTitleDesc.text = address
                cell.firstLabelTitleDesc.textColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
                cell.fourthLabelTitleDesc.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)

                
            }
            break
        case .LOC:
            do {
                
                cell.firstLabelTitle.text = "File :"
                cell.secLabelTitle.text = "Patient Name :"
                cell.thirdLabelTtle.text = "Relation :"
                cell.fourthLabelTitle.text = "Status :"
                cell.ficeLabelTitle.text = "Address"
                
                cell.firstLabelTitleDesc.text = eachBlog?.fileNo
                cell.secLabelTitleDesc.text = eachBlog?.patientName
                
                
                var relativeNameObj : String =  ""
                if (eachBlog?.relation != nil) && (eachBlog?.relation != "null")  {
                    relativeNameObj = "\(eachBlog?.relation ?? "")" + " " + "\(eachBlog?.relativeName ?? "")"
                }else{
                    relativeNameObj = eachBlog?.relativeName ?? ""
                }
                cell.thirdLabelTtleDesc.text = relativeNameObj
                
                
                cell.fourthLabelTitleDesc.text = eachBlog?.status
                var address : String = "\(eachBlog?.pAddress ?? "") \(eachBlog?.village ?? "") \(eachBlog?.mandal ?? "") \(eachBlog?.district ?? "") "
                address = address.trimmingCharacters(in: .whitespaces)
                cell.ficeLabelTitleDesc.text = address
                cell.firstLabelTitleDesc.textColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
                cell.fourthLabelTitleDesc.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                
                
            }
            break
        case .PeshiFiles:
            do {
                

                
            }
            break
        case .Endorsement:
            do{
                

                
            }
            break
        case .Letters:
            do  {
                
                
            }
            break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch self.dashBoardType {
        case .Grievances:
            break
        case .Reimbursement:
            do{
                
                if self.blogsArray != nil && !self.blogsArray!.isEmpty{
                    var eachBlog : ReimbrusementModelElement? = nil
                    eachBlog = self.blogsArray?[indexPath.row]
                    let catVC = ReimbrusementDetailsVC()
                    catVC.dashBoardType = self.dashBoardType
                    catVC.eachBlog = eachBlog
                    let aObjNavi = UINavigationController(rootViewController: catVC)
                    aObjNavi.modalPresentationStyle = .fullScreen
                    self.present(aObjNavi, animated: true, completion: nil)
                }
                
            }
            break
        case .LOC:
            do {
                
                if self.blogsArray != nil && !self.blogsArray!.isEmpty{
                    var eachBlog : ReimbrusementModelElement? = nil
                    eachBlog = self.blogsArray?[indexPath.row]
                    let catVC = LocDetailsVC()
                    catVC.dashBoardType = self.dashBoardType
                    catVC.eachBlog = eachBlog
                    let aObjNavi = UINavigationController(rootViewController: catVC)
                    aObjNavi.modalPresentationStyle = .fullScreen
                    self.present(aObjNavi, animated: true, completion: nil)
                }
                
            }
            break
        case .PeshiFiles:
            break
        case .Endorsement:
            break
        case .Letters:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchField.resignFirstResponder()
    }
    
       
    //Selection of each item adding
    @objc func favItemSelected(sender:BlogBuuton){
        
    }

}


extension ReimbrusementVC : UISearchBarDelegate {
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.searchString(searchBar)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
                self.tableview.reloadData()
            }
        }else{
            self.searchString(searchBar)
        }
    }
    
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchString(searchBar)
        self.searchField.resignFirstResponder()
        self.tableview.reloadData()
    }
    
    //filter search results
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchString(searchBar)
        self.searchField.resignFirstResponder()

   }
    
    func searchString(_ searchBar: UISearchBar)
    {
        
        blogsArray?.removeAll()
        if (((searchBar.text?.utf8.count)!) > 0) {
            do {
                let searchString = searchBar.text?.trimWhiteSpace()
                if searchString != "", searchString!.count > 0 {
                    if let text = searchField.text {
                        blogsArray = self.orgArray?.filter {
                            ( (($0.fileNo?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.patientName?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.date?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.status?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.village?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.mandal?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.district?.lowercased().contains(text.lowercased())) == true)
                            )
                            
                        }
                    }
                }
                if self.blogsArray!.count > 0  {
                    tableview.reloadData()
                }else{
                    self.searchField.resignFirstResponder()
                    self.view.makeToast("No records FOund")
                }
            }
        }else{
            self.blogsArray = orgArray
            if blogsArray!.count > 0 {
                tableview.reloadData()
            }else{
                self.searchField.resignFirstResponder()
                self.view.makeToast("No records FOund")
            }
        }
    }

    
}



struct ReimbrusementModelElement: Codable {
    let id, fileNo, cmrfType, status: String?
    let date: String?
    let applicationDate: JSONAny?
    let refBy, refPhone: String?
    let salutation: JSONAny?
    let patientName, sex: String?
    let relation, relativeName: String?
    let pPhone: String
    let altPhone, aadhar: JSONAny?
    let age: String?
    let pAddress: String?
    let hamlet: JSONAny?
    let village, mandal: String?
    let district, state: String?
    let country, pincode: JSONAny?
    let desease, hospitalName, hospAddress: String?
    let additionalRequest: Bool
    let previousSanctionedAmt: Int?
    let previousAmtInWords: JSONAny?
    let treatmentAmount: Int?
    let amtInWords: String?
    let peshiLrNo: String
    let peshiDate, remarks, signedDate, fileLocation: JSONAny?
    let sanctionedAmt: Int?
    let sactinedAmtInWords: String?
    let sanctionedDate: String?
    let sanctionedNo: String?
    let chequeNo, chequeDate, sanctionRemarks: String?
    let additionalFund: String?
    let cmrfObjID: JSONAny?

    enum CodingKeys: String, CodingKey {
        case id, fileNo, cmrfType, status, date, applicationDate, refBy, refPhone, salutation, patientName, sex, relation, relativeName, pPhone, altPhone, aadhar, age, pAddress, hamlet, village, mandal, district, state, country, pincode, desease, hospitalName, hospAddress, additionalRequest, previousSanctionedAmt, previousAmtInWords, treatmentAmount, amtInWords, peshiLrNo, peshiDate, remarks, signedDate, fileLocation, sanctionedAmt, sactinedAmtInWords, sanctionedDate, sanctionedNo, chequeNo, chequeDate, sanctionRemarks, additionalFund
        case cmrfObjID = "cmrfObjId"
    }
}

typealias ReimbrusementModel = [ReimbrusementModelElement]


