//
//  DetailViewController.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 5/19/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    var member: Member?
    
    @IBOutlet weak var memberName: UILabel!

    @IBOutlet weak var pageTitle: UINavigationItem!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let member: Member = self.member {
            
            if let title = self.pageTitle {
                title.title = member.fullName
            }
            
            if let label = self.memberName {
                label.text = member.fullName
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

