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
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()

//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
        
        // Navigation menu code
        /* hide default navigation bar button item
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        
        let menuButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        menuButton.frame = CGRectMake(0, 0, 30, 30)
        menuButton.setImage(UIImage(named:"Menu.png"), forState: UIControlState.Normal)
        menuButton.addTarget(self, action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.setLeftBarButtonItem(menuBarButtonItem, animated: false)*/
        
//        let menuButton = UIBarButtonItem(barButtonSystemItem: <#UIBarButtonSystemItem#>, target: <#AnyObject?#>, action: <#Selector#>)
//        var menuButton = self.navigationItem.leftBarButtonItem
        
//        menuButton.target = self.revealViewController()
//        menuButton.action = "revealToggle:"
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        makeGetRequests()
        self.tableView.reloadData()
    
    }
    
/*    @IBAction func showMenu(sender: AnyObject) {
//        self.revealViewController()
        println("Show Menu Now")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("menu") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    } */

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
        
        var parsedJSON = HttpUtility.parseJSON(HttpUtility.getJSON("http://chapter-house-test.herokuapp.com/users"))
        memberList = populateMembers(parsedJSON) as! [Member]
        println(parsedJSON)
        
        println("Number of members: \(memberList.count)")
        
        for member in memberList {
            println("Members: " + member.fullName)
        }

    }
    
    func populateMembers(memberDictionaries: NSArray) -> NSArray{
        
        var memberArray: [Member] = []
        
        for member in memberDictionaries as NSArray {
            memberArray.append(Member(dictionary: member as! NSDictionary))
        }
        
        return memberArray
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMemberDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let memberSelected = memberList[indexPath.row] as Member
            (segue.destinationViewController as! MemberDetailViewController).member = memberSelected
            }
        }
    } 

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberCell", forIndexPath: indexPath) as! UITableViewCell

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

