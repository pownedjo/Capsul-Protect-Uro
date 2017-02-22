import Foundation
import UIKit


// CONSTANTS
let webServiceURL: String = "https://capsulprotect.com/api/"
let eventCellID: String = "event_cell_id"   // Manage ID in Storyboard too
let globalAppColor = UIColor(red: 20, green: 175, blue: 170, alpha: 1)
let typeBoissonArray = ["Alcools", "Boissons énergisantes", "Boissons lactées", "Cafés", "Cocktails non alcoolisés", "Eaux", "Jus de fruit", "Jus de légumes", "Limonades", "Maté", "Nectars de fruits", "Sodas", "Sirops", "Thés", "Tisanes"]



// ENUMS
enum ViewControllerType
{
    case welcome
    case conversations
    case calendar
    case menu
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
