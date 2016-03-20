//
//  BaseTextField.swift
//  LiveFeed
//
//  Created by Danial Zahid on 9/2/15.
//  Copyright © 2015 Arbisoft. All rights reserved.
//

import UIKit

protocol BaseTextFieldValidationDelegate {
    func textFieldValidationDidChange(isValidated : Bool, textField : BaseTextField)
}

enum BaseTextFieldType : Int {
    case Name
    case PhoneNumber
    case Email
    case Password
    case Year
}

class BaseTextField: UITextField, UITextFieldDelegate {
    
    //MARK: - Variable declarations

    var validationDelegate : BaseTextFieldValidationDelegate!
    var continousValidation : Bool = false
    var validationType : BaseTextFieldType
    var isValid : Bool = false
    
    //MARk: - Init Methods

    required init?(coder aDecoder: NSCoder) {
        self.validationType = BaseTextFieldType.PhoneNumber
        super.init(coder: aDecoder)
        self.delegate = self
        
        self.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.clipsToBounds = false
    
    }
    
    //MARK: - Textfield Delegates
    
    func textFieldDidEndEditing(textField: UITextField) {
        validate()
    }
    
    func textFieldDidChange(textField: BaseTextField) {
        //your code
        if continousValidation {
            
            validate()
            
        }
    }

    //MARK: - Validation Methods
    
    func validate(){
        switch validationType {
        case .Name:
            validateName()
        case .PhoneNumber:
            validatePhoneNumber()
        case .Email:
            validateEmail()
        case .Password:
            validatePassword()
        case .Year:
            validateYear()
        }
        
    }
    
    func validateName(){
        if Regex("^[a-z\\u0600-\\u06ff ]{3,30}$").test(self.text!) {
            fieldValidated()
        }
        else{
            fieldInvalidated()
        }
    }
    
    func validatePhoneNumber(){
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", "^[+]{0,1}[0-9]{11,15}$")
        if phonePredicate.evaluateWithObject(self.text) {
            fieldValidated()
        }
        else{
            fieldInvalidated()
        }
    }
    
    func validateEmail() {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPredicate.evaluateWithObject(self.text) {
            fieldValidated()
        } else {
            fieldInvalidated()
        }
    }
    
    func validatePassword() {
        let passwordRegEx = "[A-Za-z0-9$._%-&]{4,20}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        if passwordPredicate.evaluateWithObject(self.text) {
            fieldValidated()
        } else {
            fieldInvalidated()
        }
    }
    
    func validateYear(){
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{4}$")
        if phonePredicate.evaluateWithObject(self.text) {
            fieldValidated()
        }
        else{
            fieldInvalidated()
        }
    }
    
    func fieldValidated(){
        self.layer.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.2).CGColor
        isValid = true
        self.validationDelegate?.textFieldValidationDidChange(true, textField: self)
    }
    
    func fieldInvalidated(){
        self.layer.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2).CGColor
        isValid = false
        self.validationDelegate?.textFieldValidationDidChange(false, textField: self)
    }
}


class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        
        self.internalExpression = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
    }
    
    func test(input: String) -> Bool {
        let matches = self.internalExpression.matchesInString(input, options: [], range:NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
}
