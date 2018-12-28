//
//  VerificationVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 09/02/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class VerificationVc: UIViewController, UITextFieldDelegate {

@IBOutlet weak var bVerifyBtnOutl: UIButton!
@IBOutlet weak var bOtpField1: UITextField!
@IBOutlet weak var bOtpField2: UITextField!
@IBOutlet weak var bOtpField3: UITextField!
@IBOutlet weak var bOtpField4: UITextField!

let obj = GenFuncs()
let signObj = SignInVc()
private var userApi : UserAPI!
    

    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        obj.roundtheButton(buttonname: bVerifyBtnOutl)
        self.bOtpField1.delegate = self
        self.bOtpField2.delegate = self
        self.bOtpField3.delegate = self
        self.bOtpField4.delegate = self
        self.userApi = UserAPI.sharedInstance
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func bVerifyBtnTapped(_ sender: UIButton) {
        if bOtpField1.text?.isEmpty == false && bOtpField2.text?.isEmpty == false && bOtpField3.text?.isEmpty == false && bOtpField4.text?.isEmpty == false {
            
//            if signObj.userAlreadyExists == true  {
//                if signObj.isCustomer == true {
//                    let homevc = storyboard?.instantiateViewController(withIdentifier: "HomeId") as! HomeVc
//                    self.navigationController?.pushViewController(homevc, animated: true) }
//                    else {
//                        let homevc2 = storyboard?.instantiateViewController(withIdentifier: "Home2Id") as! HomeVc2
//                        self.navigationController?.pushViewController(homevc2, animated: true)
//                    }
//
//                    }
//
//
//            else {
//            let signupvc = storyboard?.instantiateViewController(withIdentifier: "SignUpVcId") as! SignUpVC
//        self.navigationController?.pushViewController(signupvc, animated: true)
//            }
            let otp = bOtpField1.text! + bOtpField2.text! + bOtpField3.text! + bOtpField4.text!
            self.userVerify(userPin: otp)
            
        }
        
        else {
            let alert = UIAlertController(title: "Incomplete OTP", message: "Please enter the complete OTP", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    // MARK: User Verify Function
    func userVerify(userPin:String){
        SVProgressHUD.show(withStatus: "Please Wait")

        let userDict = [ "userId":Constants.kUserDefaults.string(forKey: appConstants.id),
                         "activationCode":userPin]
        userApi.userValidatePin(userDetials: userDict as! Dictionary<String, String>){ (isSuccess,isProfileCompleted ,user,error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                SVProgressHUD.dismiss()
                kAppDelegate.showNotification(text: "Login Successfully")
                if isProfileCompleted {
                  // self.navigateToHome()
                }else{
                  self.navigateToSignUp(user: user)
                }
              
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

  func navigateToSignUp(user:User?) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVcId") as! SignUpVC
        destinationVC.user = user
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //On inputing value to textfield
       if ((textField.text?.count)! < 1  && string.count > 0){
          if(textField == bOtpField1){
               bOtpField2.becomeFirstResponder()
           }
            if(textField == bOtpField2){
                bOtpField3.becomeFirstResponder()
            }
            if(textField == bOtpField3){
                bOtpField4.becomeFirstResponder()
                }
       
        
        if (textField == bOtpField4 ){
           self.view.endEditing(true)
            
            
        }
        
            textField.text = string
       
            return false
        
        
        }else if ((textField.text?.count)! >= 1  && string.count == 0){
            // on deleting value from Textfield
            if(textField == bOtpField2){
                bOtpField1.becomeFirstResponder()
            }
            if(textField == bOtpField3){
                bOtpField2.becomeFirstResponder()
            }
            if(textField == bOtpField4) {
                bOtpField3.becomeFirstResponder()
            }
            textField.text = ""
            return false
        }else if ((textField.text?.count)! >= 1  ){
            textField.text = string
            return false
        }
        return true
    }
    
   
    
    }



