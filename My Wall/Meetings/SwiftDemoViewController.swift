//
//  SwiftDemoViewController.swift
//  MBCalendarKit
//
//  Created by Moshe on 1/9/15.
//  Copyright (c) 2015 Moshe Berman. All rights reserved.
//

import UIKit


class SwiftDemoViewController: CalendarViewController
{
    var data : [String:[CalendarEvent]] = [:]
    var parentVC = UIViewController()
    var emptyCalendarEventsArray = [CalendarEvent]()
    var CalendarEventsArray = [CalendarEvent]()
    var meetingInfoObj = [GetMeetingModelInfoElement]()
    let activityView = MyActivityView()
    var calendarEachEvent : GetMeetingModelInfoElement? = nil
    
    var selectedDate : String? = ""

    
    required init?(coder aDecoder: NSCoder) {
        
        self.data = [:]
        
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.data = [:]
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserManager.sharedInstance.isfirstTime {
            self.delegate = self
            self.dataSource = self
        }
    }
    
   

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let selDate:String = self.selectedDate else {
            return
        }
        if (selDate == "") {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getMeetingInfo(daateString: selDate) { (meetingInfoArray) in
                self.activityView.dismissLoader()
                self.events = meetingInfoArray;
                if self.events.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    
    
    func getMeetingInfo(daateString: String?,CalendarEvents:@escaping ([CalendarEvent]) -> Void) {
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            CalendarEvents(emptyCalendarEventsArray)
            return
        }
        guard let meetingDate = daateString else {
            CalendarEvents(emptyCalendarEventsArray)
            return
        }
        let catUrl : String  =  myHelper.getMeetingInfo + meetingDate
        activityView.displayLoader()
        let parameters: [String: String] = ["access_token":token]
        ApiService.sharedManager.getServiceWithoutToken(catUrl, parameters) { (urlData) in
            self.activityView.dismissLoader()
            do {
                let rootDicnew = try JSONDecoder().decode(GetMeetingModelInfo.self, from: urlData)
                DispatchQueue.main.async {
                    self.CalendarEventsArray = []
                    self.meetingInfoObj = rootDicnew
                    if rootDicnew.count > 0 {
                        for eachEvent in rootDicnew {
                            var dateMeeting : String = eachEvent.date ?? ""
                            var startTime : String = eachEvent.startTime ?? ""
                            var endTime : String = eachEvent.endTime ?? ""
                            
                            let dateFormatterGet1 = DateFormatter()
                            dateFormatterGet1.dateFormat = "yyyy-MM-dd"
                            let dateinyyyy: Date? = dateFormatterGet1.date(from: dateMeeting)
                            dateFormatterGet1.dateFormat = "dd-MM-yyyy"
                            dateMeeting = dateFormatterGet1.string(from: dateinyyyy!)

                            
                            
                            let dateFormatterPM = DateFormatter()
                            dateFormatterPM.dateFormat = "HH:mm:ss"
                            let dateendTime = dateFormatterPM.date(from: startTime)
                            dateFormatterPM.dateFormat = "hh:mm a"
                            startTime = dateFormatterPM.string(from: dateendTime!)

                            let dateFormatterPMend = DateFormatter()
                            dateFormatterPMend.dateFormat = "HH:mm:ss"
                            let dateendTimeend = dateFormatterPMend.date(from: endTime)
                            dateFormatterPMend.dateFormat = "hh:mm a"
                            endTime = dateFormatterPMend.string(from: dateendTimeend!)
                            
                            let dateFrom = "Start" + " : " + dateMeeting + " " + startTime
                            let dateTo  = "End" + " : " + dateMeeting + " " + endTime
                            let completeDate = dateFrom + "   " + dateTo
                            let dateObj : [String : String] = ["dateFrom":completeDate,
                                                               "address":eachEvent.location ?? "",
                                                               "startTime":dateFrom,
                                                               "endTime":dateTo,
                                                               "status":eachEvent.status ?? ""
                            ]
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let meetingIDObj : String? = String(eachEvent.meetingID ?? 0)
                            let date = dateFormatter.date(from: eachEvent.date ?? "")
                            let event : CalendarEvent = CalendarEvent(title: eachEvent.title ?? "", andDate: date, andInfo: dateObj,withMeetingID : meetingIDObj)
                            self.CalendarEventsArray.append(event)
                        }
                        CalendarEvents(self.CalendarEventsArray)
                        print("")
                    }else{
//                        self.view.makeToast("No meetings found")
                        CalendarEvents(self.emptyCalendarEventsArray)
                    }
                }
            }
            catch (let error) {
                self.activityView.dismissLoader()
                do {
                    self.view.makeToast(error.localizedDescription)
                    CalendarEvents(self.emptyCalendarEventsArray)
                }
                catch {
                    ErrorManager.showErrorAlert(mainTitle: "", subTitle: error.localizedDescription)
                    CalendarEvents(self.emptyCalendarEventsArray)
                }
            }
            
        }
        failure: { (errorString) in
            self.activityView.dismissLoader()
            ErrorManager.showErrorAlert(mainTitle: "", subTitle: errorString)
            CalendarEvents(self.emptyCalendarEventsArray)
        }
    }

    
    
    
  
    override func calendarView(_ calendarView: CalendarView, eventsFor date: Date) -> [CalendarEvent] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateasString = dateFormatter.string(from: date)
        activityView.displayLoader()
        self.getMeetingInfo(daateString: currentDateasString) { (meetingInfoArray) in
            print(meetingInfoArray)
            self.activityView.dismissLoader()
            self.events = meetingInfoArray;
            self.tableView.reloadData()
        }
        return self.emptyCalendarEventsArray
    }
    
    
    // MARK: - CKCalendarDelegate
    
    // Called before the selected date changes.
    override func calendarView(_ calendarView: CalendarView, didSelect date: Date) {
        super.calendarView(calendarView, didSelect: date) // Call super to ensure it
    }
    
    // Called after the selected date changes.
    override func calendarView(_ calendarView: CalendarView, willSelect date: Date) {
        
    }
    
    // A row was selected in the events table. (Use this to push a details view or whatever.)
    override func calendarView(_ calendarView: CalendarView, didSelect event: CalendarEvent) {
        UserManager.sharedInstance.isfirstTime = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let meetingVC = NewMeetingVC()
        meetingVC.parentVC = self
        let  calendarEachEventObj = self.meetingInfoObj.filter (
            {
                ($0.meetingID! == Int(event.meetingID)!) && ($0.title! == event.title!)
                
            }
        )
        meetingVC.calendarEachEvent = calendarEachEventObj.first
        meetingVC.isfromUpdate = true
        
        let dateFormatterSel = DateFormatter()
        dateFormatterSel.dateFormat = "yyyy-MM-dd"
        let dateSel = dateFormatterSel.date(from: (meetingVC.calendarEachEvent?.date)!)
        self.selectedDate = dateFormatterSel.string(from:dateSel!)

        
        let aObjNavi = UINavigationController(rootViewController: meetingVC)
        aObjNavi.modalPresentationStyle = .fullScreen
        self.present(aObjNavi, animated: true, completion: nil)
    }
    
    
    override func calendarViewCreateMeeting(_ calendarView: CalendarView, didSelect date: Date) {
        
        let dateFormatterSel = DateFormatter()
        dateFormatterSel.dateFormat = "yyyy-MM-dd"
        self.selectedDate = dateFormatterSel.string(from: date)

        UserManager.sharedInstance.isfirstTime = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MM/dd/yyyy"
        let createDateObj = dateFormatter.string(from: date)
        print(createDateObj)
        let meetingVC = NewMeetingVC()
        meetingVC.parentVC = self
        meetingVC.isfromUpdate = false
        meetingVC.selectedDate = createDateObj
        let aObjNavi = UINavigationController(rootViewController: meetingVC)
        aObjNavi.modalPresentationStyle = .fullScreen
        self.present(aObjNavi, animated: true, completion: nil)
        
    }
    
}









struct GetMeetingModelInfoElement: Codable {
    let id: String?
    let meetingID: UInt32?
    let title, type, agenda, status: String?
    let date : String?
    let startTime, endTime, location: String?
    let department: String?
    let momStatus, participants: JSONAny?
    let createdBy: String?

    enum CodingKeys: String, CodingKey {
        case id
        case meetingID = "meetingId"
        case title, type, agenda, status, date, startTime, endTime, location, department, momStatus, participants, createdBy
    }
}

typealias GetMeetingModelInfo = [GetMeetingModelInfoElement]

