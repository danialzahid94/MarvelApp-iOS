//
//  WebClient.swift
//  MyRxReminder
//
//  Created by Danial Zahid on 12/26/15.
//  Copyright © 2015 Danial Zahid. All rights reserved.
//

import UIKit

let RequestManager = WebClient.sharedInstance

class WebClient: AFHTTPSessionManager {
    
    //MARK: - Shared Instance
    static let sharedInstance = WebClient(url: NSURL(string: Constant.serverURL)!, securityPolicy: AFSecurityPolicy(pinningMode: AFSSLPinningMode.PublicKey))
    
    
    convenience init(url: NSURL, securityPolicy: AFSecurityPolicy){
        self.init(baseURL: url)
        self.securityPolicy = securityPolicy
    }
    
    
    func postPath(urlString: String,
        params: [String: AnyObject],
        addToken: Bool = true,
        successBlock success:(AnyObject) -> (),
        failureBlock failure: (NSError) -> ()){
            
            
            let manager = AFHTTPSessionManager()
            manager.requestSerializer = AFHTTPRequestSerializer()
            manager.responseSerializer = AFJSONResponseSerializer()
            
            if let email = NSUserDefaults.standardUserDefaults().valueForKey("emailAddress") as? String, auth_token = NSUserDefaults.standardUserDefaults().valueForKey("authentication_token") as? String {
                manager.requestSerializer.setValue(email, forHTTPHeaderField: "emailAddress")
                manager.requestSerializer.setValue(auth_token, forHTTPHeaderField: "authenticationToken")
            }
            
            manager.POST((NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString)!, parameters: params, progress: { (progress) -> Void in
                }, success: { (sessionTask, responseObject) -> Void in
                    print(responseObject)
                    success(responseObject!)
                }) { (sessionTask, error) -> Void in
                    print(error)
                    failure(error)
            }
    }
    
    func putPath(urlString: String,
        params: [String: AnyObject],
        addToken: Bool = true,
        successBlock success:(AnyObject) -> (),
        failureBlock failure: (NSError) -> ()){
            
            
            let manager = AFHTTPSessionManager()
            manager.requestSerializer = AFJSONRequestSerializer()
            manager.responseSerializer = AFJSONResponseSerializer()
            
            if let email = NSUserDefaults.standardUserDefaults().valueForKey("emailAddress") as? String, auth_token = NSUserDefaults.standardUserDefaults().valueForKey("authentication_token") as? String {
                manager.requestSerializer.setValue(email, forHTTPHeaderField: "emailAddress")
                manager.requestSerializer.setValue(auth_token, forHTTPHeaderField: "authenticationToken")
            }
            
            manager.PUT((NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString)!, parameters: params, success: {
                (sessionTask, responseObject) -> () in
                print(responseObject)
                success(responseObject!)
                }, failure: {
                    (sessionTask, error) -> () in
                    print(error)
                    failure(error)
                    
            })
    }
    
    func patchPath(urlString: String,
        params: [String: AnyObject],
        addToken: Bool = true,
        successBlock success:(AnyObject) -> (),
        failureBlock failure: (NSError) -> ()){
            
            
            let manager = AFHTTPSessionManager()
            manager.requestSerializer = AFJSONRequestSerializer()
            manager.responseSerializer = AFJSONResponseSerializer()
            
            if let email = NSUserDefaults.standardUserDefaults().valueForKey("emailAddress") as? String, auth_token = NSUserDefaults.standardUserDefaults().valueForKey("authentication_token") as? String {
                manager.requestSerializer.setValue(email, forHTTPHeaderField: "emailAddress")
                manager.requestSerializer.setValue(auth_token, forHTTPHeaderField: "authenticationToken")
            }
            
            manager.PATCH((NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString)!, parameters: params, success: {
                (sessionTask, responseObject) -> () in
                print(responseObject)
                success(responseObject!)
                }, failure: {
                    (sessionTask, error) -> () in
                    print(error)
                    failure(error)
                    
            })
            
    }
    
    func getPath(urlString: String,
        params: [String: AnyObject]?,
        addToken: Bool = true,
        successBlock success:(AnyObject) -> (),
        failureBlock failure: (NSError) -> ()){
            
            
            let manager = AFHTTPSessionManager()
            manager.requestSerializer = AFJSONRequestSerializer()
            manager.responseSerializer = AFJSONResponseSerializer()
            
            if let email = NSUserDefaults.standardUserDefaults().valueForKey("emailAddress") as? String, auth_token = NSUserDefaults.standardUserDefaults().valueForKey("authentication_token") as? String {
                manager.requestSerializer.setValue(email, forHTTPHeaderField: "emailAddress")
                manager.requestSerializer.setValue(auth_token, forHTTPHeaderField: "authenticationToken")
            }
            
            manager.GET((NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString)!, parameters: params, progress: { (progress) -> Void in
                }, success: { (sessionTask, responseObject) -> Void in
                    print(responseObject)
                    success(responseObject!)
                }) { (sessionTask, error) -> Void in
                    print(error)
                    failure(error)
            }
            
    }
    
    func deletePath(urlString: String,
        params: [String: AnyObject],
        addToken: Bool = true,
        successBlock success:(AnyObject) -> (),
        failureBlock failure: (NSError) -> ()){
            
            let manager = AFHTTPSessionManager()
            manager.requestSerializer = AFJSONRequestSerializer()
            manager.responseSerializer = AFJSONResponseSerializer()
            
            if let email = NSUserDefaults.standardUserDefaults().valueForKey("emailAddress") as? String, auth_token = NSUserDefaults.standardUserDefaults().valueForKey("authentication_token") as? String {
                manager.requestSerializer.setValue(email, forHTTPHeaderField: "emailAddress")
                manager.requestSerializer.setValue(auth_token, forHTTPHeaderField: "authenticationToken")
            }
            
            manager.DELETE((NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString)!, parameters: params, success: {
                (sessionTask, responseObject) -> () in
                print(responseObject)
                success(responseObject!)
                }, failure: {
                    (sessionTask, error) -> () in
                    print(error)
                    failure(error)
                    
            })
    }
    
    func getUserLinkedInProfile(access_token: String,
        successBlock success:([String: AnyObject]) -> (),
        failureBlock failure:(String) -> ()){
            
            self.getPath("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,maiden-name,email-address,headline,public-profile-url,picture-url)?oauth2_access_token=\(access_token)&format=json&secure-urls=true",
                params: nil,addToken: false, successBlock: { (response) -> () in
                success(response as! [String : AnyObject])
                }) { (error: NSError) -> () in
                    failure(error.localizedDescription)
            }
    }
    
    func loginUser(params: [String: AnyObject],
        successBlock success:([String: AnyObject]) -> (),
        failureBlock failure:(String) -> ()){
            
            self.postPath(Constant.loginUserURL, params: params, addToken: false, successBlock: { (response) -> () in
                    success(response as! [String : AnyObject])
                }) { (error: NSError) -> () in
                    failure(error.localizedDescription)
            }
    }
    
    func getLoggedInUser(successBlock success:([String: AnyObject]) -> (),
        failureBlock failure:(String) -> ()) {
            
            let url = "\(Constant.userURL)\(NSUserDefaults.standardUserDefaults().valueForKey("userID")!).json"
            
            self.getPath(url, params: nil, successBlock: { (response) -> () in
                success(response as! [String : AnyObject])
                }) { (error: NSError) -> () in
                    failure(error.localizedDescription)
            }
    }
    
    func getInterestFields(successBlock success:([[String: AnyObject]]) -> (),
        failureBlock failure:(String) -> ()) {
            
            self.getPath(Constant.interestFieldsURL, params: nil, successBlock: { (response) -> () in
                success(response as! [[String : AnyObject]])
                }) { (error: NSError) -> () in
                    failure(error.localizedDescription)
            }
    }
    
    
        
}
