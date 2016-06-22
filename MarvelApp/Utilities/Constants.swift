//
//  Constants.swift
//  FireTester
//
//  Created by Danial Zahid on 30/07/2015.
//  Copyright (c) 2015 Danial Zahid. All rights reserved.
//

import UIKit

public class Constant: NSObject {

    static let applicationName = "Marvel App"
    static let serverDateFormat = "yyyy-MM-dd"
    static let appDateFormat = "MM/dd/yyyy"
    static let animationDuration : NSTimeInterval = 0.5
    
    static let serverURL = "http://gateway.marvel.com/"
    
    static let marvelPublicKey = "de506a78557e88e97c75adb369369918"
    static let marvelPrivateKey = "1a4368315953f4e80160546109d02fb3a96f3693"
    
}


public class URLRouter: NSObject {
    static func getCharacters() -> String{
        return "v1/public/characters"
    }
}