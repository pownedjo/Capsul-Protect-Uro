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
        return "Evènement"
    }
    
    
    func tableViewDetailDescription() -> String
    {
        return type.rawValue
    }
}


/* */
class EventToilette: Event
{
    let quantite: Double
    
    init(date: Date, quantite: Double)
    {
        self.quantite = quantite
        
        super.init(type: EventType.Restroom, date: date)
    }
    
    
    override func tableViewDescription() -> String
    {
        return "Pause Toilettes"
    }
    
    
    override func tableViewDetailDescription() -> String
    {
        return "Quantité : \(quantite) mL"
    }
}


/* */
class EventBoisson: Event
{
    let quantite: Double
    let typeBoisson: Int    // From drinkTypeArray in Global Helper
    
    
    init(date: Date, quantite: Double, typeBoisson: Int)
    {
        self.quantite = quantite
        self.typeBoisson = typeBoisson
        
        super.init(type: EventType.Drink, date: date)
    }
    
    
    override func tableViewDescription() -> String
    {
        return "Pause Boisson"
    }
    
    
    override func tableViewDetailDescription() -> String
    {
        return "Quantité : \(quantite) mL - Type : \(drinkTypeArray[typeBoisson])"
    }
}


/* */
class EventFuites: Event
{
    let importance: Int  // Maybe an Integer
    let circonstances: String   // Maybe an Integer too
    
    init(date: Date, importance: Int, circonstances: String)
    {
        self.importance = importance
        self.circonstances = circonstances
        
        super.init(type: EventType.Leak, date: date)
    }
    
    
    override func tableViewDescription() -> String
    {
        return "Evènement Fuites"
    }
    
    
    override func tableViewDetailDescription() -> String
    {
        return "Importance : \(importance) - Circonstances : \(circonstances)"
    }
}



/* ENUM EVENT TYPES */
enum EventType: String
{
    case Leak = "Fuites"
    case Drink = "Boisson"
    case Restroom = "Toilette"
    
    // Basic Event Types (Date field) :
    case Awakening = "Heure de réveil"
    case Bedtime = "Heure de coucher"
    case ChangingProtection = "Changement des protections"
    
    
    func imageForEventType() -> UIImage
    {
        switch self {
        case .Drink:
            return #imageLiteral(resourceName: "water.png")       // water.png
        case .Leak:
            return #imageLiteral(resourceName: "puddles.png")       // puddies.png
        case .Restroom:
            return #imageLiteral(resourceName: "toilet.png")       // toilet.png
        case .Awakening:
            return #imageLiteral(resourceName: "timer-clock.png")       // timer-clock.png
        case .Bedtime:
            return #imageLiteral(resourceName: "timer-clock.png")       // timer-clock.png
        case .ChangingProtection:
            return #imageLiteral(resourceName: "timer-clock.png")       // timer-clock.png
        }
    }
}
