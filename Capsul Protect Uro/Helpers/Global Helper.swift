import Foundation
import UIKit


/* CONSTANTS */
let capsulProtectURL = URL(string: "https://www.capsulprotect.com/")
let webServiceURL: String = "https://capsulprotect.com/api/"
let eventCellID: String = "event_cell_id"   // Manage ID in Storyboard too
let challengeCellID: String = "challenge_cell_id"   // Manage ID in Storyboard too
let globalAppColor = UIColor(red: 20/255.0, green: 175/255.0, blue: 170/255.0, alpha: 1)
let tabBarTintColor = UIColor(red: 240/255.0, green: 126/255.0, blue: 137/255.0, alpha: 1)
let drinkTypeArray = ["Alcools", "Boissons énergisantes", "Boissons lactées", "Cafés", "Cocktails non alcoolisés", "Eaux", "Jus de fruit", "Jus de légumes", "Limonades", "Maté", "Nectars de fruits", "Sodas", "Sirops", "Thés", "Tisanes"]

// Coaching Texts (Lorrem ipsum .. for now)
let kegelExercicesAdvices: String = ""
let mictionsExercicesAdvices: String = ""


/* Date & Time Formatters */
var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()

var timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm"
    return formatter
}()

var customDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy hh:mm"
    return formatter
}()



/* ENUMS VC */
enum ViewControllerType
{
    case welcome
    case modules
}


/* Hide Keyboard when tape detected anywhere in the view */
extension UIViewController
{
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


/* Get Logo Image for Navigation Bar Title in all VC */
func getLogoImageView() -> UIImageView
{
    let logoImage = UIImageView(frame: CGRect(x:0, y:0, width: 180, height: 33))
    logoImage.contentMode = .scaleAspectFit
    let logo = UIImage(named: "bandeau_cp.png") // Image to display
    logoImage.image = logo
    
    return logoImage
}




/* TESTING PURPOSES - FULFILL CALENDAR WITH RANDOM EVENTS */
var eventsManager = { return EventModelController.eventsSharedInstance }() // Singleton Instance
let arrayTest = [
    ["Awakening", "06/03/2017 07:45"], ["Changement", "06/03/2017 08:00"], ["Drink", "06/03/2017 08:20", "3", "250"], ["Drink", "06/03/2017 09:45", "2", "250"], ["Toilettes", "06/03/2017 10:00", "200"], ["Changement", "06/03/2017 10:10"], ["Drink", "06/03/2017 10:30", "5", "600"], ["Bedtime", "06/03/2017 11:00"],
    
    ["Awakening", "07/03/2017 08:00"], ["Drink", "07/03/2017 08:30", "3", "250"], ["Toilettes", "07/03/2017 08:35", "400"], ["Changement", "07/03/2017 09:00"], ["Drink", "07/03/2017 10:30", "6", "300"], ["Bedtime", "07/03/2017 10:45"],
    
    ["Awakening", "08/03/2017 07:30"], ["Changement", "08/03/2017 08:00"], ["Drink", "08/03/2017 08:20", "5", "250"], ["Drink", "08/03/2017 09:45", "8", "250"], ["Toilettes", "08/03/2017 10:00", "200"], ["Changement", "08/03/2017 10:10"], ["Drink", "08/03/2017 10:30", "1", "600"], ["Bedtime", "08/03/2017 11:00"]
]

func parseArrayTest()
{
    for event in arrayTest
    {
        switch event[0] {
        case "Awakening":
            let basicEvent = Event.init(type: .Awakening, date: customDateFormatter.date(from: event[1])!)
            print("\(eventsManager.addEvent(event: basicEvent))")
        case "Drink":
            let drinkEvent = EventBoisson.init(date: customDateFormatter.date(from: event[1])!, quantite: Double(event[3])!, typeBoisson: Int(event[2])!)
            print("\(eventsManager.addEvent(event: drinkEvent))")
        case "Fuites":
            print("Event Fuites")
        case "Toilettes":
            let toiletEvent = EventToilette.init(date: customDateFormatter.date(from: event[1])!, quantite: Double(event[2])!)
            print("\(eventsManager.addEvent(event: toiletEvent))")
        case "Bedtime":
            let basicEvent2 = Event.init(type: .Bedtime, date: customDateFormatter.date(from: event[1])!)
            print("\(eventsManager.addEvent(event: basicEvent2))")
        case "Changement":
            let basicEvent3 = Event.init(type: .ChangingProtection, date: customDateFormatter.date(from: event[1])!)
            print("\(eventsManager.addEvent(event: basicEvent3))")
        default:
            print("Error parsing Array")
        }
    }
}
