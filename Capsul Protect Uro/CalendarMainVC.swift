import UIKit
import FSCalendar

class CalendarMainVC: UIViewController, FSCalendarDataSource, FSCalendarDelegate
{
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var calendarModeSwitch: UISegmentedControl!
    
    var tableViewEventsData: Array<Event?> = [] // Array of Events to populate bottom TableView
    
    lazy var eventsManager = { return EventModelController.eventsSharedInstance }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Hide empty cells in tableView
        eventsTableView.tableFooterView = UIView()
        
        // Calendar Delegate/Datasource
        calendar.dataSource = self
        calendar.delegate = self
        
        // TableView Delegate/Datasource
        eventsTableView.delegate = self
        eventsTableView.dataSource = self

        adaptCalendarUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        // Check calendar datas
        self.calendar.reloadData()
        
        // Reload Events tableView
        reloadEventstableView()
    }
    
    
    // Make every changes on Calendar UI when ViewDidLoad
    func adaptCalendarUI()
    {
        calendar.select(Date())
        calendar.scope = .month
        // Use Monday as first column :
        //calendar.firstWeekday = 2
    }
    
    
    // Adapt Calendar Modes : Week & Month view
    @IBAction func changeCalendarMode(_ sender: Any)
    {
        /*
        if self.calendar.scope == .month
        {
            self.calendar.scope = .week
        }
        else
        {
            self.calendar.scope = .month
        }*/
    }
    
    
    @IBAction func addCalendarEvent(_ sender: Any)
    {
        performSegue(withIdentifier: "goToAddEventVC", sender: nil)
    }
    
    
    /***** FSCALENDAR DELEGATE METHODS *****/
    
    // Show dots when date has events
    func calendar(hasEventForDate date: Date!) -> Bool
    {
        return true
    }
    
    
    // FSCalendarDelegate - DO SOMETHING WHEN A DATE IS SELECTED - Date : format dd/MM/yyyy
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        print("did select date \(dateFormatter.string(from: date))")
        print("\(eventsManager.getAllEvents())")
        
        if eventsManager.checkEventsFor(aDate: date)
        {
            print("DATE HAS EVENTS ASSOCIATED !")
            tableViewEventsData = (eventsManager.getAllEvents(forDate: date))!
            
            print("Number of event for \(dateFormatter.string(from: date)) : \(eventsManager.getAllEvents(forDate: date)?.count))")
            
            reloadEventstableView()
        }
        else
        {
            print("DATE HAS NO EVENTS !")
            tableViewEventsData.removeAll()
            reloadEventstableView()
        }
        
        
        if monthPosition == .next || monthPosition == .previous
        {
            print("Calendar change Month View")
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar)
    {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    
    // Adapt height layout constraint from Week mode to Month mode
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool)
    {
        //self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
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
            }
            else
            {
                // Handle AlerteController here
                print("Error while deleting Cell Event")
            }
        }
    }
    
    
    // Update Table View to display events according to selected date
    func reloadEventstableView()
    {
        DispatchQueue.main.async{
            self.eventsTableView.reloadData()
        }
    }
}
