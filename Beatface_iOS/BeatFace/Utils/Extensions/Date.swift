//
//  Date.swift
//  AQUA
//
//  Created by Krishna on 12/04/17.
//  Copyright © 2017 MindfulSas. All rights reserved.
//

import Foundation

public extension Date{



//MARK:StringfyDate
    var stringfromDateType: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateString = dateFormatter.string(from: self as Date)
        return dateString
    }
  
  var dateToSmartDate:String{
    let dateFormatter =  DateFormatter()
    dateFormatter.dateFormat = "d MMMM, yyyy"
    let localDateTimeString = dateFormatter.string(from: self)
    return localDateTimeString
  }
    
    var dateToDay:String{
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "d"
        let localDateTimeString = dateFormatter.string(from: self)
        return localDateTimeString
    }
    
    var dateToMonth:String{
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let localDateTimeString = dateFormatter.string(from: self)
        return localDateTimeString
    }
    
    var dateToYear:String{
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let localDateTimeString = dateFormatter.string(from: self)
        return localDateTimeString
    }
    
    
    
    var dateToSmartTime:String{
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let localDateTimeString = dateFormatter.string(from: self)
        return localDateTimeString
    }
    
    
    var dateToHour:String{
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "h"
        let localDateTimeString = dateFormatter.string(from: self)
        return localDateTimeString
    }
    
    var dateToMinute:String{
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "mm"
        let localDateTimeString = dateFormatter.string(from: self)
        return localDateTimeString
    }

    
    var dateToAmPm:String{
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "a"
        let localDateTimeString = dateFormatter.string(from: self)
        return localDateTimeString
    }
  

  
  
  func checkTimeInBetween(date1:Date,date2:Date) -> Bool{
    let todayDate = "\(Date())"
    
    return(min(date1, date2) ... max(date1, date2)).contains(self)
  }
  
  func offsetFrom(date:Date) -> String {
    
 //   let dayHourMinuteSecond: NSCalendar.Unit = [.day, .hour, .minute, .second]
 //   let difference = NSCalendar.currentCalendar.components(dayHourMinuteSecond, fromDate: date, toDate: self, options: [])
    var comp = Set<Calendar.Component>()
    comp.insert(.minute)
 //   let difference  = NSCalendar.current.dateComponents(, from: date, to: self)
  let difference  =   Calendar.current.dateComponents(comp, from: date, to: self).minute ?? 0
    
   
    return String(difference)
  }
  
  
 
    var yesterday: Date {
      return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
      return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
      return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
      return tomorrow.month != month
    }



}


public extension Float {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
