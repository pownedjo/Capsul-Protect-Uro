import UIKit

/** Event Model 
    
Event Type :
 - Heure de Réveil / Heure d'endordissement / Heure Changement des protections (1 Field Date)
 - Pause Toilettes (2 Fields : Date / Quantité)
 - Boissons (3 Fields : Date / Quantité / Type Boisson Integer)
 - Fuites (3 Fields : Date / Importance / Circonstance Integer)
 
    Base Class : Event
    Subclasses : Event Toilette, Event Fuite, Event Boisson
 
 **/
class Event: NSObject
{
    let type: EventType!
    let date: Date!      // Date format : dd/MM/yyyy hh:mm


    init(type: EventType, date: Date)
    {
        self.type = type
        self.date = date
    }
    
    
    func tableViewDescription() -> String
    {
        return "Event Base"
    }
    
}


/* */
class EventToilette: Event
{
    let quantite: Double
    
    init(date: Date, quantite: Double)
    {
        self.quantite = quantite
        
        super.init(type: EventType.Toilette, date: date)
    }
    
    
    override func tableViewDescription() -> String
    {
        return "Pause Toilettes"
    }
}


/* */
class EventBoisson: Event
{
    let quantite: Double
    let typeBoisson: String
    
    
    init(date: Date, quantite: Double, typeBoisson: String)
    {
        self.quantite = quantite
        self.typeBoisson = typeBoisson
        
        super.init(type: EventType.Boisson, date: date)
    }
    
    
    override func tableViewDescription() -> String
    {
        return "Pause Boisson"
    }
}


/* */
class EventFuites: Event
{
    let importance: String  // Maybe an Integer
    let circonstances: String   // Maybe an Integer too
    
    init(date: Date, importance: String, circonstances: String)
    {
        self.importance = importance
        self.circonstances = circonstances
        
        super.init(type: EventType.Fuite, date: date)
    }
    
    
    override func tableViewDescription() -> String
    {
        return "Pause Fuites"
    }
}



/* ENUM EVENT TYPES */
enum EventType
{
    case DateTime   //  Réveil, Endordissement, Changement des protections
    case Fuite
    case Boisson
    case Toilette
    
    func imageForEventType() -> UIImage
    {
        switch self {
        case .DateTime:
            return #imageLiteral(resourceName: "timer-clock.png")       // timer-clock.png
        case .Boisson:
            return #imageLiteral(resourceName: "water.png")       // water.png
        case .Fuite:
            return #imageLiteral(resourceName: "puddles.png")       // puddies.png
        case .Toilette:
            return #imageLiteral(resourceName: "toilet.png")       // toilet.png
        }
    }
}
