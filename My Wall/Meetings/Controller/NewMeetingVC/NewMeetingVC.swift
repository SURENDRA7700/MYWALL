//
//  NewMeetingVC.swift
//  My Wall
//
//  Created by surendra on 20/12/20.
//

import UIKit
import IQKeyboardManagerSwift
import YYCalendar
import EventKit

class NewMeetingVC: UIViewController,WWCalendarTimeSelectorProtocol,UNUserNotificationCenterDelegate {
    
    var meetingDate : String = ""
    var selectedRowIrem =  0
    var selectedRowIremStatus =  4
    var parentVC = UIViewController()
    var calendarEachEvent : GetMeetingModelInfoElement? = nil
    var isfromUpdate : Bool = false
    var initialModel : CreateMeetingInfoModel? = nil
    var selectedDate : String? = ""

    
    var topLabelTtilw  : String? = ""
    var topMeetingTpe  : String? = ""
    var topMeetingDate  : String? = ""
    var topMeetingStartTime  : String? = ""
    var topMeetingEndTime  : String? = ""
    
    var typeUpdate : Bool = false
    var timeUpdate : Bool = false
    var startTimeUpdate : Bool = false
    var endTimeUpdate : Bool = false

    
    lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.delegate = (self as UITableViewDelegate)
        tableView.dataSource = (self as UITableViewDataSource)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var section1 : [menuItem]!
    var section2 : [menuItem]!
    var section3 : [menuItem]!
    var section4 : [menuItem]!
    var section5 : [menuItem]!
    var section6 : [menuItem]!
    var section7 : [menuItem]!
    var section8 : [menuItem]!
    var section9 : [menuItem]!
    var section10 : [menuItem]!
    
    
    let Title = menuItem(Name: "Title :")
    let Meeting = menuItem(Name: "Meeting Type :")
    let Date = menuItem(Name: "Date :")
    let StartTime = menuItem(Name: "Start Time :")
    let EndTime = menuItem(Name: "End Time :")
    let Address = menuItem(Name: "Address :")
    let Department = menuItem(Name: "Department :")
    let Status = menuItem(Name: "Status :")
    let Createdby = menuItem(Name: "Created by :")
    let Agenda = menuItem(Name: "Agenda :")
    var meetingTypeArray : [String]? = []
    var meetingStatusArray : [String]? = []
    
    
    let chooseDropDownMeetType = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.chooseDropDownMeetType
        ]
    }()
    
    let chooseDropDownMeetStatus = DropDown()
    lazy var dropDownStatus: [DropDown] = {
        return [
            self.chooseDropDownMeetStatus
        ]
    }()
    
    
    
    fileprivate var singleDate: Date = NSDate() as Date
    fileprivate var multipleDates: [Date] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Meeting"
        if self.isfromUpdate {
            self.title = "Update Meeting"
        }
        
        self.ConfigureNavBarDetilsNewMeeting()
        
        IQKeyboardManager.shared.enable = true
        
        
        section1 = [Title]
        section2 = [Meeting]
        section3 = [Date]
        section4 = [StartTime]
        section5 = [EndTime]
        section6 = [Address]
        section7 = [Department]
        section8 = [Status]
        section9 = [Createdby]
        section10 = [Agenda]
        
//        meetingTypeArray = ["Official","Un Official"]
//        meetingStatusArray = ["Attended","Cancel","Committed","Rescheduled","Scheduled"]
        
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 60
        
        view.addSubview(tableview)
        tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        let nibName = UINib(nibName: "MeetDropDownCell", bundle:nil)
        tableview.register(nibName, forCellReuseIdentifier: "MeetDropDownCell")
        
        let nibNameTextEditCell = UINib(nibName: "TextEditCell", bundle:nil)
        tableview.register(nibNameTextEditCell, forCellReuseIdentifier: "TextEditCell")
        
        let nibNameMeetTextViewCell = UINib(nibName: "MeetTextViewCell", bundle:nil)
        tableview.register(nibNameMeetTextViewCell, forCellReuseIdentifier: "MeetTextViewCell")
        tableview.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        
        var customView = MeetingFooterViewWall()
        customView = MeetingFooterViewWall(frame: CGRect(x: 0, y: 20, width: tableview.frame.width, height: 80))
        tableview.tableFooterView = customView
        if self.isfromUpdate {
            customView.save.setTitle("Update", for: .normal)
        }else{
            customView.save.setTitle("Save", for: .normal)
        }
        
        customView.cancel.addTarget(self, action: #selector(cancelAcrtion), for: .touchUpInside)
        customView.save.addTarget(self, action: #selector(saveMettingInfo), for: .touchUpInside)
        
    }
    
    func ConfigureNavBarDetilsNewMeeting(){
        navigationController?.navigationBar.barTintColor = UIColor.MyWall.appColor
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(backActionDetailsMeeting), for: .touchUpInside)
        backButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        
        let rightbackButton = UIButton(type: .custom)
        rightbackButton.setImage(UIImage.init(named: "ktr30"), for: .normal)
        rightbackButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightbackButton.layer.cornerRadius = 15
        rightbackButton.clipsToBounds = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightbackButton)
        
    }
    
    @objc func backActionDetailsMeeting () {
        if self.parentVC.isKind(of: SwiftDemoViewController.self) {
            let healthDataVC : SwiftDemoViewController = self.parentVC as! SwiftDemoViewController
            healthDataVC.selectedDate = ""
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UNUserNotificationCenter.current().delegate = self
        self.getMeetingDropDownInfo()
    }
    
    func getMeetingDropDownInfo(){
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }
        let catUrl : String  =  myHelper.getmeetinginitData
        let activityView = MyActivityView()
        activityView.displayLoader()
        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(catUrl, parameters) { (urlData) in
            activityView.dismissLoader()
            do {
                let rootDicnew = try JSONDecoder().decode(CreateMeetingInfoModel.self, from: urlData)
                self.initialModel = rootDicnew
                if rootDicnew.typesList!.count > 0{
                    self.meetingTypeArray = rootDicnew.typesList?.compactMap { $0.listItem}
                   /* var filterArrayType : [String] = []
                    filterArrayType = (rootDicnew.typesList?.filter({ $0.status == "Active"}).compactMap { $0.listItem})!
                    print(filterArrayType) */
                }
                if rootDicnew.statusList!.count > 0{
                    self.meetingStatusArray = rootDicnew.statusList?.compactMap { $0.listItem }
                    /*  var filterArrayStatus : [String] = []
                    filterArrayStatus = (rootDicnew.statusList?.filter({ $0.status == "Active"}).compactMap { $0.listItem})!
                    print(filterArrayStatus) */
                }
                self.tableview.reloadData()
            }
            catch (let error) {
                activityView.dismissLoader()
                do {
                    self.view.makeToast(error.localizedDescription)
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
    
    
    
    
    @objc func cancelAcrtion() {
        self.backActionDetailsMeeting()
    }
    
    
    
    func validateFields() -> Bool {
        var validTtile: Bool = true
        var validAddress: Bool = true
        var validDepartment: Bool = true
        var validAgenda : Bool = true
        
        
        let indexPathAddress = IndexPath(row: 0, section: 5)
        let cellAddress : TextEditCell = self.tableview.cellForRow(at: indexPathAddress)! as! TextEditCell

        let indexPathDepartment = IndexPath(row: 0, section: 6)
        let cellDepartment : TextEditCell = self.tableview.cellForRow(at: indexPathDepartment)! as! TextEditCell

        let indexPathdAgenda = IndexPath(row: 0, section: 9)
        let cellindexPathdAgenda : MeetTextViewCell = self.tableview.cellForRow(at: indexPathdAgenda)! as! MeetTextViewCell

        
        
        if let userName = self.topLabelTtilw {
            validTtile = userName.utf8.count > 0
            if !validTtile {
                let indexPathTtilw = IndexPath(row: 0, section: 0)
                self.tableview.scrollToRow(at: indexPathTtilw, at: .none, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let cell : TextEditCell = self.tableview.cellForRow(at: indexPathTtilw)! as! TextEditCell
                    cell.titleDescription.displayErrorPlaceholder("Please enter Ttile ")
                    cell.titleDescription.displayError()
                }

            }
        }
        
        
        if let address = cellAddress.titleDescription.text {
            validAddress = address.utf8.count > 0
            if !validAddress {
                cellAddress.titleDescription.displayErrorPlaceholder("Please enter your Address")
                cellAddress.titleDescription.displayError()
            }
        }
        
        if let department = cellDepartment.titleDescription.text {
            validDepartment = department.utf8.count > 0
            if !validDepartment {
                cellDepartment.titleDescription.displayErrorPlaceholder("Please enter your Department")
                cellDepartment.titleDescription.displayError()
            }
        }
        
        if let agenda = cellindexPathdAgenda.textView.text {
            validAgenda = agenda.utf8.count > 0
            if !validAgenda {
                cellindexPathdAgenda.textView.displayError()
            }
        }
        
        
        return validTtile && validAddress && validDepartment && validAgenda
    }
    
    
    
    @objc func saveMettingInfo() {
        
        self.view.endEditing(true)
        guard validateFields() else {return}
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateObj: Date? = dateFormatterGet.date(from: self.topMeetingDate!)
        let dateFinal = dateFormatter.string(from: dateObj!)
        
        
        dateFormatter.dateFormat = "hh:mm a"
        let dateinPm = dateFormatter.date(from: self.topMeetingStartTime!)
        dateFormatter.dateFormat = "HH:mm"
        let dateStandaradstartTime = dateFormatter.string(from: dateinPm!)
        
        dateFormatter.dateFormat = "hh:mm a"
        let dateendTime = dateFormatter.date(from: self.topMeetingEndTime!)
        dateFormatter.dateFormat = "HH:mm"
        let dateEndTime = dateFormatter.string(from: dateendTime!)
        
        
        
        
        let eventStartTime = dateFinal + " " + dateStandaradstartTime
        let eventEndTime = dateFinal + " " + dateEndTime
        let eentDateFormater = DateFormatter()
        eentDateFormater.dateFormat = "yyyy-MM-dd HH:mm"
        eentDateFormater.locale = NSLocale.current
        
        let eeventStartDate = eentDateFormater.date(from: eventStartTime)!
        let eventEndDate : Date = eentDateFormater.date(from: eventEndTime) ?? NSDate() as Date
        
        
        
        let indexPathlocation = IndexPath(row: 0, section: 5)
        let locationcell : TextEditCell = self.tableview.cellForRow(at: indexPathlocation)! as! TextEditCell
        
        let indexPathdepartment = IndexPath(row: 0, section: 6)
        let departmentcell : TextEditCell = self.tableview.cellForRow(at: indexPathdepartment)! as! TextEditCell
        
        let indexPathstatus = IndexPath(row: 0, section: 7)
        let statuscell : MeetDropDownCell = self.tableview.cellForRow(at: indexPathstatus)! as! MeetDropDownCell
        
        let indexPathcreatedBy = IndexPath(row: 0, section: 8)
        let createdByCell : TextEditCell = self.tableview.cellForRow(at: indexPathcreatedBy)! as! TextEditCell
        
        let indexPathagenda = IndexPath(row: 0, section: 9)
        let agendaCell : MeetTextViewCell = self.tableview.cellForRow(at: indexPathagenda)! as! MeetTextViewCell
        
        
        
        var id : String = self.calendarEachEvent?.id ?? ""
        if self.isfromUpdate == false {
            id = ""
        }
        let meetingId = self.initialModel?.meetingIDIdx ?? 0
        let title = self.topLabelTtilw ?? ""
        let type = self.topMeetingTpe ?? ""
        let date = dateFinal
        let startTime = dateStandaradstartTime
        let endTime = dateEndTime
        let location = locationcell.titleDescription.text ?? ""
        let department = departmentcell.titleDescription.text ?? ""
        let status = statuscell.meetTextField.text ?? ""
        let createdBy = createdByCell.titleDescription.text ?? ""
        let agenda = agendaCell.textView.text ?? ""
        
        let parameters = ["id":id,
                          "meetingId":meetingId,
                          "title":title,
                          "type":type,
                          "date":date,
                          "startTime":startTime,
                          "endTime":endTime,
                          "location":location,
                          "department":department,
                          "status":status,
                          "createdBy":createdBy,
                          "agenda":agenda
        ] as [String : Any]
        
        
        
        var InputUrl = myHelper.createMeeting
        if self.isfromUpdate {
            InputUrl = myHelper.updateMeeting
        }
        
        let activityView = MyActivityView()
        activityView.displayLoader()
        
        ApiService.sharedManager.startPostApiServiceWithBearerTokenWithRawData(InputUrl, parameters, success: { (urlData) in
            activityView.dismissLoader()
            do {
                let val = String(data: urlData, encoding: String.Encoding.utf8)
                DispatchQueue.main.async {
                    
                    if ((val?.contains("true")) != nil)
                    {
                        self.createLocalNotification(title: title, description: agenda, startDate: eeventStartDate , endDate: eventEndDate, location: location)
                        
                        self.addEventToCalendar(title: title, description: agenda, startDate:  eeventStartDate, endDate:  eventEndDate, location: location) {
                            (sucess, error) in
                        }
                        
                        if self.isfromUpdate {
                            ErrorManager.showSuccessAlert(mainTitle: "Meeting Updated successfully", subTitle: "")
                        }else{
                            ErrorManager.showSuccessAlert(mainTitle: "Meeting created successfully", subTitle: "")
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            } catch  {
                do {
                    let errorModel = try JSONDecoder().decode(ErrorModel.self, from: urlData)
                    ErrorManager.showErrorAlert(mainTitle: errorModel.error, subTitle: errorModel.errorDescription)
                }
                catch {
                    ErrorManager.showErrorAlert(mainTitle: "invalid_grant", subTitle: error.localizedDescription)
                }
            }
            
        })
        { (errorString) in
            activityView.dismissLoader()
            ErrorManager.showErrorAlert(mainTitle: "", subTitle: errorString)
        }
    }
    
    
    func createLocalNotification(title: String, description: String, startDate: Date, endDate: Date, location: String?)
    {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: description, arguments: nil)
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = "alarm"


        
        let today = startDate
//        let today : Date = NSDate() as Date
        let triggerWeekly = Calendar.current.dateComponents([.day,.hour,.minute,.second,], from: today)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)

//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, location: String?, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async { () -> Void in
            let eventStore = EKEventStore()
            
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil) {
                    let alarm = EKAlarm(relativeOffset: -3600.0)
                    let event = EKEvent(eventStore: eventStore)
                    event.title = title
                    event.startDate = startDate
                    event.endDate = endDate
                    event.notes = description
                    event.alarms = [alarm]
                    event.location = location
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    event.addAlarm(EKAlarm(absoluteDate: event.startDate))
                    event.addAlarm(alarm)

                    do {
                        try eventStore.save(event, span: .thisEvent,commit: true)
                    } catch let e as NSError {
                        completion?(false, e)
                        print ("\(#file) - \(#function) error: \(e.localizedDescription)")
                        return
                    }
                    completion?(true, nil)
                } else {
                    completion?(false, error as NSError?)
                    print ("\(#file) - \(#function) error: \(error)")
                }
            })
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           completionHandler([.alert,.sound])
        
        
       }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
           
           
       }
    
    
    
    @objc  func calnderClicked() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let createDateObj = dateFormatter.string(from: NSDate() as Date)
        let indexPath = IndexPath(row: 0, section: 2)
        let cell : MeetDropDownCell = self.tableview.cellForRow(at: indexPath)! as! MeetDropDownCell

        let calendar = YYCalendar(limitedCalendarLangType: .KOR,
                                  date: createDateObj,
                                  minDate: createDateObj,
                                  maxDate: "02/02/2030",
                                  format: "MM/dd/yyyy") { [weak self] date in
            
            cell.meetTextField.text = date
            self?.topMeetingDate = date
            self?.timeUpdate = true
        }

        calendar.dayButtonStyle = DayButtonStyle.circle
        calendar.dimmedBackgroundAlpha = 0.3
        calendar.headerViewBackgroundColor = #colorLiteral(red: 0.6385190487, green: 0.4598317742, blue: 0.2793223262, alpha: 1)
        calendar.show()

        
    }

    @objc  func startTimeClicked() {
        
        let selector:WWCalendarTimeSelector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: Bundle.main).instantiateViewController(withIdentifier: "WWCalendarTimeSelector") as! WWCalendarTimeSelector
        selector.delegate = self
        selector.view.tag = 123456
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        selector.optionLayoutHeight = 500

        present(selector, animated: true, completion: nil)

        
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        if selector.view.tag == 123456 {
            print("Selected \n\(date)\n---")
            singleDate = date
            let indexPath = IndexPath(row: 0, section: 3)
            let cell : MeetDropDownCell = self.tableview.cellForRow(at: indexPath)! as! MeetDropDownCell
            cell.meetTextField.text =  date.stringFromFormat("h:mm a")
            self.topMeetingStartTime = cell.meetTextField.text
            self.startTimeUpdate = true
            
            
            let currentDateTime = date
            let date = currentDateTime.addingTimeInterval(60 * 60)
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            formatter.string(from: date)
            let createDateObj = formatter.string(from: date)
            
            let indexPath4 = IndexPath(row: 0, section: 4)
            let cell4 : MeetDropDownCell = self.tableview.cellForRow(at: indexPath4)! as! MeetDropDownCell
            cell4.meetTextField.text =  createDateObj
            self.topMeetingEndTime = createDateObj

            

        }
        
        if selector.view.tag == 1234567 {
            print("Selected \n\(date)\n---")
            singleDate = date
            let indexPath = IndexPath(row: 0, section: 4)
            let cell : MeetDropDownCell = self.tableview.cellForRow(at: indexPath)! as! MeetDropDownCell
            cell.meetTextField.text =  date.stringFromFormat("h:mm a")
            
            let indexPathfromdate = IndexPath(row: 0, section: 3)
            let cellSection3Fromdate : MeetDropDownCell = self.tableview.cellForRow(at: indexPathfromdate)! as! MeetDropDownCell
            let fromString : String = cellSection3Fromdate.meetTextField.text ?? ""
            let toString : String = date.stringFromFormat("h:mm a")
            let dateDiff = findDateDiff(time1Str: fromString, time2Str: toString)
            if dateDiff.contains("-") {
                self.view.makeToast("Please select valid end time", duration: 3.0, position: .top)
                cell.meetTextField.text = fromString
            }
            self.topMeetingEndTime = cell.meetTextField.text
            self.endTimeUpdate = true

        }
        
    }
    
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"

        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return "" }

        //You can directly use from here if you have two dates

        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        let intervalInt = Int(interval)
        return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
    }
    
    
    
    
    @objc  func endTimeClicked() {
        
        let selector:WWCalendarTimeSelector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: Bundle.main).instantiateViewController(withIdentifier: "WWCalendarTimeSelector") as! WWCalendarTimeSelector
        selector.delegate = self
        selector.view.tag = 1234567
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        selector.optionLayoutHeight = 500
        present(selector, animated: true, completion: nil)

    }
    
    
        
    @objc  func dropdownClicked() {
        self.setupChooseDropDown()
        self.customizeDropDown(self)
        chooseDropDownMeetType.show()
    }
    
    @objc  func dropdownClickedStatus() {
        self.setupChooseDropDownForMettingStatus()
        self.customizeDropDown(self)
        chooseDropDownMeetStatus.show()
    }
    
}


extension NewMeetingVC
{
    func setupChooseDropDown() {
        let indexPath = IndexPath(row: 0, section: 1)
        let cell : MeetDropDownCell = self.tableview.cellForRow(at: indexPath)! as! MeetDropDownCell
        cell.meetTextField.dropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));
        chooseDropDownMeetType.anchorView = cell.meetTextField
        chooseDropDownMeetType.bottomOffset = CGPoint(x: 0, y: cell.meetTextField.bounds.height)
        chooseDropDownMeetType.dataSource = self.meetingTypeArray!
        chooseDropDownMeetType.selectRow(selectedRowIrem)
        chooseDropDownMeetType.selectionAction = { [weak self] (index, item) in
            self!.selectedRowIrem = index
            cell.meetTextField.text = item
            self?.topMeetingTpe = cell.meetTextField.text
            self?.typeUpdate = true
            cell.meetTextField.dropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        }
        chooseDropDownMeetType.cancelAction =  {
            cell.meetTextField.dropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        }
    }
    
    
    func customizeDropDown(_ sender: AnyObject) {
        let appearance = DropDown.appearance()
        appearance.cellHeight = 60
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor.MyWall.LightBlue
        appearance.cornerRadius = 10
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 25
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
        if #available(iOS 11.0, *) {
            appearance.setupMaskedCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        }
    }
    
    
    func setupChooseDropDownForMettingStatus() {
        let indexPath = IndexPath(row: 0, section: 7)
        let cell : MeetDropDownCell = self.tableview.cellForRow(at: indexPath)! as! MeetDropDownCell
        cell.meetTextField.dropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));
        chooseDropDownMeetStatus.anchorView = cell.meetTextField
        chooseDropDownMeetStatus.bottomOffset = CGPoint(x: 0, y: cell.meetTextField.bounds.height)
        chooseDropDownMeetStatus.dataSource = self.meetingStatusArray!
        chooseDropDownMeetStatus.selectRow(selectedRowIremStatus)
        chooseDropDownMeetStatus.selectionAction = { [weak self] (index, item) in
            self!.selectedRowIremStatus = index
            cell.meetTextField.text = item
            cell.meetTextField.dropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        }
        chooseDropDownMeetStatus.cancelAction =  {
            cell.meetTextField.dropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        }
    }

    
}



extension NewMeetingVC: UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 1 {
            self.topLabelTtilw = textField.text
        }
        
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var items : [menuItem]!

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextEditCell", for: indexPath) as! TextEditCell
            cell.titleDescription.tag = 1
            cell.titleDescription.delegate = self
            cell.titleDescription.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                            for: UIControl.Event.editingChanged)

            
            cell.selectionStyle = .none
            items = section1
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            cell.titleDescription.placeholder = "Enter Ttile"

            cell.titleDescription.delegate = self
            if self.isfromUpdate {
                cell.titleDescription.text = self.calendarEachEvent?.title ?? ""
            }
            topLabelTtilw = cell.titleDescription.text
            
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetDropDownCell", for: indexPath) as! MeetDropDownCell
            cell.selectionStyle = .none
            items = section2
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            
            cell.meetDropDownAction.addTarget(self, action: #selector(dropdownClicked), for: .touchUpInside)
            if !self.typeUpdate {
                cell.meetTextField.text = "Official"
            }
            
            if self.isfromUpdate {
                let meetObj = self.meetingTypeArray?.filter(
                    {
                        $0 == self.calendarEachEvent?.type
                    }
                )
                if let index = self.meetingTypeArray?.firstIndex(where: { $0 == self.calendarEachEvent?.type}) {
                    selectedRowIrem = index
                }
                
                if !self.typeUpdate {
                    cell.meetTextField.text = meetObj?.first
                }
                
            }
            
            if !self.typeUpdate {
                self.topMeetingTpe = cell.meetTextField.text
            }
            
            
            
            return cell
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetDropDownCell", for: indexPath) as! MeetDropDownCell
            cell.selectionStyle = .none
            items = section3
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            
            let img = UIImage(named: "baseline_date_range_black_24pt")?.withRenderingMode(.alwaysTemplate)
            cell.meetTextField.dropDownButton.setBackgroundImage(img, for: .normal)
            cell.meetTextField.dropDownButton.tintColor = UIColor.MyWall.appColor
            
            cell.meetDropDownAction.addTarget(self, action: #selector(calnderClicked), for: .touchUpInside)
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM/dd/yyyy"
//            let createDateObj = dateFormatter.string(from: NSDate() as Date)
            
            if !self.timeUpdate {
                cell.meetTextField.text = self.selectedDate
            }

            
            if self.isfromUpdate {
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let date: Date? = dateFormatterGet.date(from: self.calendarEachEvent?.date ?? "")
                let dateModify = dateFormatter.string(from: date!)
                if !self.timeUpdate {
                    cell.meetTextField.text = dateModify
                }
            }
            
            if !self.timeUpdate {
                self.topMeetingDate = cell.meetTextField.text
            }
            
            return cell
        }
        
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetDropDownCell", for: indexPath) as! MeetDropDownCell
            cell.selectionStyle = .none
            items = section4
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            
            let img = UIImage(named: "round_access_time_black_24pt")?.withRenderingMode(.alwaysTemplate)
            cell.meetTextField.dropDownButton.setBackgroundImage(img, for: .normal)
            cell.meetTextField.dropDownButton.tintColor = UIColor.MyWall.appColor
            

            let currentDateTime = Foundation.Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            formatter.string(from: currentDateTime)
            let createDateObj = formatter.string(from: NSDate() as Date)
            cell.meetDropDownAction.addTarget(self, action: #selector(startTimeClicked), for: .touchUpInside)
            if !self.startTimeUpdate {
                cell.meetTextField.text = createDateObj
            }
            
            if self.isfromUpdate {
                let startTimeStr = self.calendarEachEvent?.startTime ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromStr = dateFormatter.date(from: startTimeStr)!
                dateFormatter.amSymbol = "am"
                dateFormatter.pmSymbol = "Pm"
                dateFormatter.dateFormat = "HH:mm a"
                let timeFormatter = DateFormatter()
                timeFormatter.dateStyle = .none
                timeFormatter.timeStyle = .short
                let Date12 = timeFormatter.string(from: dateFromStr)
                if !self.startTimeUpdate {
                    cell.meetTextField.text = Date12
                }
                
            }
            
            if !self.startTimeUpdate {
                self.topMeetingStartTime = cell.meetTextField.text
            }

            
            return cell
        }
        
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetDropDownCell", for: indexPath) as! MeetDropDownCell
            cell.selectionStyle = .none
            items = section5
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            
            let img = UIImage(named: "round_access_time_black_24pt")?.withRenderingMode(.alwaysTemplate)
            cell.meetTextField.dropDownButton.setBackgroundImage(img, for: .normal)
            cell.meetTextField.dropDownButton.tintColor = UIColor.MyWall.appColor
            
            let currentDateTime = Foundation.Date()
            let date = currentDateTime.addingTimeInterval(60 * 60)
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            formatter.string(from: date)
            let createDateObj = formatter.string(from: date)
            cell.meetDropDownAction.addTarget(self, action: #selector(endTimeClicked), for: .touchUpInside)
            if !self.endTimeUpdate {
                cell.meetTextField.text = createDateObj
            }

            
            if self.isfromUpdate {
                let startTimeStr = self.calendarEachEvent?.endTime ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromStr = dateFormatter.date(from: startTimeStr)!
                dateFormatter.amSymbol = "am"
                dateFormatter.pmSymbol = "Pm"
                dateFormatter.dateFormat = "HH:mm a"
                let timeFormatter = DateFormatter()
                timeFormatter.dateStyle = .none
                timeFormatter.timeStyle = .short
                let Date12 = timeFormatter.string(from: dateFromStr)
                if !self.endTimeUpdate {
                    cell.meetTextField.text = Date12
                }
            }
            
            if !self.endTimeUpdate {
                self.topMeetingEndTime = cell.meetTextField.text
            }
            
            return cell
        }
        
        if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextEditCell", for: indexPath) as! TextEditCell
            cell.selectionStyle = .none
            items = section6
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            
            cell.titleDescription.delegate = self
            cell.titleDescription.placeholder = "Enter Address"
            
            if self.isfromUpdate {
                cell.titleDescription.text = self.calendarEachEvent?.location ?? ""
            }

            return cell
        }
        if indexPath.section == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextEditCell", for: indexPath) as! TextEditCell
            cell.selectionStyle = .none
            items = section7
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            
            cell.titleDescription.delegate = self
            cell.titleDescription.placeholder = "Enter Department"

            
            if self.isfromUpdate {
                cell.titleDescription.text = self.calendarEachEvent?.department ?? ""
            }
            
            return cell
        }
        
        if indexPath.section == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetDropDownCell", for: indexPath) as! MeetDropDownCell
            cell.selectionStyle = .none
            items = section2
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            
            cell.meetDropDownAction.addTarget(self, action: #selector(dropdownClickedStatus), for: .touchUpInside)
            cell.meetTextField.text = "Scheduled"
            
            if self.isfromUpdate {
                let meetObj = self.meetingStatusArray?.filter(
                    {
                        $0 == self.calendarEachEvent?.status
                    }
                )
                if let index = self.meetingStatusArray?.firstIndex(where: { $0 == self.calendarEachEvent?.status}) {
                    selectedRowIremStatus = index
                }
                cell.meetTextField.text = meetObj?.first
                
            }
            return cell
        }
        if indexPath.section == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextEditCell", for: indexPath) as! TextEditCell
            cell.selectionStyle = .none
            items = section9
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            
            cell.titleDescription.delegate = self
            cell.titleDescription.isUserInteractionEnabled = false
            cell.titleDescription.text = UserManager.sharedInstance.currentUserInfomation?.user.username
            
            if self.isfromUpdate {
                cell.titleDescription.text = self.calendarEachEvent?.createdBy ?? ""
            }
            return cell
        }
        
        if indexPath.section == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetTextViewCell", for: indexPath) as! MeetTextViewCell
            cell.selectionStyle = .none
            items = section10
            let theMenuItem = items[indexPath.item]
            cell.titleLabel.text = theMenuItem.Name
            
            if self.isfromUpdate {
                cell.textView.textColor = UIColor.black
                cell.textView.text = self.calendarEachEvent?.agenda ?? ""
            }
            
            return cell
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 9 {
            return 80
        }
        return 70
    }
    
    
}


extension NewMeetingVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




struct CreateMeetingInfoModel: Codable {
    let meetingInfo: [String: Int?]
    let typesList, statusList: [SList]?
    let momStatusList: [JSONAny]
    let meetingIDIdx: Int?

    enum CodingKeys: String, CodingKey {
        case meetingInfo, typesList, statusList, momStatusList
        case meetingIDIdx = "meetingIdIdx"
    }
}

// MARK: - SList
struct SList: Codable {
    let id, listName, listItem: String?
    let status: String?
}



