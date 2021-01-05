//
//  UserManager.swift
//  
//
//  Created by Mahroof on 18/11/2018.
//

import UIKit

let LOGGED_USER = "Logged_user"
let ISLOGIN = "isLogin"
let LOGGED_USER_INFO = "Logged_user_Info"
let USERPASSWORD = "userpasssword"

class UserManager: NSObject {
    
    static let sharedInstance = UserManager()
    var isfirstTime : Bool = true
    
    var currentUser : LoginModal? = nil
    
    
    
    var currentUserInfomation : LoginUserModel? = nil


    // set Logged in user and save to user defaults;
    public class func setUserLogin(stUser:LoginModal){

        UserManager.sharedInstance.currentUser = stUser
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(stUser) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: LOGGED_USER)
            defaults.synchronize()
        }
          
        
    }
    
    
    public class func setUserLoginInfo(stUser:LoginUserModel){

        UserManager.sharedInstance.currentUserInfomation = stUser
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(stUser) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: LOGGED_USER_INFO)
            defaults.synchronize()
        }
        
    }
    
    public class func getLoggedUserInfo () -> LoginUserModel?{
        if let savedPerson = defaults.object(forKey: LOGGED_USER_INFO) as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(LoginUserModel.self, from: savedPerson) {
                UserManager.sharedInstance.currentUserInfomation = loadedPerson
                return loadedPerson;
            }
        }
        return nil
    }
    
    
    
    
    public class func setuserLogout()
    {
        UserDefaults.standard.set(nil, forKey: ISLOGIN)
        UserDefaults.standard.set(nil, forKey: LOGGED_USER)
        UserDefaults.standard.set(nil, forKey: LOGGED_USER_INFO)
        UserManager.sharedInstance.currentUser = nil
        UserManager.sharedInstance.currentUserInfomation = nil
        UserDefaults.standard.synchronize()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.displayScreen()
    }

    
    public class func getLoggedUser () -> LoginModal?{
        if let savedPerson = defaults.object(forKey: LOGGED_USER) as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(LoginModal.self, from: savedPerson) {
                UserManager.sharedInstance.currentUser = loadedPerson
                return loadedPerson;
            }
        }
        return nil
    }
    
    
    public class func isUserLoggedin() -> Bool
    {
        if let theUser = UserManager.getLoggedUser(){
            if (theUser.accessToken.utf8.count != 0) {
                UserManager.sharedInstance.currentUser = theUser
                return true
            }else {
                return false
            }
        }else{
            return false;
        }
    }

    
    
    
    public class func getCAddress() -> String?
    {
        if let CAddress = UserDefaults.standard.value(forKey: "CAddress"){
            return (CAddress as! String)
        }else{
            return nil
        }
        
    }
    
    public class func getDepartment_ID() -> String?
    {
        if let Department_ID = UserDefaults.standard.value(forKey: "Department_ID"){
            return (Department_ID as! String)
        }else{
            return nil
        }
        
    }
    
    public class func getCCompanyName() -> String?
    {
        if let CCompanyName = UserDefaults.standard.value(forKey: "CCompanyName"){
            return (CCompanyName as! String)
        }else{
            return nil
        }
        
    }
    
    public class func getCBuildingInfo() -> String?
    {
        if let CBuildingInfo = UserDefaults.standard.value(forKey: "CBuildingInfo"){
            return (CBuildingInfo as! String)
        }else{
            return nil
        }
        
    }
    
    public class func getBalance() -> String?
    {
        if let CBuildingInfo = UserDefaults.standard.value(forKey: "Balance"){
            return (CBuildingInfo as! String)
        }else{
            return nil
        }
        
    }
    public class func Verify_Token() -> String?
    {
        if let Verify_Token = UserDefaults.standard.value(forKey: "Verify_Token"){
            return (Verify_Token as! String)
        }else{
            return nil
        }
        
    }
    
    public class func VerifyPageToken() -> String?
    {
        if let VerifyPageToken = UserDefaults.standard.value(forKey: "Verify_Page_Token"){
            return (VerifyPageToken as! String)
        }else{
            return nil
        }
        
    }
    public class func ResetToken() -> String?
    {
        if let ResetToken = UserDefaults.standard.value(forKey: "Reset_Token"){
            return (ResetToken as! String)
        }else{
            return nil
        }
        
    }
    
    
    
    public class func setUserLoginTemp() {
        let strToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjdXN0b21lcl9pZCI6IjIwIiwiZW1haWwiOiJ0YW56aWxAZG5ldC5zYSIsInBob25lIjoiMDU1Njk4NTIzMCIsImRlcGFydG1lbnRfaWQiOiIxMiJ9.1gxMNAzhZY8pLayPtdf23414M2C3fjrtGX5oQ5XEaM4"
        UserDefaults.standard.set(strToken, forKey: "token")
        //UserDefaults.standard.set(model.token, forKey: "token")
        
    }
    
    
    
    public class func getNationalID() -> String?
    {
        if let userID = UserDefaults.standard.value(forKey: "national_id"){
            return (userID as! String)
        }else{
            return nil
        }
        
    }
    
    public class func getAddress() -> String?
    {
        if let CAddress = UserDefaults.standard.value(forKey: "CAddress"){
            return (CAddress as! String)
        }else{
            return nil
        }
        
    }
    
    
    public class func isEmailVerified() -> Bool
    {
        return (UserDefaults.standard.value(forKey: "Email_Verified") != nil) ? true : false
    }
    
    public class func getIntrests() -> String?
    {
        if let userID = UserDefaults.standard.value(forKey: "interstices"){
            return userID as? String
            
        }else{
            return nil
        }
    }
    
    public class func getDateofBirth() -> String?
    {
        if let userID = UserDefaults.standard.value(forKey: "barthdate"){
            return (userID as! String)
        }else{
            return nil
        }
    }
    
    public class func getYearOfExperience() -> String?
    {
        let userID = UserDefaults.standard.value(forKey: "years_exp")
        return (userID as! String)
    }
    
    public class func getCustomerID() -> String?
    {
        if let userID = UserDefaults.standard.value(forKey: "Customer_ID"){
            return (userID as! String)
        }else{
            return nil
        }
    }
    
    public class func getEmail() -> String?
    {
        if let userID = UserDefaults.standard.value(forKey: "email"){
            return (userID as! String)
        }else{
            return nil
            
        }
    }
    
    public class func getFullName() -> String?
    {
        if let userID = UserDefaults.standard.value(forKey: "name"){
            return (userID as! String)
        }else{
            return nil
        }
    }
    
    public class func getMobile() -> String?
    {
        if let userID = UserDefaults.standard.value(forKey: "phone"){
            return (userID as! String)
        }else{
            return nil
        }
        
    }
    
    public class func getThumb() -> String?
    {
        if let thumb = UserDefaults.standard.value(forKey: "photo_url"){
            return (thumb as! String)
        }else{
            return nil
        }
        
    }
    
    public class func getQRCode() -> String?
    {
        if let qrcode = UserDefaults.standard.value(forKey: "qrcode"){
            return qrcode as? String
        }else{
            return nil
        }
        //        return userID as! String
    }
    
    public class func getCountry() -> String?
    {
        if let qrcode = UserDefaults.standard.value(forKey: "country"){
            return qrcode as? String
        }else{
            return nil
        }
        //        return userID as! String
    }
    
    public class func getGender() -> String?
    {
        if let qrcode = UserDefaults.standard.value(forKey: "gender"){
            return qrcode as? String
        }else{
            return nil
        }
        //        return userID as! String
    }
    
    public class func getCity() -> String?
    {
        if let qrcode = UserDefaults.standard.value(forKey: "city"){
            return qrcode as? String
        }else{
            return nil
        }
    }
    
    public class func getDepartment() -> String?
    {
        if let qrcode = UserDefaults.standard.value(forKey: "specialist"){
            return qrcode as? String
        }else{
            return nil
        }
    }
    public class func getEducation() -> String?
    {
        if let qrcode = UserDefaults.standard.value(forKey: "education"){
            return qrcode as? String
        }else{
            return nil
        }
    }
    
    public class func getToken() -> String?
    {
        if let qrcode = UserDefaults.standard.value(forKey: "basicToken"){
            return qrcode as? String
        }else{
            return nil
        }
    }
    
    
    
    
}
