//
//  Styles.swift
//  LiveFeed
//
//  Created by Danial Zahid on 8/28/15.
//  Copyright © 2015 Arbisoft. All rights reserved.
//

import UIKit

class Styles {
    
    //MARK: - Global Appearance Methods
    
    static func applyGlobalAppearance() {
//        UITabBar.appearance().barTintColor = UIColor(white: 237.0/255.0, alpha: 1.0)
//        UINavigationBar.appearance().tintColor = UIColor(red: 125.0/255.0, green: 156.0/255.0, blue: 175.0/255.0, alpha: 1.0)
    }
    
    //MARK: - View modification methods
    
    static func makeEdgesRounded(view : UIView){
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
    }
    
    //MARK: - Color RGBs -
    
    
    
    
    //MARK: Font Style
    
    static func baseFontWithSize(size : CGFloat) -> UIFont{
    
        return UIFont(name: "OpenSans", size: size)!
    }
    
    //MARK: String Manipulation
    
    static func attributedString(textString : String, font : UIFont, textColor : UIColor = UIColor.blackColor(), isOption: Bool = false) -> NSAttributedString{
        if(isOption) {
            let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: textString, attributes: [NSFontAttributeName : font, NSForegroundColorAttributeName : textColor]))
            attributedString.setAttributes([NSBaselineOffsetAttributeName: 6], range: NSRange(location:0,length:textString.length))
            return attributedString
        }
        return NSAttributedString(string: textString, attributes: [NSFontAttributeName : font, NSForegroundColorAttributeName : textColor])
    }
    
    static func attributedStringAttachment(image : UIImage) -> NSAttributedString{
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        
        return NSAttributedString(attachment: imageAttachment)
    }
}

extension NSAttributedString {
    
    static func joinInNaturalLayout(var attributedStrings : [NSAttributedString], stringsSeperatedBy: String) -> NSAttributedString {
        
        if UIApplication.sharedApplication().userInterfaceLayoutDirection == .RightToLeft {
            attributedStrings = attributedStrings.reverse()
        }
        
        let blankSpace = NSAttributedString(string : stringsSeperatedBy)
        let resultString = NSMutableAttributedString()
        
        for (index,attrString) in attributedStrings.enumerate() {
            if index != 0 {
                resultString.appendAttributedString(blankSpace)
            }
            resultString.appendAttributedString(attrString)
        }
        return resultString
    }
}
