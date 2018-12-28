//
//  Constants.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 06/03/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

enum APIConstants :String {
    case
    isSuccess = "isSuccess",
    data = "data",
    items = "items",
    pageNo = "pageNo",
    total = "total"
}

struct appConstants{
    static let token = "token"
    static let profile = "profile"
    static let isprofileCompleted = "isprofileCompleted"
    static let orgToken = "orgToken"
    static let deviceId = "deviceId"
    static let id = "id"
    static let isArtist = "isArtist"
    static let artistID = "artistID"
    static let alreadyLoggedIn = "alreadyLoggedIn"
    static let picUrl = "picUrl"
    static let artistStatus = "artistStatus"
    static let email = "email"
    static let phone = "phone"
    static let code = "code"
    static let designation = "designation"
    static let name = "name"
    static let deviceType = "deviceType"
}
struct AppConstants{
    static let genderArray = ["Male","Female","Other","None"]
}

struct Constants {
    static let kUserDefaults = UserDefaults.standard
}
let kAppDelegate = AppDelegate().sharedInstance()
