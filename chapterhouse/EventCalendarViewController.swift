//
//  EventCalanderViewController.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 5/28/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

// import CVCalendar


class EventCalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var eventTableView: UITableView!
    
    // Calendar variables
    var shouldShowDaysOut = true
    var animationFinished = true
    
    var events = [NSDate: [Event]]()
    
    
    // Event table view variables
    let eventTextCellIdentifier = "EventTextCell"
    
    // Segue variables
    let eventDetailSegueIdentifier = "showEventDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update month title before the view loads
        monthLabel.text = CVDate(date: NSDate()).globalDescription
        
        // For EventTableView
        eventTableView.delegate = self
        eventTableView.dataSource = self
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        makeGetRequests()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
        
        // Update event tableview for initial date
        eventTableView.reloadData()
    }
    
    
    // Receive event information from back-end
    func makeGetRequests() -> Void {
        
        var parsedJSON = HttpUtility.parseJSON(HttpUtility.getJSON("http://chapter-house-test.herokuapp.com/events"))
        
        var eventList = populateEvents(parsedJSON) as! [Event]
        
        // Place all events in the dictionary
        for event in eventList {
            var date = NSCalendar.currentCalendar().startOfDayForDate(event.start_date)
            if(events[date] == nil) {
                events[date] = []
                events[date]!.append(event)
            }
            else {
                events[date]!.append(event)
            }
        }
        println(parsedJSON)
        
        println("Number of events: \(eventList.count)")
        
        for event in eventList {
            println(event.start_date)
        }
    }
    
    func populateEvents(eventDictionaries: NSArray) -> NSArray{
        
        var eventArray: [Event] = []
        
        for event in eventDictionaries as NSArray {
            eventArray.append(Event(dictionary: event as! NSDictionary))
        }
        
        return eventArray
    }
    
    
    
    // Functions for EventTableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Event content in each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(eventTextCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        
        // Get the events on the selected date
        var selectedDate = calendarView.presentedDate.convertedDate()
        
        // If there are events on the selected day
        if (events[selectedDate!] != nil) {
            var eventArray: [Event] = events[selectedDate!]!
            cell.textLabel!.text = eventArray[row].title
            
            // Enable user interaction
            cell.selectionStyle = UITableViewCellSelectionStyle.Blue
            cell.userInteractionEnabled = true
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        }
            
        // If there are no events on the selected day
        else {
            cell.textLabel!.text = "No events"
            
            // Disable user interaction with the event row
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.userInteractionEnabled = false
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the events on the selected date
        var selectedDate = calendarView.presentedDate.convertedDate()
        
        if segue.identifier == eventDetailSegueIdentifier && events[selectedDate!] != nil {
            if let destination = segue.destinationViewController as? EventDetailViewController {
                if let eventIndex = eventTableView.indexPathForSelectedRow()?.row {
                    var eventArray: [Event] = events[selectedDate!]!
                    destination.event = eventArray[eventIndex]

                }
            }
        }
    }
    
}


extension EventCalendarViewController: CVCalendarViewDelegate
{
    func supplementaryView(viewOnDayView dayView: CVCalendarDayView) -> UIView
    {
        let π = M_PI
        
        let ringSpacing: CGFloat = 3.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour: UIColor = .blueColor()
        
        var newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.CGColor
        
        var ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.CGPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    // Fills the calendar with events
    func supplementaryView(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool
    {
        
        // Hashtable lookup
        if (dayView.date != nil) {
            if (events[dayView.date.convertedDate()!] != nil) {
                return true
            }
        }
        
        return false
    }
    
}


extension EventCalendarViewController: CVCalendarViewDelegate {
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    
    // When the presented date updates
    func didSelectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date
        println("\(calendarView.presentedDate.commonDescription) is selected!")
        eventTableView.reloadData()
    }
    
    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
                }) { _ in
                    
                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransformIdentity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        //let day = dayView.date.day
        //let randomDay = Int(arc4random_uniform(31))
        //if day == randomDay {
        //    return true
        //}
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> UIColor {
        let day = dayView.date.day
        
        let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return color
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
}

// MARK: - CVCalendarViewAppearanceDelegate

extension EventCalendarViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

// MARK: - CVCalendarMenuViewDelegate

extension EventCalendarViewController: CVCalendarMenuViewDelegate {
    // firstWeekday() has been already implemented.
}

