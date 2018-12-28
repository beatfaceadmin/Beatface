//
//  Appointments.swift
//  BeatFace
//
//  Created by dEEEP on 06/04/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

import Foundation


enum AppointmentAttributes: String {
  
  case id = "id"
  case artistId = "artistId"
  case serviceId = "serviceId"
  case userId = "userId"
  case isUrgent = "isUrgent"
  case time = "time"
  case comments = "comments"
  case address = "address"
  case addressDescription = "addressDescription"
  case price = "price"
  case code = "code"
  case artist = "artist"
  case grandTotal = "grandTotal"
  case status = "status"
  case paymentStatus = "paymentStatus"
  case paymentMethod = "paymentMethod"
  case user = "user"
  case addressCordinates = "addressCordinates"
  case artistService = "artistService"
  
  
  static let getAll = [
    id,
    artistId,
    serviceId,
    userId,
   isUrgent,
    artist,
    time,
    comments,
    address,
    code,
    price,
    addressDescription,
    user,
    grandTotal,
    status,
    paymentStatus,
    paymentMethod,
    addressCordinates,
    artistService
  ]
  
}





public class Appointment {
  public var id : Int?
  public var artistId : String?
  public var serviceId : String?
  public var userId : String?
  public var isUrgent : Bool?
  public var time : String?
  public var comments : String?
  public var address : String?
  public var code : String?
  public var price : Float?
  public var addressDescription : String?
  public var user : User?
  public var artist : Artist?
  public var artistService : Services?
  public var grandTotal : Float?
  public var status : String?
  public var paymentStatus : String?
  public var paymentMethod : String?
  public var addressCordinates : [String]?
  /**
   Returns an array of models based on given dictionary.
   
   Sample usage:
   let Artist_list = Artist.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
   
   - parameter array:  NSArray from JSON dictionary.
   
   - returns: Array of Artist Instances.
   */
  public class func modelsFromDictionaryArray(array:NSArray) -> [Appointment]
  {
    var models:[Appointment] = []
    for item in array
    {
      models.append(Appointment(dictionary: item as! NSDictionary)!)
    }
    return models
  }
  
  /**
   Constructs the object based on the given dictionary.
   
   Sample usage:
   let Artist = Artist(someDictionaryFromJSON)
   
   - parameter dictionary:  NSDictionary from JSON.
   
   - returns: Artist Instance.
   */
  required public init?(dictionary: NSDictionary) {
    
    id = dictionary["id"] as? Int
    artistId = dictionary["artistId"] as? String
    serviceId = dictionary["serviceId"] as? String
    userId = dictionary["userId"] as? String
   isUrgent = dictionary["isUrgent"] as? Bool
    code = dictionary["code"] as? String
    time = dictionary["time"] as? String
    comments = dictionary["comments"] as? String
    address = dictionary["address"] as? String
    price = dictionary["price"] as? Float
    addressDescription = dictionary["addressDescription"] as? String
    grandTotal = dictionary["grandTotal"] as? Float
    status = dictionary["status"] as? String
    paymentStatus = dictionary["paymentStatus"] as? String
    paymentMethod = dictionary["paymentMethod"] as? String
    addressCordinates = dictionary["addressCordinates"] as? [String]
    if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as! NSDictionary) }
    if (dictionary["artist"] != nil) { artist = Artist(dictionary: dictionary["artist"] as! NSDictionary) }
     if (dictionary["artistService"] != nil) { artistService = Services(dictionary: dictionary["artistService"] as! NSDictionary) }
    
  }
  
  
  /**
   Returns the dictionary representation for the current instance.
   
   - returns: NSDictionary.
   */
  public func dictionaryRepresentation() -> NSDictionary {
    
    let dictionary = NSMutableDictionary()
    
    dictionary.setValue(self.id, forKey: "id")
    dictionary.setValue(self.artistId, forKey: "artistId")
    dictionary.setValue(self.serviceId, forKey: "serviceId")
     dictionary.setValue(self.artistService, forKey: "artistService")
    dictionary.setValue(self.userId, forKey: "userId")
    dictionary.setValue(self.isUrgent, forKey: "isUrgent")
    dictionary.setValue(self.code, forKey: "code")
    dictionary.setValue(self.time, forKey: "time")
    dictionary.setValue(self.comments, forKey: "comments")
    dictionary.setValue(self.address, forKey: "address")
    dictionary.setValue(self.price, forKey: "price")
    dictionary.setValue(self.addressDescription, forKey: "addressDescription")
    dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
    dictionary.setValue(self.grandTotal, forKey: "grandTotal")
    dictionary.setValue(self.status, forKey: "status")
    dictionary.setValue(self.artist, forKey: "artist")
    dictionary.setValue(self.paymentStatus, forKey: "paymentStatus")
    dictionary.setValue(self.paymentMethod, forKey: "paymentMethod")
    dictionary.setValue(self.addressCordinates, forKey: "addressCordinates")
    return dictionary
  }
  
}
