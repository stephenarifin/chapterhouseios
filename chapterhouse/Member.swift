//
//  Member.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 5/25/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

import Foundation

class Member {
    
    var fullName: String
//    var phone: String
    var email: String
//    var pin: String
//    var city: String
//    var state: String
    
    var firstName: String
//    var middleName: String
    var lastName: String
    
    var pledgeClass: String
    
    init(dictionary: NSDictionary) {
        fullName = (dictionary["long_full_name"] as? String)!
//        phone = (dictionary["phone"] as? String)!
        email = (dictionary["email"] as? String)!
//        pin = (dictionary["pin"] as? String)!
//        city = (dictionary["city"] as? String)!
//        state = (dictionary["state"] as? String)!
        
        firstName = (dictionary["first_name"] as? String)!
//        middleName = (dictionary["middle_name"] as? String)!
        lastName = (dictionary["last_name"] as? String)!
        
        pledgeClass = (dictionary["pledge_class"] as? String)!
    }
    
}
