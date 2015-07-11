//
//  ChapterListViewController.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 7/9/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

import UIKit

class ChapterListViewController: UITableViewController {
    
    var chapterMeetingList: [ChapterMeeting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        makeGetRequests()
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeGetRequests() -> Void {
        
        var parsedJSON = HttpUtility.parseJSON(HttpUtility.getJSON("http://chapter-house-test.herokuapp.com/chapter_meetings"))
        chapterMeetingList = populateChapterMeetings(parsedJSON) as! [ChapterMeeting]
        println(parsedJSON)
        
        println("Number of chapter meetings: \(chapterMeetingList.count)")
        
        for chapterMeeting in chapterMeetingList {
            println("Chapter id: " + chapterMeeting.id.description)
            println("Chapter starting time: " + chapterMeeting.created_at)
        }
        
    }
    
    func populateChapterMeetings(chapterDictionaries: NSArray) -> NSArray{
        
        var chapterMeetingArray: [ChapterMeeting] = []
        
        for chapterMeeting in chapterDictionaries as NSArray {
            chapterMeetingArray.append(ChapterMeeting(dictionary: chapterMeeting as! NSDictionary))
        }
        
        return chapterMeetingArray
    }
    

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showChapterMeetingDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let chapterMeetingSelected = chapterMeetingList[indexPath.row] as ChapterMeeting
                (segue.destinationViewController as! ChapterDetailViewController).chapterMeeting = chapterMeetingSelected
            }
        }
    }


    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapterMeetingList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChapterMeetingCell", forIndexPath: indexPath) as! UITableViewCell
        
        let chapterMeeting = chapterMeetingList[indexPath.row] as ChapterMeeting
        cell.textLabel!.text = chapterMeeting.created_at
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    objects.removeAtIndex(indexPath.row)
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
    } */


}
