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
    
    init(dictionary: NSDictionary) {
        fullName = (dictionary["long_full_name"] as? String)!
    }
    
}
