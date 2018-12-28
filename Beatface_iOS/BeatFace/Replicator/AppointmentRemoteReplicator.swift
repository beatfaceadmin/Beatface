//
//  AppointmentRemoteReplicator.swift
//  BeatFace
//
//  Created by dEEEP on 06/04/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation



class AppointmentRemoteReplicator{
  
  //MARK:- API constants
  private let getArtist = "Artists"
  private let appointments = "appointments"
  private let appointmentsStatus = "appointments/changeStatus"
 
  
  private let baseUrl1 = beatfaceConfig.mBaseUrl1
  private var remoteRepo:RemoteRepository!
  
  init(){
    self.remoteRepo = RemoteRepository()
  }
  
  
  
  //MARK:- Get My Appointment
  func getAllAppointment(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
    let url = appointments + "?\(query)" + "&pageNo=" + "\(pageNo)"
    
    let urlString =  "\(baseUrl1)\(url.html)"
    
    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
      callback(data, error)
    }
  }
  
  
  //MARK:- Get Artist By ID
  func getAppointmentByID(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
    let url = getArtist + "/\(query)"
    
    let urlString =  "\(baseUrl1)\(url.html)"
    
    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
      callback(data, error)
    }
  }
  
  
  
  // MARK: Appointment Create
  func createNewAppointment(appointmentDetials: [String:Any], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(appointments.html)"
    
    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: appointmentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
      callback(data , error )
      
    }
  }
  
  
  // MARK: Appointment Update
  func updateNewAppointment(appointmentID:String,appointmentDetials: [String:Any], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(appointments.html)/\(appointmentID)"
    
    remoteRepo.remotePUTServiceWithParameters(urlString: urlString, params: appointmentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
      callback(data , error?.description )
      
    }
  }
  
  
  // MARK: Appointment Status
  func updateAppointmentStatus(appointmentDetail:[String:Any], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(appointmentsStatus.html)"
    
    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params:appointmentDetail as Dictionary<String, AnyObject>) { (data, error) -> Void in
      callback(data , error?.description )
      
    }
  }
  

  

  
//  // MARK: Artist Comment
//  func createCommentInArtist(commentDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//    let urlString =  "\(baseUrl1)\(comments.html)"
//
//    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
//      callback(data , error )
//
//    }
//  }
//
//
//  // MARK: like Dislike Artist
//  func likeDislikeArtist(commentDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//    let urlString =  "\(baseUrl1)\(likes.html)"
//
//    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
//      callback(data , error )
//
//    }
//  }
//
//
//  // MARK: rating Artist
//  func ratingArtist(commentDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//    let urlString =  "\(baseUrl1)\(ratings.html)"
//
//    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
//      callback(data , error )
//
//    }
//  }
  
  
  
  
  
  
  
  
  
}
