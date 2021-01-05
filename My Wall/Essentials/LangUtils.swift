//
//  LangUtils.swift
//  Rasedis
//
//  Created by Vijesh on 29/03/2018.
//  Copyright © 2018 DNet. All rights reserved.
//

import Foundation




class LangUtils {
    
    public static let APP_LANGUAGE_KEY = "AppLanguageKeyString"
    public static let english = "en"
    public static let arabic = "ar-SA"
    
    class func isLangArabic() -> Bool {
        return false
        if currentAppLanguage() == LangUtils.arabic {
            return true
        } else {
            return false
        }
//        return true;
    }
    
    class func setAppLAnguageTo(lang: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(lang, forKey: APP_LANGUAGE_KEY)
        userDefaults.synchronize()
    }
    
    class func currentAppLanguage() -> String? {
        let userDefaults = UserDefaults.standard
        if let lang = userDefaults.object(forKey:APP_LANGUAGE_KEY) as? String {
            return lang
        }
        return nil
    }
    
    class func localizedOf(_ stringKey: String?) -> String? {
        return stringKey
    }
   
    
}

