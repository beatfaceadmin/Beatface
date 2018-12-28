 //
//  SignInVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 09/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import SVProgressHUD


class SignInVc: UIViewController, UITextFieldDelegate, CountryPickerDelegate  {
    
    @IBOutlet weak var bSignInOutl: UIButton!
    @IBOutlet weak var bMobileNoField: UITextField!
    @IBOutlet weak var bCountryCodeField: UITextField!
  var picker = CountryPicker()
    
    let obj = GenFuncs()
    var userAlreadyExists = false
    private var userApi : UserAPI!
    
    var isCustomer = true //true for customer, false for artist
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.userApi = UserAPI.sharedInstance
        obj.roundtheButton(buttonname: bSignInOutl)
        self.bMobileNoField.delegate = self
      let locale = Locale.current
      let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
//      let theme = CountryViewTheme(countryCodeTextColor: .white, countryNameTextColor: .white, rowBackgroundColor: .black, showFlagsBorder: false)        //optional for UIPickerView theme changes
//      picker.theme = theme //optional for UIPickerView theme changes
      picker.countryPickerDelegate = self
      picker.showPhoneNumbers = true
      picker.setCountry(code!)
      bCountryCodeField.inputView = picker
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  
  // a picker item was selected
  func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
    //pick up anythink
   bCountryCodeField.text = phoneCode
    bCountryCodeField.resignFirstResponder()
  }
    
    
    // Allowing only digits in text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn : string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    @IBAction func bBackBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bSigninBtn(_ sender: UIButton) {
     
        if  self.validator() == true{
            let userDict = [appConstants.phone : bCountryCodeField.text! as String + bMobileNoField.text! as String,
                            appConstants.deviceType: "iOS",
                            appConstants.deviceId: "21930"] as [String : Any]
            self.userSignIn(userDict: userDict as Dictionary<String, AnyObject>)
        }
        
    }
    

    // MARK: User SignIn Function
    func userSignIn(userDict:Dictionary<String, AnyObject>)
    
    {
                SVProgressHUD.show(withStatus: "Please Wait")
        userApi.userSignUp(userDetials: userDict as Dictionary<String, AnyObject> ){ (isSuccess,response, error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                SVProgressHUD.dismiss()
              Constants.kUserDefaults.set(self.bCountryCodeField.text! as String + self.bMobileNoField.text! as String, forKey: appConstants.phone)
                self.navigateToVerification()
            }else{
                SVProgressHUD.dismiss()
                if error != nil{
                    kAppDelegate.showNotification(text: error!)
                }else{
                    kAppDelegate.showNotification(text: "Something went wrong!")
                }
            }
            
        }
        
        
    }
    
    
    
    func navigateToVerification() {
        let verificationvc = storyboard?.instantiateViewController(withIdentifier: "VerificationVcId") as! VerificationVc
        self.navigationController?.pushViewController(verificationvc, animated: true)
    }
    
    func validator() -> Bool {
        if bMobileNoField.text?.isEmpty == true && bCountryCodeField.text?.isEmpty == true{
          
            kAppDelegate.showNotification(text: "Please make sure the number is valid")
            return false
        }
        if bMobileNoField.text?.isEmpty == true && bMobileNoField.text?.isValidPhoneNumber  == false{
            kAppDelegate.showNotification(text: "Please make sure to enter valid number.")
            return false
        }
        if bCountryCodeField.text?.isEmpty == true {
            kAppDelegate.showNotification(text: "Please make sure to enter country code.")
             return false
        }
        return true
    }
    
}
