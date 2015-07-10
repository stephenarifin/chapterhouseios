//
//  Event.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 6/3/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

class Event {
    
    var title: String
    
    var start_date: NSDate!
    var end_date: NSDate!
    
    var location: String
    var description: String
    
    init(dictionary: NSDictionary) {
        
        title = (dictionary["title"] as? String)!
        
        let startDateString = dictionary["start_date"] as! String
        let endDateString = dictionary["end_date"] as! String
        

        
        location = (dictionary["location"] as? String)!
        description = (dictionary["description"] as? String)!
        
        start_date = convertStringToNSDate(startDateString)
        end_date = convertStringToNSDate(endDateString)

        
        
    }
    
    private func convertStringToNSDate(date: String) -> NSDate {

        // Date formatter
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSS"
    
        // Format the string correctly
        let endIndexFirst = advance(date.startIndex, 10)
        let dateFirst: String = date.substringToIndex(endIndexFirst)
        
        let startIndexSecond = advance(date.startIndex, 11)
        let endIndexSecond = advance(date.startIndex, 23)
        let dateSecond: String = date.substringWithRange(Range<String.Index>(start: startIndexSecond, end: endIndexSecond))
        
        let dateString = dateFirst + " " + dateSecond
        
        // Convert the date string to NSDate
        return dateFormatter.dateFromString(dateString)!
    }

}

extension NSDate {
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
}