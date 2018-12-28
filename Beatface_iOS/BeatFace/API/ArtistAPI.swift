//
//  ArtistAPI.swift
//  BeatFace
//
//  Created by dEEEP on 22/03/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

class ArtistAPI{
  
  private let artistRemoteReplicator: ArtistRemoteReplicator!
  
  
  //Utilize Singleton pattern by instanciating ArtistAPI only once.
  class var sharedInstance: ArtistAPI {
    struct Singleton {
      static let instance = ArtistAPI()
    }
    return Singleton.instance
  }
  
  init(){
    self.artistRemoteReplicator = ArtistRemoteReplicator()
    
  }
  
  
  
  //MARK:-- Get Artists From Remote
  func getAllArtist(name:String,pageNo:Int, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
  {
    artistRemoteReplicator.getAllArtists(query: name,pageNo: pageNo) { (Data, error) in
      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
        callback(Data! , nil)
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }
  
  //MARK:-- Get Artist By Id From Remote
  func getArtistByID(Id:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
  {
    artistRemoteReplicator.getArtistByID(query: Id) { (Data, error) in
      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
        callback(Data! , nil)
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }
  
  
  //MARK:-- Get Artists From Remote
  func getAllCommentsForArtist(id:String,pageNo:Int, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
  {
    artistRemoteReplicator.getAllCommentsForArtist(query: id,pageNo: pageNo) { (Data, error) in
      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
        callback(Data! , nil)
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }
  
  //MARK:-- Get Artists From Remote
  func getAllServicesForArtist(id:String,pageNo:Int, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
  {
    artistRemoteReplicator.getAllServicesForArtist(query: id,pageNo: pageNo) { (Data, error) in
      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
        callback(Data! , nil)
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }
  
  //MARK:-- Get Artists From Remote
  func getAllServices(callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
  {
    artistRemoteReplicator.getAllServices() { (Data, error) in
      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
        callback(Data! , nil)
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }
  
  // MARK: create Artist
    func createArtist(artistDetials: [String:Any] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Artist? , _ error: String? ) -> Void)   {
      artistRemoteReplicator.createNewArtist(artistDetials: artistDetials){ (responseData, error) -> Void in
        if responseData != nil {
          if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
            let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
  
            let artist = Artist.init(dictionary: data as NSDictionary)
            callback(true,artist,nil)
          }else{
            callback(false,nil,responseData!["error"] as? String)
          }
        }
  
      }
  
    }
  
  
  // MARK: update Artist
  func updateArtist(artistId:String,artistDetials: [String:Any] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Artist? , _ error: String? ) -> Void)   {
    artistRemoteReplicator.updateArtist(artistId:artistId,artistDetials: artistDetials){ (responseData, error) -> Void in
      if responseData != nil {
        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
          
          let artist = Artist.init(dictionary: data as NSDictionary)
          callback(true,artist,nil)
        }else{
          callback(false,nil,responseData!["error"] as? String)
        }
      }
      
    }
    
  }

  
  // MARK: create Artist Service
  func createArtistService(serviceDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Services? , _ error: String? ) -> Void)   {
    artistRemoteReplicator.createNewService(serviceDetials: serviceDetials){ (responseData, error) -> Void in
      if responseData != nil {
        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
          
          let services = Services.init(dictionary: data as NSDictionary)
          callback(true,services,nil)
        }else{
          callback(false,nil,responseData!["error"] as? String)
        }
      }
      
    }
    
  }

  
  
  // MARK: Add Comment
//  func postComment(commentDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Comment? , _ error: String? ) -> Void)   {
//    artistRemoteReplicator.createCommentInArtist(commentDetials: commentDetials){ (responseData, error) -> Void in
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
  
  
  // MARK: likeUnlikeArtist
  func likeDislikeArtist(ArtistDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
    artistRemoteReplicator.likeDislikeArtist(commentDetials: ArtistDetials){ (responseData, error) -> Void in
      if responseData != nil {
        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
      
          
          
          callback(true,nil)
        }else{
          callback(false,responseData!["error"] as? String)
        }
      }
      
    }
    
  }
  
  
  // MARK: RATINGArtist
  func ratingArtist(artistDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
    artistRemoteReplicator.ratingArtist(commentDetials: artistDetials){ (responseData, error) -> Void in
      if responseData != nil {
        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
       
          callback(true,nil)
        }else{
          callback(false,responseData!["error"] as? String)
        }
      }
      
    }
    
}

}
