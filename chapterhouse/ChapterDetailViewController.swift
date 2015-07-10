//
//  ChapterDetailViewController.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 7/9/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

class ChapterDetailViewController: UIViewController {

    
    var chapterMeeting: ChapterMeeting?
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let chapterMeeting: ChapterMeeting = self.chapterMeeting {
            
            if let createdAt = self.createdAtLabel {
                createdAtLabel.text = chapterMeeting.created_at
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
