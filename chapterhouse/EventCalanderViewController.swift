//
//  EventCalanderViewController.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 5/28/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

import CVCalendar


class EventCalanderViewController: UIViewController {
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.calendarView.commitCalendarViewUpdate()
        self.menuView.commitMenuViewUpdate()
    }
}
