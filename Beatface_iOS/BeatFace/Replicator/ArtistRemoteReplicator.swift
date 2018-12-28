//
//  ArtistRemoteReplicator.swift
//  BeatFace
//
//  Created by dEEEP on 22/03/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

class ArtistRemoteReplicator{
  
  //MARK:- API constants
  private let getArtist = "Artists"
   private let artist = "artists"
  private let comments = "comments/Artist"
  private let likes = "favourites/Artist"
  private let ratings = "ratings/Artist"
  private let artistServices = "artistServices/"
  private let createServices = "artistServices"
  private let baseUrl1 = beatfaceConfig.mBaseUrl1
  private var remoteRepo:RemoteRepository!
  
  init(){
    self.remoteRepo = RemoteRepository()
  }
  
  
  
  //MARK:- Get All Artists
  func getAllArtists(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
    let url = getArtist + "?name=\(query)" + "&pageNo=" + "\(pageNo)" + "&status=approved"
    
    let urlString =  "\(baseUrl1)\(url.html)"
    
    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
      callback(data, error)
    }
  }
  
  
  //MARK:- Get Artist By ID
  func getArtistByID(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
    let url = getArtist + "/\(query)"
    
    let urlString =  "\(baseUrl1)\(url.html)"
    
    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
      callback(data, error)
    }
  }
  
  
  func getAllCommentsForArtist(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
    let url = comments + "?entityId=\(query)" + "&pageNo=" + "\(pageNo)"
    
    let urlString =  "\(baseUrl1)\(url.html)"
    
    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
      callback(data, error)
    }
  }
  
  func getAllServicesForArtist(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
    let url = artistServices + "?artistId=\(query)"
    
    let urlString =  "\(baseUrl1)\(url.html)"
    
    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
      callback(data, error)
    }
  }
  
  
  func getAllServices(callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
    let url = artistServices
    
    let urlString =  "\(baseUrl1)\(url.html)"
    
    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
      callback(data, error)
    }
  }
  
  
  // MARK: Artist Create
  func createNewArtist(artistDetials: [String:Any], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(artist.html)"
    
    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: artistDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
      callback(data , error )
      
    }
  }
  
  
  // MARK: Artist Update
  func updateArtist(artistId:String, artistDetials: [String:Any], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(artist.html)/" + artistId
    
    remoteRepo.remotePUTServiceWithParameters(urlString: urlString, params: artistDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
      callback(data , error?.description )
      
    }
  }
  
  // MARK: Create Service
  func createNewService(serviceDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(createServices.html)"
    
    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: serviceDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
      callback(data , error )
      
    }
  }
  
  // MARK: Artist Comment
  func createCommentInArtist(commentDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(comments.html)"
    
    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
      callback(data , error )
      
    }
  }
  
  
  // MARK: like Dislike Artist
  func likeDislikeArtist(commentDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(likes.html)"
    
    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
      callback(data , error )
      
    }
  }
  
  
  // MARK: rating Artist
  func ratingArtist(commentDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
    let urlString =  "\(baseUrl1)\(ratings.html)"
    
    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
      callback(data , error )
      
    }
  }
  
  
  
  
  
  
  
  
  
}


