//
//  LetterDashBoardVC.swift
//  My Wall
//
//  Created by surendra on 05/12/20.
//

import UIKit

class LetterDashBoardVC: UIViewController {

    var catTitile : String = ""
    var catTUrl : String = ""
    var itemTabType : ViewPagerTab!
    var dashBoardType : DashBoardType = .Grievances

    
    var blogsArray : [LeeterDashModelElement]? = []
    var filterArray : [LeeterDashModelElement]? = []
    var orgArray : [LeeterDashModelElement]? = []
    
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
                let rootDicnew = try JSONDecoder().decode(LeeterDashModel.self, from: urlData)
                if rootDicnew.count > 0
                {
                    DispatchQueue.main.async {
                        self.orgArray = rootDicnew
                        self.orgArray?.sort(by: { $0.serialNo > $1.serialNo })
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


extension LetterDashBoardVC:UITableViewDelegate, UITableViewDataSource
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
        var eachBlog : LeeterDashModelElement? = nil
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
            }
            break
        case .LOC:
            do {
                
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
                
                cell.firstLabelTitle.text = "LanNo :"
                cell.secLabelTitle.text = "Name :"
                cell.thirdLabelTtle.text = "Status :"
                cell.fourthLabelTitle.text = "Department :"
                cell.ficeLabelTitle.text = "EndorsedOfficer"
                
                cell.firstLabelTitleDesc.text = eachBlog?.lonNo
                cell.secLabelTitleDesc.text = eachBlog?.petitionerName
                cell.thirdLabelTtleDesc.text = eachBlog?.status
                cell.fourthLabelTitleDesc.text = eachBlog?.department
                cell.ficeLabelTitleDesc.text = eachBlog?.sentToOfficer
                cell.firstLabelTitleDesc.textColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
                cell.thirdLabelTtleDesc.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                

            }
            break
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.blogsArray != nil && !self.blogsArray!.isEmpty{
            var eachBlog : LeeterDashModelElement? = nil
            eachBlog = self.blogsArray?[indexPath.row]
            let catVC = LetterDetilsVC()
            catVC.dashBoardType = self.dashBoardType
            catVC.eachBlog = eachBlog
            let aObjNavi = UINavigationController(rootViewController: catVC)
            aObjNavi.modalPresentationStyle = .fullScreen
            self.present(aObjNavi, animated: true, completion: nil)
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


extension LetterDashBoardVC : UISearchBarDelegate {
    
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
                            ( (($0.lonNo?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.petitionerName?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.status?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.department?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.sentToOfficer?.lowercased().contains(text.lowercased())) == true)
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





/*
struct LeeterDashModelElement: Codable {
    let id: String?
    let serialNo: Int
    let type: TypeEnum
    let lonNo, createDate, petitionerPosition: String?
    let petitionerName: String?
    let petitionerPortFolio, constituency: JSONAny?
    let petitionerMobile, referenceName, referenceMobile, petitionDetails: String?
    let department, sentToOfficer: String?
    let status: String?
    let location, address, hamlet: String?
    let village, mandal, district: String?
    let recievedDate: String?
    let dispatchMode: DispatchMode
    let dispatchedDate: String?
    let remarks: String?
    let replyRecieved: ReplyRecieved
}

enum DispatchMode: String, Codable {
    case byPersonal = "By Personal"
    case post = "Post"
}

enum ReplyRecieved: String, Codable {
    case empty = ""
    case no = "No"
    case null = "null"
}

//enum Status: String, Codable {
//    case dispatched = "Dispatched"
//    case hold = "Hold"
//    case new = "New"
//}

enum TypeEnum: String, Codable {
    case letter = "Letter"
    case note = "Note"
}

typealias LeeterDashModel = [LeeterDashModelElement]

*/

 // Live surendra



struct LeeterDashModelElement: Codable {
    let id: String?
    let serialNo: Int
    let type: TypeEnum
    let lonNo, createDate: String?
    let petitionerPosition: PetitionerPosition
    let petitionerName: String?
    let petitionerPortFolio, constituency: String?
    let petitionerMobile: Hamlet?
    let referenceName: ReferenceName?
    let referenceMobile: ReferenceMobile?
    let petitionDetails, department, sentToOfficer: String?
    let status: String?
    let location: JSONAny?
    let address: String?
    let hamlet: Hamlet?
    let village, mandal, district: String?
    let recievedDate: JSONAny?
    let dispatchMode: DispatchMode
    let dispatchedDate: String?
    let remarks: Hamlet?
    let replyRecieved: ReplyRecieved?
}

enum DispatchMode: String, Codable {
    case byPersonal = "By Personal"
    case messenger = "Messenger"
    case post = "Post"
}

enum Hamlet: String, Codable {
    case empty = ""
    case null = "null"
    case the7382571777 = "7382571777"
}

enum PetitionerPosition: String, Codable {
    case general = "General"
    case sircilla = "Sircilla"
}

enum ReferenceMobile: String, Codable {
    case empty = ""
    case null = "null"
    case the1005Jpg = "1005.jpg"
}

enum ReferenceName: String, Codable {
    case empty = ""
    case null = "null"
    case smtVasantha = "Smt. Vasantha"
    case sriPrafulDeshpandeSOSriRahulDeshpande = "Sri Praful Deshpande S/o Sri Rahul Deshpande"
}

enum ReplyRecieved: String, Codable {
    case no = "No"
}

enum StatusString: String, Codable {
    case dispatched = "Dispatched"
}

enum TypeEnum: String, Codable {
    case doLetter = "DO Letter"
    case letter = "Letter"
    case note = "Note"
}

typealias LeeterDashModel = [LeeterDashModelElement]
