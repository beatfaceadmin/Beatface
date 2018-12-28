//
//  UserRemoteReplicator.swift
//  AQUA
//
//  Created by Krishna on 05/04/17.
//  Copyright © 2017 MindfulSas. All rights reserved.
//

import Foundation

class UserRemoteReplicator{
    
    //MARK:- API constants
    private let signUp = "users/signup"
    private let verify = "users/verify"
   private let profile = "users/addprofile/"
     private let users = "users/"
     private let baseUrl1 = beatfaceConfig.mBaseUrl1
    private var remoteRepo:RemoteRepository!
    
    init(){
        self.remoteRepo = RemoteRepository()
    }
    
    
    
    // MARK: SignUp With Email
    func userSignUp(userDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(signUp.html)"
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: userDetials) { (data, error) -> Void in
            callback(data , error )
            
        }
    }
    
     //MARK: VarificationCode With Email
    func userVarificationCode(userDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
       
        let urlString =  "\(baseUrl1)\(verify.html)"

        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: userDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error )
        }
    }
  
  
  // MARK: Update Profile
  func userUpdateProfile(userDetials: Dictionary<String, AnyObject>,userID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(profile.html)" + userID
    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: userDetials) { (data, error) -> Void in
      callback(data , error )
      
    }
  }
  
  //MARK:- Get User By ID
  func getUserByID(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
    let url = users + "\(query)"
    
    let urlString =  "\(baseUrl1)\(url.html)"
    
    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
      callback(data, error)
    }
  }
    
    

}
