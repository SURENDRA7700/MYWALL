//
//  CategoryVC.swift
//  sampleTableview
//
//  Created by SURENDRA on 04/12/20.
//

import UIKit


class CategoryVC: UIViewController, UINavigationBarDelegate {

   
    var catTitile : String = ""
    var catTUrl : String = ""
    var itemTabType : ViewPagerTab!
    var dashBoardType : DashBoardType = .Grievances

    
    var blogsArray : [CategoryModelElement]? = [] {
        didSet {
            tableview.isHidden = false
        }
    }
    var filterArray : [CategoryModelElement]? = []
    var orgArray : [CategoryModelElement]? = []
    
    var searchBarHeright: NSLayoutConstraint?

    lazy var searchField:UISearchBar = {
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
                let rootDicnew = try JSONDecoder().decode(CategoryModelNew.self, from: urlData)
                if rootDicnew.count > 0
                {
                    for catDictObj  in rootDicnew {
                        let eachCatObjModel = try DictionaryDecoder().decode(CategoryModelElement.self, from: catDictObj as [String : Any])
                        self.orgArray?.append(eachCatObjModel)
                    }
                    self.orgArray?.sort(by: { $0.createDate?.compare($1.createDate ?? "") == .orderedDescending})
                    self.orgArray = self.orgArray?.map { (eachObj: CategoryModelElement) -> CategoryModelElement in
                        var tempEachObj : CategoryModelElement  = eachObj
                        if let dateStr = tempEachObj.createDate {
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            let date: Date? = dateFormatterGet.date(from: dateStr)
                            let dateGrie = dateFormatter.string(from: date!)
                            tempEachObj.createDate = dateGrie
                        }
                        return tempEachObj
                    }
                    
                    
                }else{
                    self.view.makeToast("No records FOund")
                }
                DispatchQueue.main.async {
                    self.blogsArray = self.orgArray
                    self.tableview.reloadData()
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CategoryVC : UITableViewDelegate, UITableViewDataSource
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
        var eachBlog : CategoryModelElement? = nil
        eachBlog = self.blogsArray?[indexPath.row]
        switch self.dashBoardType {
        case .Grievances:
            do {
                if eachBlog != nil  {
                    cell.firstLabelTitle.text = "Grievance :"
                    cell.secLabelTitle.text = "Title :"
                    cell.thirdLabelTtle.text = "Date :"
                    cell.fourthLabelTitle.text = "Status :"
                    cell.ficeLabelTitle.text = "Beneficiary"
                    
                    cell.firstLabelTitleDesc.text = eachBlog?.tgID
                    cell.secLabelTitleDesc.text = eachBlog?.title
                    cell.thirdLabelTtleDesc.text = eachBlog?.createDate
                    cell.fourthLabelTitleDesc.text = eachBlog?.status
                    cell.ficeLabelTitleDesc.text = eachBlog?.person
                    
                    cell.firstLabelTitleDesc.textColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
                    cell.fourthLabelTitleDesc.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    
//                    if let dateStr = eachBlog?.createDate {
//                        let dateFormatterGet = DateFormatter()
//                        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "dd-MM-yyyy"
//                        let date: Date? = dateFormatterGet.date(from: dateStr)
//                        let dateGrie = dateFormatter.string(from: date!)
//                        print(dateGrie)
//                        cell.thirdLabelTtleDesc.text = dateGrie
//                    }
                    
                    
                    
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
                
                
            }
            break
        }
        
        
        return cell
    }
    

        
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.blogsArray != nil && !self.blogsArray!.isEmpty{
            var eachBlog : CategoryModelElement? = nil
            eachBlog = self.blogsArray?[indexPath.row]
            let catVC = GreivanceDetailsVC()
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


extension CategoryVC : UISearchBarDelegate {
    
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
                            ( (($0.title?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.tgID?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.createDate?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.status?.lowercased().contains(text.lowercased())) == true) ||
                                (($0.person?.lowercased().contains(text.lowercased())) == true)
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


extension String {
    func trimWhiteSpace() -> String {
        let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return string
    }
}


extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
    }
}






struct CategoryModelElement: Codable {
    let id, tgID, orgName, title: String?
    var tweetID, tweetDesc, desc, createDate: String?
    let orginatorName, twitterLink, assignedTo, status: String?
    let tweetTime, person: String?
    let personPhone, relationToContact: JSONAny?
    let contactName, contactNo: String?
    let contractTID: JSONAny?
    let contactEmail, gistOfCase, address: String?
    let hamlet: JSONAny?
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


typealias CategoryModelNew = [[String: String?]]


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}




class JSONAny: Codable {
    public let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


// MARK: - Encode/decode helpers
class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

struct KeyValue: Codable {
    let key: String
    let value: String
}

class DictionaryEncoder {

    private let encoder = JSONEncoder()

    var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy {
        set { encoder.dateEncodingStrategy = newValue }
        get { return encoder.dateEncodingStrategy }
    }

    var dataEncodingStrategy: JSONEncoder.DataEncodingStrategy {
        set { encoder.dataEncodingStrategy = newValue }
        get { return encoder.dataEncodingStrategy }
    }

    var nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy {
        set { encoder.nonConformingFloatEncodingStrategy = newValue }
        get { return encoder.nonConformingFloatEncodingStrategy }
    }

    var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy {
        set { encoder.keyEncodingStrategy = newValue }
        get { return encoder.keyEncodingStrategy }
    }

    func encode<T>(_ value: T) throws -> [String: Any] where T : Encodable {
        let data = try encoder.encode(value)
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    }
}

class DictionaryDecoder {

    private let decoder = JSONDecoder()

    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        set { decoder.dateDecodingStrategy = newValue }
        get { return decoder.dateDecodingStrategy }
    }

    var dataDecodingStrategy: JSONDecoder.DataDecodingStrategy {
        set { decoder.dataDecodingStrategy = newValue }
        get { return decoder.dataDecodingStrategy }
    }

    var nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy {
        set { decoder.nonConformingFloatDecodingStrategy = newValue }
        get { return decoder.nonConformingFloatDecodingStrategy }
    }

    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        set { decoder.keyDecodingStrategy = newValue }
        get { return decoder.keyDecodingStrategy }
    }

    func decode<T>(_ type: T.Type, from dictionary: [String: Any]) throws -> T where T : Decodable {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return try decoder.decode(type, from: data)
    }
}
