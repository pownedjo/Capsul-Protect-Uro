import UIKit
import FSCalendar

class CalendarMainVC: UIViewController, UIGestureRecognizerDelegate
{
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!    // Calendar height = 250
    
    var lastSelectedDate: Date?  // Store the last selcted date for reloading Events tableView
    var tableViewEventsData: Array<Event?> = [] // Array of Events to populate bottom TableView
    lazy var eventsManager = { return EventModelController.eventsSharedInstance }() // Singleton Instance
    
    // Gesture Recognizer handle changing from month to week Calendar mode
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        eventsTableView.tableFooterView = UIView()  // Hide empty cells in tableView
        self.navigationItem.titleView = getLogoImageView()
        
        // Calendar Delegate/Datasource
        calendar.dataSource = self
        calendar.delegate = self
        
        // TableView Delegate/Datasource
        eventsTableView.delegate = self
        eventsTableView.dataSource = self

        adaptCalendarUI()   // Make changes on calendar UI
        
        self.view.addGestureRecognizer(self.scopeGesture)
        self.eventsTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("View Did appear")
        
        self.eventsTableView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        self.calendar.reloadData()  // Reload Calendar
        
        /* Reload Events Table View */
        if let lastSelectedDate = lastSelectedDate
        {
            reloadDatasInEventsTableViewFor(adate: lastSelectedDate)
        }
        else
        {
            lastSelectedDate = Date()
            reloadDatasInEventsTableViewFor(adate: lastSelectedDate!)
        }
    }
    
    
    // Make every changes on Calendar UI when ViewDidLoad
    func adaptCalendarUI()
    {
        calendar.select(Date())
        calendar.scope = .month
    }
    
    
    
    @IBAction func addEventButtonPressed(_ sender: Any)
    {
        performSegue(withIdentifier: "goToAddEventVC", sender: nil)
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)    // Go back to ModulesVC
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let backItem = UIBarButtonItem()
        backItem.title = "Retour"
        navigationItem.backBarButtonItem = backItem // Will show in the next view controller being pushed
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        let shouldBegin = self.eventsTableView.contentOffset.y <= -self.eventsTableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
}




/***** FSCALENDAR DELEGATE & DATASOURCE METHODS *****/
extension CalendarMainVC: FSCalendarDelegate, FSCalendarDataSource
{
    // Show one dot on Calendar when date has Events
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int
    {
        if eventsManager.checkEventsFor(aDate: date)
        {
            return 1    // if Date has Events show 1 dot
        }
        return 0
    }
    
    
    // User select specific date on Calendar
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        print("Select date :  \(dateFormatter.string(from: date))")
        
        lastSelectedDate = date // Use for refreshing Table View in viewWillAppear
        reloadDatasInEventsTableViewFor(adate: date)
        
        if monthPosition == .next || monthPosition == .previous
        {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    
    
    // Adapt Calendar height for Week mode & Month mode
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool)
    {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    
    
    func reloadDatasInEventsTableViewFor(adate: Date)
    {
        if eventsManager.checkEventsFor(aDate: adate)
        {
            tableViewEventsData = (eventsManager.getAllEvents(forDate: adate))!
            reloadEventstableView()
        }
        else
        {
            tableViewEventsData.removeAll()
            reloadEventstableView()
        }
    }
}




/****** EVENTS TABLE VIEW DELEGATE & DATASOURCE METHODS *****/
extension CalendarMainVC: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableViewEventsData.count
    }
    
    
    
    // Display Event in TableView Cells - Customize Event Cell with Image & Description
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: eventCellID) as! EventTableViewCell
        
        cell.imageEvent.image = eventsManager.tableViewImageFor(anEvent: tableViewEventsData[indexPath.row]!)
        cell.descriptionEventLabel.text = eventsManager.tableViewDescriptionFor(anEvent: tableViewEventsData[indexPath.row]!)
        cell.detailsDescriptionLabel.text = eventsManager.tableViewDetailDescriptionFor(anEvent: tableViewEventsData[indexPath.row]!)
        
        return cell
    }
    
    
    
    // Swipe to delete Method (Table View Delegate)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Remove event from the model
            if eventsManager.delete(event: tableViewEventsData[indexPath.row]!)
            {
                // Remove event from the View (TableViewEvents)
                tableViewEventsData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.calendar.reloadData()
            }
            else
            {
                // Handle AlerteController here - Could not delete selected Event - Should not happen
                print("Error while deleting Cell Event")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
        return "Supprimer" // Delete message for Swipe to Delete functionality
    }
    
    
    // Update Table View on Main Thread for display events according to selected date
    func reloadEventstableView()
    {
        DispatchQueue.main.async{
            self.eventsTableView.reloadData()
        }
    }
}
