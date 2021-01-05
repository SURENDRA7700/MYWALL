//
//  myHelper.swift
//  msammon
//
//  Created by Mahroof on 11/11/2018.
//  Copyright © 2018 Mahroof. All rights reserved.
//

import UIKit

class myHelper: NSObject {

    //dev
//    private static let baseUrl = "http://157.245.110.240:8080/socialboard"
    private static let baseUrl = "http://142.93.216.92:8080/socialboard"

        
    public static var userLoginsettingspolicies: String {
        return "\(baseUrl)/settings/user/policies/sysadmin?"
    }
    
    
    public static var userLogin: String {
        return "\(baseUrl)/oauth/token?"
    }
    
    public static var dashboardData: String {
        return "\(baseUrl)/dashboard/data?"
    }
    
    public static var grievanceall: String {
        return "\(baseUrl)/grievance/all?"
    }
    
    public static var grievanceallUnderProcess: String {
        return "\(baseUrl)/grievance/all/Under Process?"
    }
    
    public static var grievanceallSolved: String {
        return "\(baseUrl)/grievance/all/Solved"
    }
    
    public static var grievanceallClosed: String {
        return "\(baseUrl)/grievance/all/Closed"
    }
    
    
    
    public static var Reimbursementall: String {
        return "\(baseUrl)/reimbursement/all/Reimbursement?"
    }
    
    public static var ReimbursementallPending: String {
        return "\(baseUrl)/reimbursement/all/Reimbursement/Pending?"
    }
        
    public static var ReimbursementallSanctioned: String {
        return "\(baseUrl)/reimbursement/all/Reimbursement/Sanctioned?"
    }
    
    public static var ReimbursementallRejected: String {
        return "\(baseUrl)/reimbursement/all/Reimbursement/Rejected?"
    }


    
    
    public static var LOCall: String {
        return "\(baseUrl)/reimbursement/all/LOC?"
    }
    
    public static var LOCallPending: String {
        return "\(baseUrl)/reimbursement/all/LOC/Pending?"
    }
        

    public static var LOOCallSanctioned: String {
        return "\(baseUrl)/reimbursement/all/LOC/Sanctioned?"
    }
    
    public static var LOCallRejected: String {
        return "\(baseUrl)/reimbursement/all/LOC/Rejected?"
    }
    
    
    
    public static var peshi: String {
        return "\(baseUrl)/peshi/all?"
    }
    
    public static var peshiUnderProcess: String {
        return "\(baseUrl)/peshi/all/Under Process?"
    }
    
    public static var peshiallApproved: String {
        return "\(baseUrl)/peshi/all/Approved?"
    }

    
    public static var peshiLieOver: String {
        return "\(baseUrl)/peshi/all/Lie Over?"
    }
    
    public static var peshiallReturned: String {
        return "\(baseUrl)/peshi/all/Returned?"
    }
    
    
    
    
    
    public static var endorsementAll: String {
        return "\(baseUrl)/endorsement/all?"
    }
    
    public static var endosementNew : String {
        return "\(baseUrl)/endorsement/all/New?"
    }
    
    public static var endosementPending : String {
        return "\(baseUrl)/endorsement/all/Pending?"
    }

    public static var endosementDispatched : String {
        return "\(baseUrl)/endorsement/all/Dispatched?"
    }
    
    public static var endosementHold : String {
        return "\(baseUrl)/endorsement/all/Hold?"
    }
    
    public static var endosementLieOver : String {
        return "\(baseUrl)/endorsement/all/Lie Over?"
    }

    
    
    
    
    public static var letterAll: String {
        return "\(baseUrl)/letter/all?"
    }
    
    
    public static var letterNew : String {
        return "\(baseUrl)/letter/all/New?"
    }
    
    public static var letterPending : String {
        return "\(baseUrl)/letter/all/Pending?"
    }

    public static var letterDispatched : String {
        return "\(baseUrl)/letter/all/Dispatched?"
    }
    
    public static var letterHold : String {
        return "\(baseUrl)/letter/all/Hold?"
    }
    
    public static var letterLieOver : String {
        return "\(baseUrl)/letter/all/Lie Over?"
    }
    
    

    
    public static var grievanceaDetails : String {
        return "\(baseUrl)/grievance/view/"
    }
    
    
    public static var reimbursementDetails : String {
        return "\(baseUrl)/reimbursement/view/"
    }
    
    
    public static var peshiDetails : String {
        return "\(baseUrl)/peshi/id/"
    }
    
    
    public static var letterDetails : String {
        return "\(baseUrl)/letter/view/"
    }
    
    
//    http://157.245.110.240:8080/socialboard/endorsement/view/123456 ?access_token=0439c5fe-590b-4831-8331-8f0ed800b1ec
    public static var endorsementDetails : String {
        return "\(baseUrl)/endorsement/view/"
    }
    
    public static var endorsementupdate : String {
        return "\(baseUrl)/endorsement/update"
    }
        
    public static var addTemplateToCart: String {
        return "\(baseUrl)/cart/addTemplateToCart/"
    }
    
    
    public static var getSliderData: String {
        return "\(baseUrl)/sitedata/slider/"
    }
    
    public static var getmeetinginitData: String {
        return "\(baseUrl)/meeting/init/"
    }
    
    public static var getMeetingInfo : String {
        return "\(baseUrl)/meeting/day/"
    }
        
    
    public static var createMeeting : String? {
        return "\(baseUrl)/meeting/create"
    }
    
    public static var updateMeeting : String? {
        return "\(baseUrl)/meeting/update"
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public static var profileUpdate: String {
        return "\(baseUrl)/user/update_profile/"
    }
    
    public static var chnagePssword: String {
        return "\(baseUrl)/user/change_password/"
    }

    public static var getUserAddress: String {
        return "\(baseUrl)/address/list/"
    }

    public static var EditAddress : String{
        return "\(baseUrl)/address/edit/"
    }
    
    public static var AddAddress : String{
        return "\(baseUrl)/address/add/"
    }
    
    public static var get_address_Byid : String{
        return "\(baseUrl)/address/get_address?address_id="
    }
    
    
    public static var getWalletBalance : String {
        return "\(baseUrl)/user/get_wallet_balance/"
    }
    
    public static var getTermsconditions : String {
        return "\(baseUrl)/sitedata/terms_conditions/"
    }

    public static var postContactAdministration : String {
        return "\(baseUrl)/sitedata/contactAdministration"
    }

    public static var getTemplates : String {
           return "\(baseUrl)/cart/getTemplates"
       }
    
    
    public static var getAboutUs : String {
        return "\(baseUrl)/sitedata/aboutus"
    }
        
    
    public static var removeItem : String {
        return "\(baseUrl)/cart/removeItem"
    }
    

    
    public static var getSocialContacts : String {
           return "\(baseUrl)/sitedata/contacts"
       }
    

    public static var getAllOrderList : String {
           return "\(baseUrl)/order/list/"
       }

    public static var getFaq : String {
          return "\(baseUrl)/sitedata/faq/"
      }
    
    
    
    public static var register: String {
        return "\(baseUrl)/user/register/"
    }
    
    public static var home: String {
        return "\(baseUrl)/mobile/Home/"
    }
    
    public static var alldepartments: String {
        return "\(baseUrl)/mobile/Departments/"
    }
    
    public static var alljobs: String {
        return "\(baseUrl)/mobile/JobsbyCategories/"
    }
    public static var applyJob: String {
        return "\(baseUrl)/mobile/applyJob/"
    }
    
    public static var UserJob: String {
        return "\(baseUrl)/mobile/UserJob/"
    }
    
    public static var forgotPWD: String {
        return "\(baseUrl)/mobile/ForgotPassword/"
    }
    
    public static var getorder: String {
          return "\(baseUrl)/mobile/ForgotPassword/"
      }
    
    public static var addToCart: String {
        return "\(baseUrl)/cart/add/"
    }
    public static var getCart: String {
        return "\(baseUrl)/cart/getCart/"
    }
    
    public static var confirmOrder: String {
          return "\(baseUrl)/order/confirm/"
      }
    
    public static var list: String {
             return "\(baseUrl)/order/list/"
         }
    
    
//    https://akel.sa/v4/api/order/confirm

    
//    /cart/add
//    https://areeb.app/api/mobile/ForgotPassword/adam@dnet.sa
//    /mobile/applyJob
//    /mobile/Departments
    
//    public class func isSmallDevice() -> Bool{
//        let deviceName = UIDevice.modelName
//        if deviceName.contains("iPhone 5c") || deviceName.contains("iPhone 5s") || deviceName.contains("iPhone SE"){
//            return true
//        }else{
//            return false
//        }
//    }
    
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    
    public static let customFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    public static let dateTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    
    
   
}
