

import Foundation


	enum ArtistAttributes: String {

		case id = "id"
    case availbilityStart = "availbilityStart"
    case availbilityTill = "availbilityTill"
    case availbilityArea = "availbilityArea"
    case  willingToTravel = " willingToTravel"
    case workExperience = "workExperience"
    case rating = "rating"
    case aboutUs = "aboutUs"
    case email = "email"
    case phone = "phone"
    case coverPic = "coverPic"
    case autoAcceptAppointment = "autoAcceptAppointment"
    case status = "status"
    case availbilityRange = "availbilityRange"
    case workReason = "WorkReason"
    case selectionReason = "selectionReason"
    case certificate = "certificate"
    case toolkit = "toolkit"
    case currentOccupation = "currentOccupation"
    case contactMedium = "contactMedium"
    case query = "query"
    case socialLinks = "socialLinks"
    case attachment = "attachment"
    case user = "user"
    case businessName = "businessName"
    case businessAddress = "businessAddress"
    case businessCordinates = "businessCordinates"
    
    
    static let getAll = [
      id,
   availbilityStart,
    availbilityTill,
    availbilityArea,
   willingToTravel,
    workExperience,
   rating,
    aboutUs,
    phone,
   email,
   user,
   availbilityRange,
   workReason,
   selectionReason,
   certificate,
   autoAcceptAppointment,
 toolkit,
  currentOccupation,
   contactMedium,
   query,
   status,
   coverPic,
  socialLinks,
 attachment,
 businessName,
 businessAddress,
 businessCordinates
    ]
    
	}





public class Artist {
  public var id : Int?
  public var availbilityStart : String?
  public var availbilityTill : String?
  public var availbilityArea : String?
  public var willingToTravel : Bool?
  public var workExperience : String?
  public var rating : String?
  public var aboutUs : String?
  public var status : String?
  public var coverPic : String?
  public var phone : Int?
  public var email : String?
  public var user : User?
  public var autoAcceptAppointment :Bool?
  public var availbilityRange : Int?
  public var workReason : String?
  public var selectionReason : String?
  public var certificate : Bool?
  public var toolkit : Bool?
  public var currentOccupation : String?
  public var contactMedium : String?
  public var query : String?
  public var socialLinks : [String]?
  public var attachment : [String]?
  public var businessName : String?
  public var businessAddress : String?
  public var businessCordinates : [String]?
  /**
   Returns an array of models based on given dictionary.
   
   Sample usage:
   let Artist_list = Artist.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
   
   - parameter array:  NSArray from JSON dictionary.
   
   - returns: Array of Artist Instances.
   */
  public class func modelsFromDictionaryArray(array:NSArray) -> [Artist]
  {
    var models:[Artist] = []
    for item in array
    {
      models.append(Artist(dictionary: item as! NSDictionary)!)
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
    availbilityStart = dictionary["availbilityStart"] as? String
    availbilityTill = dictionary["availbilityTill"] as? String
    availbilityArea = dictionary["availbilityArea"] as? String
   willingToTravel = dictionary[" willingToTravel"] as? Bool
     autoAcceptAppointment = dictionary[" autoAcceptAppointment"] as? Bool
    workExperience = dictionary["workExperience"] as? String
    rating = dictionary["rating"] as? String
    aboutUs = dictionary["aboutUs"] as? String
    phone = dictionary["phone"] as? Int
    email = dictionary["email"] as? String
    availbilityRange = dictionary["availbilityRange"] as? Int
    workReason = dictionary["WorkReason"] as? String
    selectionReason = dictionary["selectionReason"] as? String
    certificate = dictionary["certificate"] as? Bool
    toolkit = dictionary["toolkit"] as? Bool
    currentOccupation = dictionary["currentOccupation"] as? String
    contactMedium = dictionary["contactMedium"] as? String
    query = dictionary["query"] as? String
     coverPic = dictionary["coverPic"] as? String
     status = dictionary["status"] as? String
    socialLinks = dictionary["socialLinks"] as? [String]
    attachment = dictionary["attachment"] as? [String]
    businessCordinates = dictionary["businessCordinates"] as? [String]
    businessName = dictionary["businessName"] as? String
    businessAddress = dictionary["businessAddress"] as? String
    if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as! NSDictionary) }
  }
  
  
  /**
   Returns the dictionary representation for the current instance.
   
   - returns: NSDictionary.
   */
  public func dictionaryRepresentation() -> NSDictionary {
    
    let dictionary = NSMutableDictionary()
    
    dictionary.setValue(self.id, forKey: "id")
    dictionary.setValue(self.availbilityStart, forKey: "availbilityStart")
    dictionary.setValue(self.availbilityTill, forKey: "availbilityTill")
    dictionary.setValue(self.availbilityArea, forKey: "availbilityArea")
    dictionary.setValue(self.willingToTravel, forKey: "willingToTravel")
    dictionary.setValue(self.workExperience, forKey: "workExperience")
    dictionary.setValue(self.autoAcceptAppointment, forKey: "autoAcceptAppointment")
    dictionary.setValue(self.rating, forKey: "rating")
    dictionary.setValue(self.aboutUs, forKey: "aboutUs")
    dictionary.setValue(self.phone, forKey: "phone")
    dictionary.setValue(self.email, forKey: "email")
    dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
    dictionary.setValue(self.availbilityRange, forKey: "availbilityRange")
    dictionary.setValue(self.workReason, forKey: "WorkReason")
    dictionary.setValue(self.selectionReason, forKey: "selectionReason")
    dictionary.setValue(self.certificate, forKey: "certificate")
    dictionary.setValue(self.toolkit, forKey: "toolkit")
     dictionary.setValue(self.status, forKey: "status")
     dictionary.setValue(self.coverPic, forKey: "coverPic")
    dictionary.setValue(self.currentOccupation, forKey: "currentOccupation")
    dictionary.setValue(self.contactMedium, forKey: "contactMedium")
    dictionary.setValue(self.query, forKey: "query")
    dictionary.setValue(self.socialLinks, forKey: "socialLinks")
    dictionary.setValue(self.attachment, forKey: "attachment")
    dictionary.setValue(self.businessName, forKey: "businessName")
    dictionary.setValue(self.businessAddress, forKey: "businessAddress")
    dictionary.setValue(self.businessCordinates, forKey: "businessCordinates")
    return dictionary
  }
  
}

