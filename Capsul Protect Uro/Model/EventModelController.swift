/** Event Model Controller
 
   Singleton Class
   Contains Every Events related to a User stored in an Array
   1 unique Events Array for each User  
 
 **/
import UIKit

class EventModelController: NSObject
{
    static let eventsSharedInstance = EventModelController()    // Access my Singleton
    var eventsForUser: [Event]?     // User Calendar (Array of Events)
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    fileprivate lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()

    
    // Change to Private HERE
    private override init()
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
    func checkEventsFor(aDate: Date) -> Bool
    {
        if eventsForUser != nil
        {
            for event in eventsForUser!
            {
                // Date has Events (String comparaison with format : dd/MM/yyyy)
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
    
    
    // Return String for setting Detail Description in TableView Cell
    func tableViewDetailDescriptionFor(anEvent: Event) -> String
    {
        return anEvent.tableViewDetailDescription()
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
