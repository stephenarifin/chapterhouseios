//
//  MasterViewController.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 5/19/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

import UIKit

class MemberListViewController: UITableViewController {

    var memberList: [Member] = []


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.tableView

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        makeGetRequests()
        self.tableView.reloadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    } */
    
    func makeGetRequests() -> Void {
        
        let membersUrl = NSURL(string: "http://chapter-house-test.herokuapp.com/users")
        
        /*let task = NSURLSession.sharedSession().dataTaskWithURL(membersUrl!) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()*/
        
        var parsedJSON = parseJSON(getJSON("http://chapter-house-test.herokuapp.com/users"))
        memberList = populateMembers(parsedJSON) as! [Member]
        println(parsedJSON)
        
        println("Number of members: \(memberList.count)")
        
        for member in memberList {
            println("Members: " + member.fullName)
        }

    }
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSArray{
        var error: NSError?
        var membersDictionaryArray: NSArray = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        return membersDictionaryArray
    }
    
    func populateMembers(memberDictionaries: NSArray) -> NSArray{
        
        var memberArray: [Member] = []
        
        for member in memberDictionaries as NSArray {
            memberArray.append(Member(dictionary: member as! NSDictionary))
        }
        
        return memberArray
    }

    // MARK: - Segues
/*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as! NSDate
            (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    } */

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let member = memberList[indexPath.row] as Member
        cell.textLabel!.text = member.fullName
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

