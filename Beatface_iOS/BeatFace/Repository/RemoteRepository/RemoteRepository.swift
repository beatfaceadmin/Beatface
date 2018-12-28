//
//  RemoteRepository.swift
//  Looped
//
//  Created by dEEEP on 19/07/16.
//  Copyright © 2016 Jagdeep. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class  RemoteRepository {
    private let baseUrl1 = beatfaceConfig.mBaseUrl1
    private var deviceId = ""
  

    init() {

    }
    

 
// MARK:--GET Request Method
//To Get data from Remote resource.Returns NSDictionary Object
 
    func remoteGETService(urlString : String! , callback:@escaping (_ data: Dictionary<String,AnyObject>?, _ error: NSError? ) -> Void)  {
        var tokenHeaders:[String:String]! = [:]
      
        if let token = Constants.kUserDefaults.string(forKey: appConstants.token){
             tokenHeaders = ["x-access-token":token,]
        }
        
     let url = urlString
    print("Request GET URL:\(url) HEADER:\(tokenHeaders)")
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).validate().responseJSON(completionHandler: {
            response in
            guard response.result.error == nil else {
                print(response.result.error?.localizedDescription)
                SVProgressHUD.showError(withStatus: "SA_STR_TRY_AGAIN".localized)
                //  callback(data: nil , error: response.result.error! )
                return
            }
            
            if let value = response.result.value {
                print("Response for GET :\(urlString):\(value)")
                if let result = value as? Dictionary<String, AnyObject> {
                    callback(result , nil )
                }
            }

            
        })
        
    }

    
// MARK:-- POST  Request Method
//To POST data from Remote resource.Returns NSDictionary Object
    func remotePOSTServiceWithParameters(urlString : String , params : Dictionary<String,AnyObject> , callback:@escaping (_ data: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)  {


      //  let url =  "\(baseUrl)\(urlString.html)"
      var tokenHeaders:[String:String]! = [:]
      
      if let token = Constants.kUserDefaults.string(forKey: appConstants.token){
        tokenHeaders = ["x-access-token":token]
      }

      
        print("Request POST URL:\(urlString) PARAMS:\(params) HEADER:\(tokenHeaders) ")
        Alamofire .request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: tokenHeaders).validate().responseJSON(completionHandler: {
            response in
            
            guard response.result.error == nil else {
                SVProgressHUD.showError(withStatus: "SA_STR_TRY_AGAIN".localized)
                print("Error for POST :\(urlString):\(response.result.error!)")
                callback(nil , String(describing: response.result.error))
                return
            }
            
            if let value = response.result.value {
                print("Response for POST :\(urlString):\(value)")
                if let result = value as? Dictionary<String, AnyObject> {
                    print(result[APIConstants.isSuccess.rawValue]! )
                    
                    result[APIConstants.isSuccess.rawValue]! as? Int == 1 ? callback(result , nil ) : callback(result , nil )
                    
                    
                }
            }

            
        })
        
    }
    
    
    func remotePOSTServiceWithHeaderParameters(urlString : String , callback:@escaping (_ data: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void)  {
        
      
      
      var tokenHeaders:[String:String]! = [:]
        var dict = [String:AnyObject]()
      
  
        self.deviceId = Constants.kUserDefaults.value(forKey: appConstants.deviceId) as! String
      if self.deviceId == ""{
      self.deviceId = "123"
      }
        dict["id"] = self.deviceId as AnyObject?

        var params :Dictionary<String,AnyObject> = [:]
       //n dict["id"] = deviceId as AnyObject?
        params["device"] = dict as AnyObject?
      

     
      
       print("Request POST URL:\(urlString) PARAMS:\(params) HEADER:\(tokenHeaders)")
        
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: tokenHeaders).validate().responseJSON(completionHandler: {
            response in
            
            guard response.result.error == nil else {
                print("Error for POST :\(urlString):\(response.result.error!)")
                SVProgressHUD.showError(withStatus: "SA_STR_TRY_AGAIN".localized)
                //                callback(data: nil , error: response.result.error! )
                return
            }
            
            if let value = response.result.value {
                if let result = value as? Dictionary<String, AnyObject> {
                    print("Response for POST :\(urlString):\(value)")
                    callback(result , nil )
                }
            }

            
        })
        
    }

 
    
// MARK:-- PUT  Request Method
//To PUT data from Remote resource.Returns NSDictionary Object
    func remotePUTServiceWithParameters(urlString : String , params : Dictionary<String,AnyObject>? , callback:@escaping (_ data: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void)  {
        
       // let url =  "\(baseUrl)\(urlString.html)"
      var tokenHeaders:[String:String]! = [:]
      
      if let token = Constants.kUserDefaults.string(forKey: appConstants.token){
        tokenHeaders = ["x-access-token":token]
      }
      
        print("Request PUT URL:\(urlString) PARAMS:\(params) HEADER:\(tokenHeaders)")
        Alamofire.request(urlString, method: .put, parameters: params, encoding: JSONEncoding.default, headers: tokenHeaders).validate().responseJSON(completionHandler: {
            response in
            
            guard response.result.error == nil else {
                print("Error for PUT :\(urlString):\(response.result.error!)")
                SVProgressHUD.showError(withStatus: "SA_STR_TRY_AGAIN".localized)
                //     callback(data: nil , error: response.result.error! )
                return
            }
            
            if let value = response.result.value {
                print("Response for PUT :\(urlString):\(value)")
                if let result = value as? Dictionary<String, AnyObject> {
                    callback(result , nil )
                }
            }

       })
    }


  // MARK:-- DELETE  Request Method
  //To DELETE data from Remote resource.Returns NSDictionary Object
  func remoteDELETEServiceWithParameters(urlString : String , params : Dictionary<String,AnyObject>? , callback:@escaping (_ data: Dictionary<String, AnyObject>?, _ error: NSError? ) -> Void)  {
    
    //let url =  "\(baseUrl)\(urlString.html)"
    var tokenHeaders:[String:String]! = [:]
    
    if let token = Constants.kUserDefaults.string(forKey: appConstants.token){
      tokenHeaders = ["x-access-token":token]
    }

    
    print("Request DELETE URL:\(urlString) PARAMS:\(params) HEADER:\(tokenHeaders)")
    Alamofire.request(urlString, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: tokenHeaders).validate().responseJSON(completionHandler: {
        response in
        
        guard response.result.error == nil else {
            print("Error for DELETE :\(urlString):\(response.result.error!)")
            SVProgressHUD.showError(withStatus: "SA_STR_TRY_AGAIN".localized)
            //     callback(data: nil , error: response.result.error! )
            return
        }
        
        if let value = response.result.value {
            print("Response for DELETE :\(urlString):\(value)")
            if let result = value as? Dictionary<String, AnyObject> {
                callback(result , nil )
            }
        }

        
    })
    
  }
  
   
  
  
}
