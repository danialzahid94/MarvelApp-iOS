//
//  extrasClass.swift
//  MyDocChat
//
//  Created by Danial Zahid on 29/05/15.
//  Copyright (c) 2015 DanialZahid. All rights reserved.
//

import UIKit


class UtilityManager: NSObject {
    
    
    //MARK : - UIImage Methods
    
    static func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0) )
        
        let decodedimage = UIImage(data: decodedData!)
        
        return decodedimage!
        
    }
    
    //MARK: - Date Methods
    
    static func stringFromNSDateWithFormat(date: NSDate, format : String) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(date)
        
    }
    
    static func dateFromStringWithFormat(date: String, format: String) -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.dateFromString(date)!
    }
    
    static func appDateStringFromServer(dateString: String) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = Constant.serverDateFormat
        
        
        let newDateFormatter = NSDateFormatter()
        newDateFormatter.dateFormat = Constant.appDateFormat
        return newDateFormatter.stringFromDate(dateFormatter.dateFromString(dateString)!)
        
    }
    
    static func serverDateFromApp(dateString: String) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = Constant.appDateFormat
        
        
        let newDateFormatter = NSDateFormatter()
        newDateFormatter.dateFormat = Constant.serverDateFormat
        return newDateFormatter.stringFromDate(dateFormatter.dateFromString(dateString)!)
        
    }
    
    static func yearsSinceDate(date: NSDate) -> String{
        
        let calendar = NSCalendar.currentCalendar()
        let unitFlags: NSCalendarUnit = [NSCalendarUnit.Minute, NSCalendarUnit.Hour, NSCalendarUnit.Day, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Second]
        
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components(unitFlags, fromDate: earliest, toDate: latest, options: [])
        
        return ("\(components.year) yrs")
        
    }
    
    static func sizeOfMultiLineString(string: String, font: UIFont, width: Double) -> CGSize{
        
        return (string as NSString).boundingRectWithSize(CGSize(width: width, height: DBL_MAX), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size

    }
    
    
    //MARK: GCD Methods
    
    static func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    //MARK: - Other Methods
    
    static func activityIndicatorForView(view: UIView) -> UIActivityIndicatorView{
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicator.color = UIColor.darkGrayColor()
        activityIndicator.center = view.center
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    static func uniqueKeyWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
  
}


extension String  {
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(format: hash as String)
    }
}
