import UIKit


/** Event Model Controller
 
   Singleton Class
   Contains Every Events related to User in an Array
   1 unique Events Array for each User  
 
 **/
class EventModelController: NSObject
{
    static let eventsSharedInstance = EventModelController()
    var eventsForUser: [Event]?
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    fileprivate lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter
    }()

    
    override init()
    {
        print("Init Shared Instance Array")
        eventsForUser = [Event]()   // Init ARRAY
    }
    
    
    
    // ADD Event to global Events Array - Return True if Success
    func addEvent(event: Event) -> Bool
    {
        self.eventsForUser?.append(event)
        return true
    }

    
    
    // Delete Event
    func delete(event: Event) -> Bool
    {
        var indexEvent: Int
        
        for anEvent in eventsForUser!
        {
            if anEvent == event     // Find corresponding Event
            {
                indexEvent = (eventsForUser?.index(of: anEvent))!   // Find its Index
                eventsForUser?.remove(at: indexEvent)               // Remove from Array
                return true
            }
        }
        return false
    }

    
    
    // Check if Date has Events
    func checkEventsFor(aDate: Date) -> Bool    // Date format : dd/MM/yyyy
    {
        if eventsForUser != nil
        {
            for event in eventsForUser!
            {
                // Date has Events (String comparaison)
                if dateFormatter.string(from: event.date) == dateFormatter.string(from: aDate)
                {
                    return true
                }
            }
            return false
        }
        return false
    }
    
    
    
    // Return String for setting Event Description in TableView Cell
    func tableViewDescriptionFor(anEvent: Event) -> String
    {
        return "\(timeFormatter.string(from: anEvent.date))     \(anEvent.tableViewDescription())"
    }
    
    
    
    // Return Image for Event TableView Cell according to Event Type
    func tableViewImageFor(anEvent: Event) -> UIImage
    {
        return anEvent.type.imageForEventType()
    }
    
    
    
    // Get Events for a given Date
    func getAllEvents(forDate: Date) -> [Event]?
    {
        var arrayOfEvents = [Event]()
        
        for event in eventsForUser!
        {
            // Date has Events (String comparaison)
            if dateFormatter.string(from: event.date) == dateFormatter.string(from: forDate)
            {
                arrayOfEvents.append(event)
            }
        }
        return arrayOfEvents
    }
    
    
    
    // Get all Events in String Format
    func getAllEvents() -> String?
    {
        // Iterate over each Event and display as String -> Add Method in Event Classees (description)
        
        return "Events Count : \(self.eventsForUser?.count) - \(self.eventsForUser?.description)"
    }
}
