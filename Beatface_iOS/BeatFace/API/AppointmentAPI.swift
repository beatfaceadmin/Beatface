//
//  AppointmentAPI.swift
//  BeatFace
//
//  Created by dEEEP on 06/04/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

class AppointmentAPI{
  
  private let appointmentRemoteReplicator: AppointmentRemoteReplicator!
  
  
  //Utilize Singleton pattern by instanciating AppointmentAPI only once.
  class var sharedInstance: AppointmentAPI {
    struct Singleton {
      static let instance = AppointmentAPI()
    }
    return Singleton.instance
  }
  
  init(){
    self.appointmentRemoteReplicator = AppointmentRemoteReplicator()
    
  }
  
  
  
  //MARK:-- Get Appointments From Remote
  func getAllAppointment(name:String,pageNo:Int, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
  {
    appointmentRemoteReplicator.getAllAppointment(query: name,pageNo: pageNo) { (Data, error) in
      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
        callback(Data! , nil)
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }
  
  //MARK:-- Get Appointment By Id From Remote
  func getAppointmentByID(Id:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
  {
    appointmentRemoteReplicator.getAppointmentByID(query: Id) { (Data, error) in
      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
        callback(Data! , nil)
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }
  
  // MARK: create Appointment
  func createAppointment(appointmentDetials: [String:Any] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Appointment? , _ error: String? ) -> Void)   {
    appointmentRemoteReplicator.createNewAppointment(appointmentDetials: appointmentDetials){ (responseData, error) -> Void in
      if responseData != nil {
        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
          
          let artist = Appointment.init(dictionary: data as NSDictionary)
          callback(true,artist,nil)
        }else{
          callback(false,nil,responseData!["error"] as? String)
        }
      }
      
    }
    
  }
  
  // MARK: update Appointment
  func updateAppointment(appointmentID:String, appointmentDetials: [String:Any] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Appointment? , _ error: String? ) -> Void)   {
    appointmentRemoteReplicator.updateNewAppointment(appointmentID: appointmentID,appointmentDetials: appointmentDetials){ (responseData, error) -> Void in
      if responseData != nil {
        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
          
          let artist = Appointment.init(dictionary: data as NSDictionary)
          callback(true,artist,nil)
        }else{
          callback(false,nil,responseData!["error"] as? String)
        }
      }
      
    }
    
  }
  
  
  // MARK: update Appointment
  func updateAppointmentStatus(appointmentDetail:[String:Any] , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
    appointmentRemoteReplicator.updateAppointmentStatus(appointmentDetail:appointmentDetail){ (responseData, error) -> Void in
      if responseData != nil {
        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
          callback(true,nil)
        }else{
          callback(false,responseData!["error"] as? String)
        }
      }
      
    }
    
  }
  
  
//  //MARK:-- Get Artists From Remote
//  func getAllCommentsForArtist(id:String,pageNo:Int, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
//  {
//    appointmentRemoteReplicator.getAllCommentsForArtist(query: id,pageNo: pageNo) { (Data, error) in
//      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
//        callback(Data! , nil)
//      }
//      else{
//        print("Getting Error")
//
//      }
//
//    }
//  }
  
//  //MARK:-- Get Artists From Remote
//  func getAllServicesForArtist(id:String,pageNo:Int, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
//  {
//    appointmentRemoteReplicator.getAllServicesForArtist(query: id,pageNo: pageNo) { (Data, error) in
//      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
//        callback(Data! , nil)
//      }
//      else{
//        print("Getting Error")
//
//      }
//
//    }
//  }
  
//  //MARK:-- Get Artists From Remote
//  func getAllServices(callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
//  {
//    appointmentRemoteReplicator.getAllServices() { (Data, error) in
//      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
//        callback(Data! , nil)
//      }
//      else{
//        print("Getting Error")
//
//      }
//
//    }
//  }
  

  
  
//  // MARK: create Artist Service
//  func createArtistService(serviceDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Services? , _ error: String? ) -> Void)   {
//    appointmentRemoteReplicator.createNewService(serviceDetials: serviceDetials){ (responseData, error) -> Void in
//      if responseData != nil {
//        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//
//          let services = Services.init(dictionary: data as NSDictionary)
//          callback(true,services,nil)
//        }else{
//          callback(false,nil,responseData!["error"] as? String)
//        }
//      }
//
//    }
//
//  }
  
  
  
  // MARK: Add Comment
  //  func postComment(commentDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Comment? , _ error: String? ) -> Void)   {
  //    appointmentRemoteReplicator.createCommentInArtist(commentDetials: commentDetials){ (responseData, error) -> Void in
  //      if responseData != nil {
  //        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
  //          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
  //
  //          let comment = Comment.init(dictionary: data as NSDictionary)
  //          callback(true,comment,nil)
  //        }else{
  //          callback(false,nil,responseData!["error"] as? String)
  //        }
  //      }
  //
  //    }
  //
  //  }
  
  
//  // MARK: likeUnlikeArtist
//  func likeDislikeArtist(appointmentDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
//    appointmentRemoteReplicator.likeDislikeArtist(commentDetials: appointmentDetials){ (responseData, error) -> Void in
//      if responseData != nil {
//        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//
//
//
//          callback(true,nil)
//        }else{
//          callback(false,responseData!["error"] as? String)
//        }
//      }
//
//    }
//
//  }
//
//
//  // MARK: RATINGArtist
//  func ratingArtist(appointmentDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
//    appointmentRemoteReplicator.ratingArtist(commentDetials: appointmentDetials){ (responseData, error) -> Void in
//      if responseData != nil {
//        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//
//          callback(true,nil)
//        }else{
//          callback(false,responseData!["error"] as? String)
//        }
//      }
//
//    }
//
//  }
  
}

