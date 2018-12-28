//
//  UserAPI.swift
//  AQUA
//
//  Created by Krishna on 05/04/17.
//  Copyright © 2017 MindfulSas. All rights reserved.
//

import Foundation


/**
 UserSignIn API contains the endpoints to Create/Read/Update Logged in UserProfiles.
 */

class UserAPI{
    
    private let userRemoteReplicator: UserRemoteReplicator!
   
    
    //Utilize Singleton pattern by instanciating UserAPI only once.
    class var sharedInstance: UserAPI {
        struct Singleton {
            static let instance = UserAPI()
        }
        return Singleton.instance
    }
    
    init(){
        self.userRemoteReplicator = UserRemoteReplicator()
        
    }
    
    
    // MARK: SignIn
    func userSignUp(userDetials: Dictionary<String, AnyObject> , callback:@escaping (_ isSuccess:Bool , _ responseData:  Dictionary<String, AnyObject>? , _ error: String? ) -> Void)   {
        userRemoteReplicator.userSignUp(userDetials: userDetials){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
                    Constants.kUserDefaults.set(data[appConstants.id] , forKey: appConstants.id)
                    
                   
                  
                    callback(true,responseData,nil)
                }else{
                    callback(false,responseData,responseData!["error"] as? String)
                }
            }
            
        }
    
    }
  
  // MARK: Update Profile
  func userUpdateProfile(userDetials: User , callback:@escaping (_ isSuccess:Bool , _ responseData:  Dictionary<String, AnyObject>? , _ error: String? ) -> Void)   {
    userRemoteReplicator.userUpdateProfile(userDetials: userDetials.dictionaryRepresentation() as! Dictionary<String, AnyObject>, userID : String(describing: userDetials.id!) ){ (responseData, error) -> Void in
      if responseData != nil {
        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
          let dataProfile = NSKeyedArchiver.archivedData(withRootObject: data)
          Constants.kUserDefaults.set(dataProfile, forKey: appConstants.profile)
          
          
          
          
          
          callback(true,responseData,nil)
        }else{
          callback(false,responseData,responseData!["error"] as? String)
        }
      }
      
    }
    
  }
  
  
  //MARK:-- Get User By Id From Remote
  func getUserByID(Id:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
  {
    userRemoteReplicator.getUserByID(query: Id) { (Data, error) in
      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
        callback(Data! , nil)
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }
  
    
//    // MARK: Create User
//    func userSignUp(userDetials: Dictionary<String, AnyObject> , callback:@escaping ( _ successResponse: Bool, _ error: String? ) -> Void)   {
//
//        userRemoteReplicator.userSignUp(userDetials: userDetials){ (responseData, error) -> Void in
//            if responseData != nil{
//                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//
//                    if let data = responseData?[APIConstants.data.rawValue]! as? Dictionary<String, AnyObject>!{
//                        Constants.kUserDefaults.setValue(data["id"], forKey: appConstants.id)
//                    }
//                    callback(true,nil)
//                }else{
//                    print(responseData!["error"]!)
//                    callback(false,responseData!["error"] as? String)
//                }
//            }else{
//                callback(false,responseData!["error"] as? String)
//            }
//
//        }
//
//    }
//
 //MARK: ValidatePin
  func userValidatePin(userDetials: Dictionary<String, String> , callback:@escaping (_ successResponse: Bool, _ isProfileComplete:Bool, _ user:User?, _ error: String? ) -> Void)   {

        userRemoteReplicator.userVarificationCode(userDetials:userDetials as Dictionary<String, AnyObject>){ (responseData, error) -> Void in

            if responseData != nil{
                if  responseData![APIConstants.isSuccess.rawValue] as! Bool == true{
                    let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
                    Constants.kUserDefaults.set(data[appConstants.token], forKey: appConstants.token)
                  let dataProfile = NSKeyedArchiver.archivedData(withRootObject: data)
                  Constants.kUserDefaults.set(dataProfile, forKey: appConstants.profile)
                  
                  let user = User.init(dictionary: data as NSDictionary)
                  
                    callback(true,false,user,nil)
                }else{
                    callback(false,false,nil,responseData!["error"] as? String)
                }
            }else{
                callback(false,false,nil,"Something went wrong!")
            }
        }

    }
//
//
//    //MARK:- Resend Code
//    func resendVarificationCode(userDetials: Dictionary<String, String>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void) {
//        userRemoteReplicator.resendVarificationCode(userDetials: userDetials) { (responseData, error) in
//            if responseData != nil{
//                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
//                    let data = responseData?[APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//                    Constants.kUserDefaults.set(data["id"]!,forKey: appConstants.id)
//                    print(Constants.kUserDefaults.value(forKey: "id")!)
//                    callback(responseData , nil)
//                }
//                else{
//                    callback(responseData, responseData!["error"] as? String)
//                }
//            }
//        }
//    }
//
//
//
//    //MARK:- Update User Password
//
//    func updateUserPassword(employeeId:NSNumber,userDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//        userRemoteReplicator.updateUserPassword(employeeId: employeeId, userDetials: userDetials) { (responseData, error) in
//            if responseData != nil{
//                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
//                   // let data = responseData?[APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//
//                    callback(responseData , nil)
//                }
//                else{
//                    callback(responseData, responseData!["error"] as? String)
//                }
//            }
//
//        }
//    }
//    //MARK:- Report a bug
//
//    func reportBug(detail:Dictionary<String,AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//        userRemoteReplicator.reportBug(detail:detail) { (responseData, error) in
//            if responseData != nil{
//                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
//                    // let data = responseData?[APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//
//                    callback(responseData , nil)
//                }
//                else{
//                    callback(responseData, responseData!["error"] as? String)
//                }
//            }
//
//        }
//
//    }
//
//
//  //MARK:- UserManualCheckIn/CheckOut
//  func userManualAttendence(detail:Dictionary<String,Any>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//    userRemoteReplicator.manualCheckInCheckOut(details:detail) { (responseData, error) in
//      if responseData != nil{
//        if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
//          // let data = responseData?[APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//          callback(responseData , nil)
//        }
//        else{
//          callback(responseData, responseData!["error"] as? String)
//        }
//      }
//
//    }
//
//  }
//
//
//
//    //MARK:- Getting External token for AMS
//
//    func getExternalToken(callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//        userRemoteReplicator.getExternalToken { (responseData, error ) in
//            if responseData != nil{
//                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
//                    let data = responseData?["data"]
//                    Constants.kUserDefaults.set(data?["token"]!, forKey: appConstants.token)
//                    Constants.kUserDefaults.set(data?["id"]!, forKey: appConstants.id)
//                    Constants.kUserDefaults.setValue(true, forKey: appConstants.alreadyLoggedIn)
//                    let empty = NSNull()
//                    if let name = data?["name"] as? String, !name.isEqual(empty), name != ""  {
//                        Constants.kUserDefaults.set(name , forKey: "name")
//
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "name")
//
//                    }
//                    if let designation = data?["designation"] as? String, !designation.isEqual(empty) , designation != "" {
//                        Constants.kUserDefaults.set(designation , forKey: "designation")
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "designation")
//
//                    }
//                    if let picUrl = data?["picUrl"] as? String, !picUrl.isEqual(empty), picUrl != ""  {
//                        Constants.kUserDefaults.set(picUrl as String, forKey: "picUrl")
//                    }
//                    if let email = data?["email"] as? String, !email.isEqual(empty) , email != "" {
//                        Constants.kUserDefaults.set(email as String, forKey: "email")
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "email")
//
//                    }
//                    if let phone = data?["phone"] as? String, !phone.isEqual(empty) , phone != "" {
//                        Constants.kUserDefaults.set(phone as String, forKey: "phone")
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "phone")
//
//                    }
//                    if let code = data?["code"] as? String, !code.isEqual(empty) , code != "" {
//                        Constants.kUserDefaults.set(code as String, forKey: "code")
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "code")
//
//                    }
//
//
//                    callback(responseData , nil)
//                }
//                else{
//                    callback(responseData, responseData!["error"] as? String)
//                }
//            }
//
//        }
//
//    }
//
//    //MARK:- Sign in with tunnel
//    func signInWithTunnel(callback:@escaping(_ responsedata: Dictionary<String,AnyObject>?, _ error: String?) -> Void){
//        let tokenValue = Constants.kUserDefaults.value(forKey: appConstants.orgToken)
//        Constants.kUserDefaults.set(tokenValue, forKey: appConstants.loggedInExternalOrgToken)
//        Constants.kUserDefaults.set(tokenValue, forKey: appConstants.token)
//        userRemoteReplicator.signInWithTunnel { (responseData, error ) in
//            if responseData != nil{
//                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
//                    let data = responseData?["data"]
//                    Constants.kUserDefaults.set(data?["token"]!, forKey: appConstants.token)
//                    Constants.kUserDefaults.set(data?["id"]!, forKey: appConstants.id)
//                    Constants.kUserDefaults.setValue(true, forKey: appConstants.alreadyLoggedIn)
//                    let empty = NSNull()
//                    if let name = data?["name"] as? String, !name.isEqual(empty), name != ""  {
//                        Constants.kUserDefaults.set(name , forKey: "name")
//
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "name")
//
//                    }
//                    if let designation = data?["designation"] as? String, !designation.isEqual(empty) , designation != "" {
//                        Constants.kUserDefaults.set(designation , forKey: "designation")
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "designation")
//
//                    }
//                    if let picUrl = data?["picUrl"] as? String, !picUrl.isEqual(empty), picUrl != ""  {
//                        Constants.kUserDefaults.set(picUrl as String, forKey: "picUrl")
//                    }
//                    if let email = data?["email"] as? String, !email.isEqual(empty) , email != "" {
//                        Constants.kUserDefaults.set(email as String, forKey: "email")
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "email")
//
//                    }
//                    if let phone = data?["phone"] as? String, !phone.isEqual(empty) , phone != "" {
//                        Constants.kUserDefaults.set(phone as String, forKey: "phone")
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "phone")
//
//                    }
//                    if let code = data?["code"] as? String, !code.isEqual(empty) , code != "" {
//                        Constants.kUserDefaults.set(code as String, forKey: "code")
//                    }else{
//                        Constants.kUserDefaults.set("" , forKey: "code")
//
//                    }
//
//
//                    callback(responseData , nil)
//                }
//                else{
//                    callback(responseData, responseData!["error"] as? String)
//                }
//            }
//
//        }
//
//    }

    
    
    // MARK: Create userProfile
    
    /**
     Create user profile, and persist it to Datastore via Worker(minion),
     that synchronizes with Main context.
     
     - Parameter userProfileDetails: <Dictionary<String, AnyObject> A single Profile to be persisted to the Datastore.
     - Returns: Void
     */
    
    
//    //MARK:-- Get My Profile From Remote
//    func getRemoteMyProfile(callback:(_ responseData:Dictionary<String,AnyObject>?,_ error:String?) -> Void )
//    {
//        profileRemoteAPI.getProfileByProfileId("my") { (Data, error) -> Void in
//            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
//                let userProfile = Data![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//                Constants.kUserDefaults.setObject(userProfile[UserAttributes.name.rawValue] as? String , forKey: UserAttributes.name.rawValue)
//                self.userLocalAPI.saveUserProfile(userProfile)
//                Constants.kUserDefaults.setBool(true, forKey: "isProfileCompleted")
//                callback(responseData:userProfile, error: nil)
//            }
//            else{
//                callback(responseData: Data!, error: "error")
//            }
//            
//        }
//    }
    
    

}
