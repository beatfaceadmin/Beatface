//
//  Validators.swift
//  SearchApp
//
//  Created by dEEEP on 07/03/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation
import UIKit


struct validatorConstants{
  static let errorMsg = "Please make sure to enter some input."
  static let customMsg = "Please make sure to enter "
  static let emailMsg =  "Please enter valid email Address."
  static let phoneMsg = "Please enter valid phone number."
  static let passwordConfromMsg = "Make sure you re-enter same password."
}

class Validators: NSObject {
  
  
  //MARK: Validation on any Empty TextField
  func validators(TF1:UITextField,errorMsg:String = validatorConstants.errorMsg,fieldName:String = "") -> Bool {
    var error = validatorConstants.errorMsg
    if fieldName.count > 0 {
      error = validatorConstants.customMsg + fieldName
    }
    if  TF1.text?.isEmpty == true{
       kAppDelegate.showNotification(text: error)
      return false
    }
    return true
  }
  
  //MARK: Validation on any Email TextField
  func validatorEmail(TF1:UITextField,errorMsg:String = validatorConstants.errorMsg ,errorMsgEmail:String = validatorConstants.emailMsg,fieldName:String = "Email" ) -> Bool {
    var error = validatorConstants.errorMsg
    if fieldName.count > 0 {
      error = validatorConstants.customMsg + fieldName
    }
    
    if  TF1.text?.isEmpty == true{
      kAppDelegate.showNotification(text: error)
      return false
    }
    if  TF1.text?.isValidEmail == false{
       kAppDelegate.showNotification(text: errorMsgEmail)
      return false
    }
    return true
  }
  
   //MARK: Validation on any PhoneNumber TextField
  func validatorPhoneNumber(TF1:UITextField,errorMsg:String = validatorConstants.errorMsg ,errorMsgPhone:String = validatorConstants.phoneMsg,fieldName:String = "Phone Number") -> Bool {
    var error = validatorConstants.errorMsg
    if fieldName.count > 0 {
      error = validatorConstants.customMsg + fieldName
    }
    
    if  TF1.text?.isEmpty == true{
      kAppDelegate.showNotification(text: error)
      return false
    }
    if  TF1.text?.isValidPhoneNumber == false{
      kAppDelegate.showNotification(text: errorMsgPhone)
      return false
    }
    return true
  }
  
  //MARK: Validation on any confromPassword TextField
  func validatorConfromPassword(TF1:UITextField,TF2:UITextField,errorMsg:String = validatorConstants.errorMsg,errorMsgPassword:String = validatorConstants.passwordConfromMsg,fieldName:String = "Password") -> Bool {
    
    var error = validatorConstants.errorMsg
    if fieldName.count > 0 {
      error = validatorConstants.customMsg + fieldName
    }
    
    if  TF1.text?.isEmpty == true{
      kAppDelegate.showNotification(text: error)
      return false
    }
    if  TF2.text?.isEmpty == true{
      kAppDelegate.showNotification(text: error)
      return false
    }
    if TF1.text !=  TF2.text {
      kAppDelegate.showNotification(text: errorMsgPassword)
      return false
    }
    return true
  }
  
  
  
  //MARK: Validation on length of charcter on TextFieldDelegate Method
  func validateLength(TF1:UITextField,string:String,range:NSRange,fieldName:String = "",lengthLimit:Int = 30) -> Bool {
    var error = "Max Length for this field is \(lengthLimit)."
    if fieldName.count > 0 {
      error = "Max Length for " + fieldName +  "is \(lengthLimit)."
    }
    
    let currentCharacterCount = TF1.text?.characters.count ?? 0
    let newLength = currentCharacterCount + string.characters.count - range.length
    if newLength == 30{
        kAppDelegate.showNotification(text: error)
    }
    return newLength <= 30
    
  }
  
  
  
  
  
  
  
  

  
  
}
