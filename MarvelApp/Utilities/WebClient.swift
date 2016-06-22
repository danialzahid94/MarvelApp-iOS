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
    
    var timestamp = NSDate.timeIntervalSinceReferenceDate()
    
    //MARK: - Shared Instance
    static let sharedInstance = WebClient(url: NSURL(string: Constant.serverURL)!, securityPolicy: AFSecurityPolicy(pinningMode: AFSSLPinningMode.PublicKey))
    
    
    convenience init(url: NSURL, securityPolicy: AFSecurityPolicy){
        self.init(baseURL: url)
        self.securityPolicy = securityPolicy
    }
    
    func getPath(urlString: String,
        params: [String: AnyObject]?,
        addToken: Bool = true,
        successBlock success:(AnyObject) -> (),
        failureBlock failure: (NSError) -> ()){
            
            
            let manager = AFHTTPSessionManager()
            manager.requestSerializer = AFJSONRequestSerializer()
            manager.responseSerializer = AFJSONResponseSerializer()
            
            manager.GET((NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString)!, parameters: params, progress: { (progress) -> Void in
                }, success: { (sessionTask, responseObject) -> Void in
                    print(responseObject)
                    success(responseObject!)
                }) { (sessionTask, error) -> Void in
                    print(error)
                    failure(error)
            }
            
    }
    
    func getCharacters(params: [String: AnyObject], successBlock success:([String: AnyObject]) -> (),
        failureBlock failure:(String) -> ()) {
            
            self.getPath(URLRouter.getCharacters(), params: self.generateParams(params), successBlock: { (response) -> () in
                success(response as! [String : AnyObject])
                }) { (error: NSError) -> () in
                    failure(error.localizedDescription)
            }
    }
    
    
    //MARK: - Helper Methods
    
    func generateParams(var params: [String: AnyObject]) -> [String: AnyObject]{
        timestamp += 1
        params["apikey"] = Constant.marvelPublicKey
        params["ts"] = "\(timestamp)"
        params["hash"] = "\(timestamp)\(Constant.marvelPrivateKey)\(Constant.marvelPublicKey)".md5
        
        return params
    }
    
   
    
    
        
}
