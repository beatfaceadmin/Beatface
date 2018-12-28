//
//  String.swift
//  AQUA
//
//  Created by Krishna on 21/03/17.
//  Copyright © 2017 MindfulSas. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    //MARK:Length of String
    var length :Int{
        return (self as NSString).length
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
  
  func dropLast(_ n: Int = 1) -> String {
    return String(characters.dropLast(n))
  }
  var dropLast: String {
    return dropLast()
  }
  
    //MARK: Making first letter lower of String
    var camelCase:String{
        var result = self
         result.replaceSubrange(self.startIndex...self.startIndex, with: String(self[self.startIndex]).lowercased())
        //result.replaceSubrange(1...1, with: String(self[startIndex]).lowercased())
        return result
    }
    
    //MARK:Making First letter capital of Name
    var toProper:String {
        let result = self
        return (result.capitalized(with: NSLocale.current))
    }
    
    //MARK:Making First letter capital of Name
    var makeFirstLetterCapital:String {
        var result = lowercased()
        result.replaceSubrange(self.startIndex...self.startIndex, with: String(self[startIndex]).capitalized)
        return result
    }

    
    //MARK:Localising String
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    //MARK:JSONStringToDate
    var jsonStringToDate:NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let utcDate = dateFormatter.date(from: self)
        return utcDate! as NSDate
    }
    
    
    //MARK:StringToDate Extensions
    var dateStringToUTCString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let utcDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let utcString = dateFormatter.string(from: utcDate!)
        return utcString
    }
  
 var convertNextDate: String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    let myDate = dateFormatter.date(from: self)!
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
    let somedateString = dateFormatter.string(from: tomorrow!)
    print("your next Date is \(somedateString)")
  return somedateString
  }
  
  var commondateStringToUTCString:String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
    dateFormatter.dateFormat = "dd MMMM, yyyy"
    let utcDate = dateFormatter.date(from: self)
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let utcString = dateFormatter.string(from: utcDate!)
    return utcString
  }
  
    var utcStringToDateString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let localDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let localDateString = dateFormatter.string(from: localDate!)
        return localDateString
    }
    
//    var utcStringToSmartDate:String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = NSTimeZone.local
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        let localDate = dateFormatter.date(from: self)
//        let currentDate = NSDate()
//        //dateFormatter.dateFormat = "MMM-dd-yyyy"
//        dateFormatter.dateFormat = "d MMMM, yyyy"
//        
//        let dateString = dateFormatter.string(from: localDate!)
//        return dateString
//    }
    
    var utcStringToSmartDate:String {
        
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date1 = dateFormatter.date(from: self)
        // return the timeZone of your device i.e. America/Los_angeles
        let timeZone = TimeZone.autoupdatingCurrent.identifier as String
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        
        dateFormatter.dateFormat = "d MMMM, yyyy"
        let localDateTimeString = dateFormatter.string(from: date1!)
        return localDateTimeString
        
    }
  
  var floatValue: Float {
    return (self as NSString).floatValue
  }
  
 
    
    var utcStringToLocalDateTime:String {
        
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date1 = dateFormatter.date(from: self)
        // return the timeZone of your device i.e. America/Los_angeles
        let timeZone = TimeZone.autoupdatingCurrent.identifier as String
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        
        dateFormatter.dateFormat = "h:mm a"
        let localDateTimeString = dateFormatter.string(from: date1!)
        return localDateTimeString
        
    }
  
  var clipTitle:String {
    var clipedName = self
    if clipedName.characters.count > 18{
    if let range = clipedName.range(of: " ") {
      let firstPart = clipedName[clipedName.startIndex..<range.lowerBound]
        clipedName = String(firstPart)
    }
    }
    return clipedName
  }

  
    var utcStringToTimeDifference:String {
        
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date1 = dateFormatter.date(from: self)
        // return the timeZone of your device i.e. America/Los_angeles
        let timeZone = TimeZone.autoupdatingCurrent.identifier as String
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
      var comp = Set<Calendar.Component>()
      comp.insert(.minute)
      //   let difference  = NSCalendar.current.dateComponents(, from: date, to: self)
      let myNewDate = Date()
      let difference  =   Calendar.current.dateComponents(comp, from:date1! , to: myNewDate).minute ?? 0
      
      let hours = difference / 60
      let min = difference % 60
      return "\(String(hours))h \(String(min))m"
        
    }
  
  func dateDifference(toDate: String) -> String {
    
    let dateFormatter =  DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    let date1 = dateFormatter.date(from: self)
    let date2  = dateFormatter.date(from: toDate)
    // return the timeZone of your device i.e. America/Los_angeles
    let timeZone = TimeZone.autoupdatingCurrent.identifier as String
    dateFormatter.timeZone = TimeZone(identifier: timeZone)
    var comp = Set<Calendar.Component>()
    comp.insert(.minute)
   
    let difference  =   Calendar.current.dateComponents(comp, from:date1! , to: date2!).minute ?? 0
    
    let hours = difference / 60
    let min = difference % 60
    return "\(String(hours))h \(String(min))m"
    
  }

  func workingHourDifference(workMinutes:Int ) -> String {
    
    let dateFormatter =  DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    let date1 = dateFormatter.date(from: self)
    // return the timeZone of your device i.e. America/Los_angeles
    let timeZone = TimeZone.autoupdatingCurrent.identifier as String
    dateFormatter.timeZone = TimeZone(identifier: timeZone)
    var comp = Set<Calendar.Component>()
    comp.insert(.minute)

    let myNewDate = Date()
    var difference  =   Calendar.current.dateComponents(comp, from:date1! , to: myNewDate).minute ?? 0
    difference = difference + workMinutes
    
    let hours = difference / 60
    let min = difference % 60
    return "\(String(hours))h \(String(min))m"
    
  }
  

  
  var utcStringToLocalDateTimeForNotification:String {
    
    let dateFormatter =  DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    let date1 = dateFormatter.date(from: self)
    // return the timeZone of your device i.e. America/Los_angeles
    let timeZone = TimeZone.autoupdatingCurrent.identifier as String
    dateFormatter.timeZone = TimeZone(identifier: timeZone)   
     dateFormatter.dateFormat = "d MMM, h:mm a"
      let localDateTimeString = dateFormatter.string(from: date1!)
      return localDateTimeString
    
  }
  
  var httpsExtend:String{
    let newString = self.replacingOccurrences(of: "http", with: "https", options: .literal, range: nil)
    return newString
  }


  
    var utcStringToMonthName:String{
      
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)
        print(date!)
        let timeZone = TimeZone.autoupdatingCurrent.identifier as String
        dateFormatter.timeZone = TimeZone(identifier: timeZone)

        dateFormatter.dateFormat = "MMM"
        let monthName = dateFormatter.string(from: date!)
        
        return(monthName)

    }
    
    var utcStringToDayName:String{
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)
        print(date!)
        let timeZone = TimeZone.autoupdatingCurrent.identifier as String
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        
        dateFormatter.dateFormat = "EEE"
        let dayName = dateFormatter.string(from: date!)
        
        return(dayName)
        
    }
  
  
  var utcStringToFullDayName:String{
    let dateFormatter =  DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: self)
    print(date!)
    let timeZone = TimeZone.autoupdatingCurrent.identifier as String
    dateFormatter.timeZone = TimeZone(identifier: timeZone)
    
    dateFormatter.dateFormat = "EEEE"
    let dayName = dateFormatter.string(from: date!)
    
    return(dayName)
    
  }

  
  var utcStringToShortDate:String{
    let dateFormatter =  DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: self)
    print(date!)
    let timeZone = TimeZone.autoupdatingCurrent.identifier as String
    dateFormatter.timeZone = TimeZone(identifier: timeZone)
    
    dateFormatter.dateFormat = "MMM d"
    let dayName = dateFormatter.string(from: date!)
    
    return(dayName)
    
  }
  
  var shortStyleDate:String{
    let dateFormatter =  DateFormatter()
    dateFormatter.dateFormat = "d MMMM, yyyy"
    let date = dateFormatter.date(from: self)
    print(date!)
    let timeZone = TimeZone.autoupdatingCurrent.identifier as String
    dateFormatter.timeZone = TimeZone(identifier: timeZone)
    
    dateFormatter.dateFormat = "d MMM,"
    let dayName = dateFormatter.string(from: date!)
    
    return(dayName)
    
  }


    var subStringfromUTCStrnig:String {
      
        let c = self.characters
        let r = c.index(c.startIndex, offsetBy: 11)..<c.index(c.endIndex, offsetBy: -12)
        
        // Access the string by the range.
        let substring = self[r]
        return String(substring)
        
        
    }
  
  func dateTimeToTodayTime() -> String{
    let dateFormatter =  DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let dateUtc = dateFormatter.string(from: Date())
    var myDateArr = dateUtc.components(separatedBy: "T")
    var compDateArr = self.components(separatedBy: "T")
    let newDate = myDateArr[0] + "T" + compDateArr[1]
    
    return newDate
    
  }
    
    
    var dateFromUTCString:String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date1 = dateFormatter.date(from: self)
        // return the timeZone of your device i.e. America/Los_angelesdate
        let timeZone = TimeZone.autoupdatingCurrent.identifier as String
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        
        dateFormatter.dateFormat = "dd"
        let localDateString = dateFormatter.string(from: date1!)
        return localDateString

        
//        let c = self.characters
//        let r = c.index(c.startIndex, offsetBy: 8)..<c.index(c.endIndex, offsetBy: -14)
//        
//        // Access the string by the range.
//        let substring = self[r]
//        return substring
        
        
    }
    
    
    
    
    
    
    //MARK: find Width of String
    func widthWithConstrainedWidth(hieght: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: hieght)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width
    }
    
    
    var html: String {
        
        get {
            //"&":"&amp;", add it for & operation
            
            let enc:  [Character:String] = [" ":"%20","^":"%5E", " ":"&ensp;", " ":"%20", " ":"&thinsp;", "‾":"&oline;", "–":"&ndash;", "—":"&mdash;", "¡":"&iexcl;", "¿":"&iquest;", "…":"&hellip;", "·":"&middot;", "'":"&apos;", "‘":"&lsquo;", "’":"&rsquo;", "‚":"&sbquo;", "‹":"&lsaquo;", "›":"&rsaquo;", "‎":"&lrm;", "‏":"&rlm;", "­":"&shy;", "‍":"&zwj;", "‌":"&zwnj;", "\"":"&quot;", "“":"&ldquo;", "”":"&rdquo;", "„":"&bdquo;", "«":"&laquo;", "»":"&raquo;", "⌈":"&lceil;", "⌉":"&rceil;", "⌊":"&lfloor;", "⌋":"&rfloor;", "〈":"&lang;", "〉":"&rang;", "§":"&sect;", "¶":"&para;", "‰":"&permil;", "†":"&dagger;", "‡":"&Dagger;", "•":"&bull;", "′":"&prime;", "″":"&Prime;", "´":"&acute;", "˜":"&tilde;", "¯":"&macr;", "¨":"&uml;", "¸":"&cedil;", "ˆ":"&circ;", "°":"&deg;", "©":"&copy;", "®":"&reg;", "℘":"&weierp;", "←":"&larr;", "→":"&rarr;", "↑":"&uarr;", "↓":"&darr;", "↔":"&harr;", "↵":"&crarr;", "⇐":"&lArr;", "⇑":"&uArr;", "⇒":"&rArr;", "⇓":"&dArr;", "⇔":"&hArr;", "∀":"&forall;", "∂":"&part;", "∃":"&exist;", "∅":"&empty;", "∇":"&nabla;", "∈":"&isin;", "∉":"&notin;", "∋":"&ni;", "∏":"&prod;", "∑":"&sum;", "±":"&plusmn;", "÷":"&divide;", "×":"&times;", "<":"&lt;", "≠":"&ne;", ">":"&gt;", "¬":"&not;", "¦":"&brvbar;", "−":"&minus;", "⁄":"&frasl;", "∗":"&lowast;", "√":"&radic;", "∝":"&prop;", "∞":"&infin;", "∠":"&ang;", "∧":"&and;", "∨":"&or;", "∩":"&cap;", "∪":"&cup;", "∫":"&int;", "∴":"&there4;", "∼":"&sim;", "≅":"&cong;", "≈":"&asymp;", "≡":"&equiv;", "≤":"&le;", "≥":"&ge;", "⊄":"&nsub;", "⊂":"&sub;", "⊃":"&sup;", "⊆":"&sube;", "⊇":"&supe;", "⊕":"&oplus;", "⊗":"&otimes;", "⊥":"&perp;", "⋅":"&sdot;", "◊":"&loz;", "♠":"&spades;", "♣":"&clubs;", "♥":"&hearts;", "♦":"&diams;", "¤":"&curren;", "¢":"&cent;", "£":"&pound;", "¥":"&yen;", "€":"&euro;", "¹":"&sup1;", "½":"&frac12;", "¼":"&frac14;", "²":"&sup2;", "³":"&sup3;", "¾":"&frac34;", "á":"&aacute;", "Á":"&Aacute;", "â":"&acirc;", "Â":"&Acirc;", "à":"&agrave;", "À":"&Agrave;", "å":"&aring;", "Å":"&Aring;", "ã":"&atilde;", "Ã":"&Atilde;", "ä":"&auml;", "Ä":"&Auml;", "ª":"&ordf;", "æ":"&aelig;", "Æ":"&AElig;", "ç":"&ccedil;", "Ç":"&Ccedil;", "ð":"&eth;", "Ð":"&ETH;", "é":"&eacute;", "É":"&Eacute;", "ê":"&ecirc;", "Ê":"&Ecirc;", "è":"&egrave;", "È":"&Egrave;", "ë":"&euml;", "Ë":"&Euml;", "ƒ":"&fnof;", "í":"&iacute;", "Í":"&Iacute;", "î":"&icirc;", "Î":"&Icirc;", "ì":"&igrave;", "Ì":"&Igrave;", "ℑ":"&image;", "ï":"&iuml;", "Ï":"&Iuml;", "ñ":"&ntilde;", "Ñ":"&Ntilde;", "ó":"&oacute;", "Ó":"&Oacute;", "ô":"&ocirc;", "Ô":"&Ocirc;", "ò":"&ograve;", "Ò":"&Ograve;", "º":"&ordm;", "ø":"&oslash;", "Ø":"&Oslash;", "õ":"&otilde;", "Õ":"&Otilde;", "ö":"&ouml;", "Ö":"&Ouml;", "œ":"&oelig;", "Œ":"&OElig;", "ℜ":"&real;", "š":"&scaron;", "Š":"&Scaron;", "ß":"&szlig;", "™":"&trade;", "ú":"&uacute;", "Ú":"&Uacute;", "û":"&ucirc;", "Û":"&Ucirc;", "ù":"&ugrave;", "Ù":"&Ugrave;", "ü":"&uuml;", "Ü":"&Uuml;", "ý":"&yacute;", "Ý":"&Yacute;", "ÿ":"&yuml;", "Ÿ":"&Yuml;", "þ":"&thorn;", "Þ":"&THORN;", "α":"&alpha;", "Α":"&Alpha;", "β":"&beta;", "Β":"&Beta;", "γ":"&gamma;", "Γ":"&Gamma;", "δ":"&delta;", "Δ":"&Delta;", "ε":"&epsilon;", "Ε":"&Epsilon;", "ζ":"&zeta;", "Ζ":"&Zeta;", "η":"&eta;", "Η":"&Eta;", "θ":"&theta;", "Θ":"&Theta;", "ϑ":"&thetasym;", "ι":"&iota;", "Ι":"&Iota;", "κ":"&kappa;", "Κ":"&Kappa;", "λ":"&lambda;", "Λ":"&Lambda;", "µ":"&micro;", "μ":"&mu;", "Μ":"&Mu;", "ν":"&nu;", "Ν":"&Nu;", "ξ":"&xi;", "Ξ":"&Xi;", "ο":"&omicron;", "Ο":"&Omicron;", "π":"&pi;", "Π":"&Pi;", "ϖ":"&piv;", "ρ":"&rho;", "Ρ":"&Rho;", "σ":"&sigma;", "Σ":"&Sigma;", "ς":"&sigmaf;", "τ":"&tau;", "Τ":"&Tau;", "ϒ":"&upsih;", "υ":"&upsilon;", "Υ":"&Upsilon;", "φ":"&phi;", "Φ":"&Phi;", "χ":"&chi;", "Χ":"&Chi;", "ψ":"&psi;", "Ψ":"&Psi;", "ω":"&omega;", "Ω":"&Omega;", "ℵ":"&alefsym;"]
            
            var html = ""
            for c in self.characters {
                if let entity = enc[c] {
                    html.append(entity)
                } else {
                    html.append(c)
                }
            }
            return html
        }
    }
    
}
