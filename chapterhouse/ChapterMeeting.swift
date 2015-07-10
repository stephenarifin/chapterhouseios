//
//  ChapterMeeting.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 7/9/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

import Foundation

class ChapterMeeting {
    
    var id: Int
    var created_at: String
    var closed_at: String
    
    init(dictionary: NSDictionary) {
        
        id = (dictionary["id"] as? Int)!
        created_at = (dictionary["created_at"] as? String)!
        closed_at = (dictionary["closed_at"] as? String)!
        
    }
    
}
