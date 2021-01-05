//
//  ApiService.swift
//  8020
//
//  Created by Vijesh on 21/06/18.
//  Copyright © 2018 DNet. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration


let defaults = UserDefaults.standard
let kToken = "token"

class ApiService: NSObject {
    
    static let sharedManager = ApiService()
    private var alamoFireManager: SessionManager?
    private func initAlamoFireManager() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 15
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    
    func getServiceWithToken(_ url: String?, success:@escaping (Data) -> Void, failure:@escaping (String?) -> Void)
    {
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }
        initAlamoFireManager()
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Accept": "application/json"
        ]
        Alamofire.request(url!, headers: headers).responseJSON { response in
            switch response.result {
            
            case .success:
                let val = String(data: response.data!, encoding: String.Encoding.utf8)
//                print(val ?? "")
                
                // make sure we got some JSON since that's what we expect
                guard let urlData = response.data else {
                    DispatchQueue.main.async {
                        failure("Something went wrong");
                    }
                    return
                }
                DispatchQueue.main.async {
                    success(urlData);
                }
                
                break
                
            case .failure(let error):
                var localizedErrorDescription: String?
                switch (error._code){
                case NSURLErrorTimedOut:
                    localizedErrorDescription =  "something went wrong"
                    print("timed out error")
                    break
                    
                case NSURLErrorNotConnectedToInternet:
                    localizedErrorDescription = "Please check your interent connection"
                    print("offline error")
                    break
                    
                default:
                    localizedErrorDescription = "something went wrong"
                    print("unknown error")
                    break
                }
                DispatchQueue.main.async {
                    failure(localizedErrorDescription)
                }
                break
            }
        }
    }
    
    
    func getServiceWithoutToken(_ url: String?, _ parameters: [String: String]?,success:@escaping (Data) -> Void, failure:@escaping (String?) -> Void) {
        
        guard let urlwithPercentEscapes = url?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            failure("Something went wrong");
            return
        }
        
        guard let urlEndPoint = URL(string: urlwithPercentEscapes) else {
            failure("Something went wrong");
            return
        }
        
        initAlamoFireManager()
        
        alamoFireManager?.request(urlEndPoint, method: .get,parameters: parameters)
            .validate(contentType: ["application/json"])
            .responseData { (response) in
                
                switch response.result {
                
                case .success:
                    
                    let val = String(data: response.data!, encoding: String.Encoding.utf8)
                    print(val ?? "")
                    
                    // make sure we got some JSON since that's what we expect
                    guard let urlData = response.data else {
                        print("didn't get valid data from server")
                        print("Error: \(String(describing: response.result.error))")
                        DispatchQueue.main.async {
                            failure("Something went wrong");
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        success(urlData);
                    }
                    
                    break
                    
                case .failure(let error):
                    
                    var localizedErrorDescription: String?
                    switch (error._code){
                    
                    case NSURLErrorTimedOut:
                        localizedErrorDescription =  "something went wrong"
                        print("timed out error")
                        break
                        
                    case NSURLErrorNotConnectedToInternet:
                        localizedErrorDescription = "Please check your interent connection"
                        print("offline error")
                        break
                        
                    default:
                        localizedErrorDescription = "something went wrong"
                        print("unknown error")
                        break
                    }
                    
                    DispatchQueue.main.async {
                        failure(localizedErrorDescription)
                    }
                    
                    break
                }
            }
    }
    
    
    func startPostApiServiceWithToken(_ url: String?, _ parameters: [String: Any]?, success:@escaping (Data) -> Void, failure:@escaping (String?) -> Void) {
        guard let urlwithPercentEscapes = url?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            
            return
        }
        guard let urlEndPoint = URL(string: urlwithPercentEscapes) else {
           
            return
        }
        initAlamoFireManager()
        guard let token:String = UserManager.getToken() else {
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Accept": "application/json"
        ]
        alamoFireManager?.request(urlEndPoint, method: .post, parameters: parameters,headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("success")
                    let val = String(data: response.data!, encoding: String.Encoding.utf8)
                    
//                    print(val ?? "")
                    // make sure we got some JSON since that's what we expect
                    if let urlData = response.data {
                        DispatchQueue.main.async {
                            success(urlData);
                        }
                    } else {
                        print("didn't get valid data from server")
                        print("Error: \(String(describing: response.result.error))")
                        DispatchQueue.main.async {
                            failure("something went wrong");
                        }
                    }
                    break
                case .failure(let error):
                    
                    var localizedErrorDescription: String?
                    switch (error._code){
                    
                    case NSURLErrorTimedOut:
                        localizedErrorDescription = "Something went wrong"
                        print("timed out error")
                        break
                        
                    case NSURLErrorNotConnectedToInternet:
                        localizedErrorDescription = "Please check your interent connection"
                        print("offline error")
                        break
                        
                    default:
                        localizedErrorDescription = "Something went wrong"
                        print("unknown error")
                        break
                    }
                    
                    DispatchQueue.main.async {
                        failure(localizedErrorDescription)
                    }
                    
                    break
                }
            }
    }
    
    func startPostApiServiceWithBearerTokenWithRawData(_ url: String?, _ parameters: [String: Any]?, success:@escaping (Data) -> Void, failure:@escaping (String?) -> Void) {
        guard let urlwithPercentEscapes = url?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            failure("something went wrong");
            return
        }
        guard let urlEndPoint = URL(string: urlwithPercentEscapes) else {
            failure("something went wrong");
            return
        }
        initAlamoFireManager()
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }
        
        var request = URLRequest(url: urlEndPoint)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        var data = Data()
        do {
            data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }catch {
            print(error.localizedDescription)
        }
        request.httpBody = data

        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .success:
                let val = String(data: response.data!, encoding: String.Encoding.utf8)
                
//                print(val ?? "")
                // make sure we got some JSON since that's what we expect
                if let urlData = response.data {
                    DispatchQueue.main.async {
                        success(urlData)
                    }
                } else {
                    print("didn't get valid data from server")
                    print("Error: \(String(describing: response.result.error))")
                    DispatchQueue.main.async {
                        failure("something went wrong");
                    }
                }
                break
            case .failure(let error):
                
                var localizedErrorDescription: String?
                switch (error._code){
                
                case NSURLErrorTimedOut:
                    localizedErrorDescription = "Something went wrong"
                    print("timed out error")
                    break
                    
                case NSURLErrorNotConnectedToInternet:
                    localizedErrorDescription = "Please check your interent connection"
                    print("offline error")
                    break
                    
                default:
                    localizedErrorDescription = "Something went wrong"
                    print("unknown error")
                    break
                }
                
                DispatchQueue.main.async {
                    failure(localizedErrorDescription)
                }
                
                break
            }
        }
    }

        
        
    
    func startPostApiServiceWithBearerToken(_ url: String?, _ parameters: [String: Any]?, success:@escaping (Data) -> Void, failure:@escaping (String?) -> Void) {
        guard let urlwithPercentEscapes = url?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            failure("something went wrong");
            return
        }
        guard let urlEndPoint = URL(string: urlwithPercentEscapes) else {
            failure("something went wrong");
            return
        }
        initAlamoFireManager()
        guard let token:String = UserManager.sharedInstance.currentUser?.accessToken else {
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Accept": "application/json"
        ]
        alamoFireManager?.request(urlEndPoint, method: .post, parameters: parameters,headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("success")
                    let val = String(data: response.data!, encoding: String.Encoding.utf8)
                    
                    print(val ?? "")
                    // make sure we got some JSON since that's what we expect
                    if let urlData = response.data {
                        DispatchQueue.main.async {
                            success(urlData);
                        }
                    } else {
                        print("didn't get valid data from server")
                        print("Error: \(String(describing: response.result.error))")
                        DispatchQueue.main.async {
                            failure("something went wrong");
                        }
                    }
                    break
                case .failure(let error):
                    
                    var localizedErrorDescription: String?
                    switch (error._code){
                    
                    case NSURLErrorTimedOut:
                        localizedErrorDescription = "Something went wrong"
                        print("timed out error")
                        break
                        
                    case NSURLErrorNotConnectedToInternet:
                        localizedErrorDescription = "Please check your interent connection"
                        print("offline error")
                        break
                        
                    default:
                        localizedErrorDescription = "Something went wrong"
                        print("unknown error")
                        break
                    }
                    
                    DispatchQueue.main.async {
                        failure(localizedErrorDescription)
                    }
                    
                    break
                }
            }
    }

    
    
    
    func startPostApiService(_ url: String?, _ parameters: [String: String], success:@escaping (Data) -> Void, failure:@escaping (String?) -> Void) {
        
        
        guard let urlwithPercentEscapes = url?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            failure("something went wrong");
            return
        }
        
        
        guard let urlEndPoint = URL(string: urlwithPercentEscapes) else {
            failure("something went wrong");
            return
        }
        
        initAlamoFireManager()
        
        alamoFireManager?.request(urlEndPoint, method: .post, parameters: parameters)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                
                
                switch response.result {
                case .success:
                    print("success")
                    let val = String(data: response.data!, encoding: String.Encoding.utf8)
                    print(val ?? "")
                    
                    // make sure we got some JSON since that's what we expect
                    if let urlData = response.data {
                        DispatchQueue.main.async {
                            success(urlData);
                        }
                    } else {
                        print("didn't get valid data from server")
                        print("Error: \(String(describing: response.result.error))")
                        DispatchQueue.main.async {
                            failure("something went wrong");
                        }
                    }
                    
                    
                    break
                    
                    
                    
                case .failure(let error):
                    
                    var localizedErrorDescription: String?
                    switch (error._code){
                    
                    case NSURLErrorTimedOut:
                        localizedErrorDescription = "Something went wrong"
                        print("timed out error")
                        break
                        
                    case NSURLErrorNotConnectedToInternet:
                        localizedErrorDescription = "Please check your interent connection"
                        print("offline error")
                        break
                        
                    default:
                        localizedErrorDescription = "Something went wrong"
                        print("unknown error")
                        break
                    }
                    
                    DispatchQueue.main.async {
                        failure(localizedErrorDescription)
                    }
                    
                    break
                }
            }
    }
    
    
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
}



struct ErrorModel: Codable {
    let error, errorDescription: String?

    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
    }
}
