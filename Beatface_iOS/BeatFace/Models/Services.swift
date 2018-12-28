//
//  Services.swift
//  BeatFace
//
//  Created by dEEEP on 03/04/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation


  
  enum ServicesAttributes: String {
    
    case id = "id"
    case name = "name"
    case estimatedTime = "estimatedTime"
    case cost = "cost"
    case serviceType = "serviceType"
    case artistId = "artistId"
    
    
    static let getAll = [
   id,
   name,
  estimatedTime,
   cost,
  serviceType,
  artistId
    ]
    
  }

public class Services {
  public var id : Int?
  public var name : String?
  public var estimatedTime : String?
  public var cost : String?
  public var serviceType : String?
   public var artistId : String?
  
  /**
   Returns an array of models based on given dictionary.
   
   Sample usage:
   let Services_list = Services.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
   
   - parameter array:  NSArray from JSON dictionary.
   
   - returns: Array of Services Instances.
   */
  public class func modelsFromDictionaryArray(array:NSArray) -> [Services]
  {
    var models:[Services] = []
    for item in array
    {
      models.append(Services(dictionary: item as! NSDictionary)!)
    }
    return models
  }
  
  /**
   Constructs the object based on the given dictionary.
   
   Sample usage:
   let Services = Services(someDictionaryFromJSON)
   
   - parameter dictionary:  NSDictionary from JSON.
   
   - returns: Services Instance.
   */
  required public init?(dictionary: NSDictionary) {
    
    id = dictionary["id"] as? Int
    name = dictionary["name"] as? String
    estimatedTime = dictionary["estimatedTime"] as? String
    cost = dictionary["cost"] as? String
    serviceType = dictionary["serviceType"] as? String
     artistId = dictionary["artistId"] as? String
  }
  
  
  /**
   Returns the dictionary representation for the current instance.
   
   - returns: NSDictionary.
   */
  public func dictionaryRepresentation() -> NSDictionary {
    
    let dictionary = NSMutableDictionary()
    
    dictionary.setValue(self.id, forKey: "id")
    dictionary.setValue(self.name, forKey: "name")
    dictionary.setValue(self.estimatedTime, forKey: "estimatedTime")
    dictionary.setValue(self.cost, forKey: "cost")
    dictionary.setValue(self.serviceType, forKey: "serviceType")
     dictionary.setValue(self.artistId, forKey: "artistId")
    
    return dictionary
  }
  
}

