//
//  HttpUtility.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 6/8/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

class HttpUtility {

    static func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    static func parseJSON(inputData: NSData) -> NSArray{
        var error: NSError?
        var membersDictionaryArray: NSArray = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        return membersDictionaryArray
    }
    
}
