/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation


	enum UserAttributes: String{

		case id = "id"
		case name = "name"
		case email = "email"
		case status = "status"
		case gender = "gender"
		case dob = "dob"
		case location = "location"
		case locationCoordinates = "locationCoordinates"
		case countryId = "countryId"
		case token = "token"
    case picUrl = "picUrl"
    
    static let getAll = [
      id,
      name,
      email,
      status,
      gender,
      dob,
      location,
      locationCoordinates,
      countryId,
      token,
      picUrl
    ]
}



public class User {
  public var id : Int?
  public var name : String?
  public var email : String?
  public var status : String?
  public var gender : String?
  public var dob : String?
  public var location : String?
  public var locationCoordinates : [String]?
  public var countryId : String?
  public var token : String?
  public var picUrl :  String?
  
  /**
   Returns an array of models based on given dictionary.
   
   Sample usage:
   let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
   
   - parameter array:  NSArray from JSON dictionary.
   
   - returns: Array of User Instances.
   */
  public class func modelsFromDictionaryArray(array:NSArray) -> [User]
  {
    var models:[User] = []
    for item in array
    {
      models.append(User(dictionary: item as! NSDictionary)!)
    }
    return models
  }
  
  /**
   Constructs the object based on the given dictionary.
   
   Sample usage:
   let User = User(someDictionaryFromJSON)
   
   - parameter dictionary:  NSDictionary from JSON.
   
   - returns: User Instance.
   */
  required public init?(dictionary: NSDictionary) {
    
    id = dictionary["id"] as? Int
    name = dictionary["name"] as? String
    email = dictionary["email"] as? String
    status = dictionary["status"] as? String
    gender = dictionary["gender"] as? String
    dob = dictionary["dob"] as? String
    location = dictionary["location"] as? String
    locationCoordinates = dictionary["locationCoordinates"] as? [String]
    countryId = dictionary["countryId"] as? String
    token = dictionary["token"] as? String
    picUrl = dictionary["picUrl"] as? String
  }
  
  
  /**
   Returns the dictionary representation for the current instance.
   
   - returns: NSDictionary.
   */
  public func dictionaryRepresentation() -> NSDictionary {
    
    let dictionary = NSMutableDictionary()
    
    dictionary.setValue(self.id, forKey: "id")
    dictionary.setValue(self.name, forKey: "name")
    dictionary.setValue(self.email, forKey: "email")
    dictionary.setValue(self.status, forKey: "status")
    dictionary.setValue(self.gender, forKey: "gender")
    dictionary.setValue(self.dob, forKey: "dob")
    dictionary.setValue(self.location, forKey: "location")
    dictionary.setValue(self.locationCoordinates, forKey: "locationCoordinates")
    dictionary.setValue(self.countryId, forKey: "countryId")
    dictionary.setValue(self.token, forKey: "token")
    dictionary.setValue(self.picUrl, forKey: "picUrl")
    
    return dictionary
  }
  
}

