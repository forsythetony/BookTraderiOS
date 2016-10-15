//
//  UserInfo.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

struct UserInfo {
    
    static private let kUserName = "userName"
    static private let kEmail = "email"
    static private let kFirst = "first"
    static private let kLast = "last"
    static private let kPhone = "phonenum"
    static private let kProPic = "propic"
    static private let kPrimarySchool = "primaryschool"
    static private let kLocation = "location"
    static private let kAuthToken = "authtoken"
    static private let kMaxSaleRad = "maxsalerad"
    static private let kDateJoined = "datejoined"
    static private let kDateOfBirth = "dob"
    
    
    var userName : String?
    var email : String?
    var birthDate : Date?
    var firstName : String?
    var lastName : String?
    var password : String?
    var dateJoined : Date?
    var maxRange : Int?
    
    func convertToJSON() -> String? {
        
        let bucket = JSONBucket()
        
        
        bucket.addString(k: UserInfo.kEmail, v: email)
        bucket.addString(k: UserInfo.kAuthToken, v: password)
        bucket.addString(k: UserInfo.kFirst, v: firstName)
        bucket.addString(k: UserInfo.kLast, v: lastName)
        
        bucket.addDate(k: UserInfo.kDateOfBirth, v: birthDate, type: .API)
        bucket.addDate(k: UserInfo.kDateJoined, v: dateJoined, type: .API)
        
        bucket.addInt(k: UserInfo.kMaxSaleRad, v: maxRange)
        
        let data = bucket.convertToJSONData()
        
        guard let d = data else {
            return nil
        }
        
        let string_data = String(data: d, encoding: .utf8)
        
        return string_data
    }
}

struct UserLocation {
    
}
