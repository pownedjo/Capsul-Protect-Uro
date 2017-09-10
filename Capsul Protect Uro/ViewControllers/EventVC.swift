import UIKit
import SCLAlertView

class EventVC: UITableViewController
{
    @IBOutlet weak var changedEventType: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var drinkTypePicker: UIPickerView!
    @IBOutlet weak var changedBasicType: UISegmentedControl!
    @IBOutlet weak var changedCirconstancesFuite: UISegmentedControl!
    
    lazy var eventsManager = { return EventModelController.eventsSharedInstance }() // Singleton Instance

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() // Hide Keyboard when tapping in the view
        quantityField.delegate = self       // Set Textfield Delegate
        drinkTypePicker.delegate = self     // Set PickerView Delegate
        drinkTypePicker.dataSource = self   // Set PickerView Datasource
        
        self.navigationItem.titleView = getLogoImageView()  // Set logo to Navigation Bar Title
    }

    
    // Change Event type and Update Static Table View
    @IBAction func changedEventTypeButtonPressed(_ sender: Any)
    {
        tableView.reloadData()  // Adapt tableView to Selected Event Type (Drink, Toilette, etc..)
    }
    
    
    @IBAction func saveEventButtonPressed(_ sender: Any)
    {
        if checkInputFields()     // Input datas are correct
        {
            createNewEvent()      // Create new Event
        }
        else    // Input Datas not valid - Show Alert
        {
            SCLAlertView().showError("Attention!", subTitle: "Vous avez oublié de renseigner un volume pour cet événement.")
        }
    }
    
    
    // Verify Input Datas (Textfield) before Saving Event
    func checkInputFields() -> Bool
    {
        // Check Quantity Field for Boisson and Toilette Event
        if changedEventType.selectedSegmentIndex == 0 || changedEventType.selectedSegmentIndex == 2
        {
            if quantityField.hasText == false
            {
                return false
            }
        }
        return true
    }
    
    
    
    // Handle Creation of a new Event
    func createNewEvent()
    {
        switch changedEventType.selectedSegmentIndex {
        case 0:         // Boisson
            
            let drinkEvent = EventBoisson(date: datePicker.date, quantite: Double(quantityField.text!)!, typeBoisson: drinkTypePicker.selectedRow(inComponent: 0))
            save(event: drinkEvent)
            
        case 1:         // Fuite
            
            /** SECTION IMPORTANCES FUITES A FAIRE **/
 
            let fuiteEvent = EventFuites(date: datePicker.date, importance: 2, circonstances: "\(changedCirconstancesFuite.titleForSegment(at: getSelectedSegment(segmentedControl: changedCirconstancesFuite))!)")
            save(event: fuiteEvent)
            
        case 2:        // Toilette
            
            let toiletEvent = EventToilette(date: datePicker.date, quantite: Double(quantityField.text!)!)
            save(event: toiletEvent)

        case 3:         // Basic Event (Awakening, Bedtime, Changing Protec)

            switch changedBasicType.selectedSegmentIndex {
            case 0:
                save(event: handleBasicTypeEventCreation(type: .Awakening))
            case 1:
                save(event: handleBasicTypeEventCreation(type: .Bedtime))
            case 2:
                save(event: handleBasicTypeEventCreation(type: .ChangingProtection))
            default:
                print("Basic Type Event default case - should never be there")
            }
            
        default:
            print("Event creation default - should never be there")
        }
    }
    
    
    
    // Handle saving Event (Model)
    func save(event: Event)
    {
        if eventsManager.addEvent(event: event)
        {
            print("Save Event success")
            self.navigationController?.popViewController(animated: true)

            /* COMPLETION HANDLER ? RELOAD TABLE VIEW IN CALENDAR VC - */
        }
        else    // Error while saving Event
        {
            SCLAlertView().showError("Erreur", subTitle: "Une erreur s'est produite lors de l'enregistrement de cet événement, veuillez réessayer. Merci!")
        }
    }
    
    
    // Manage creation of basic Event according to selected Event type
    func handleBasicTypeEventCreation(type: EventType) -> Event
    {
        let basicEvent = Event(type: type, date: datePicker.date)
        return basicEvent
    }
    
    
    // Return Int for segmented control seletced segment
    func getSelectedSegment(segmentedControl: UISegmentedControl) -> Int
    {
        return segmentedControl.selectedSegmentIndex
    }
}



/* HIDE TABLE VIEW SECTIONS FUNCTION OF EVENT TYPE SELECTED IN SEGMENTED CONTROL */
extension EventVC
{
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if shdouldSectionBeHidden(section: section)
        {
            return 0.1
        }
        return super.tableView(tableView, heightForHeaderInSection: section)
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if shdouldSectionBeHidden(section: section)
        {
            return 0.1
        }
        return super.tableView(tableView, heightForFooterInSection: section)
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if shdouldSectionBeHidden(section: section)
        {
            return 0
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if shdouldSectionBeHidden(section: section)
        {
            return ""
        }
        return super.tableView(tableView, titleForHeaderInSection: section)
    }
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        if shdouldSectionBeHidden(section: section)
        {
            return ""
        }
        return super.tableView(tableView, titleForFooterInSection: section)
    }
    
    
    func shdouldSectionBeHidden(section : Int) -> Bool
    {
        switch section {
        case 0:                 // Section Event Type (Boisson, Fuites, Toilettes, Date)
            return false
        case 1:                 // Section Event Date & Time
            return false
        case 2:                 // Section Type BOISSON
            if changedEventType.selectedSegmentIndex == 1 || changedEventType.selectedSegmentIndex == 2 || changedEventType.selectedSegmentIndex == 3
            {
                return true
            }
            return false
            
        case 3:                 // Section Volume
            if changedEventType.selectedSegmentIndex == 1 || changedEventType.selectedSegmentIndex == 3
            {
                return true
            }
            return false
            
        case 4:                 // Section Type Date (Réveil, Dodo, Change Protec)
            if changedEventType.selectedSegmentIndex == 0 || changedEventType.selectedSegmentIndex == 1 || changedEventType.selectedSegmentIndex == 2
            {
                return true
            }
            return false
            
        case 5:                 // Section Circonstances Fuites (A l'effort, Impérieuse, Mixte)
            if changedEventType.selectedSegmentIndex == 0 || changedEventType.selectedSegmentIndex == 2 || changedEventType.selectedSegmentIndex == 3
            {
                return true
            }
            return false
            
        case 6:                 // Section Importance Fuite
            if changedEventType.selectedSegmentIndex == 0 || changedEventType.selectedSegmentIndex == 2 || changedEventType.selectedSegmentIndex == 3
            {
                return true
            }
            return false
        default:
            return true
        }
    }
}



/* Handle Quantity (Volume) TextField - Delegate methods */
extension EventVC: UITextFieldDelegate
{
    // Called when return key pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()    // Dismiss the keyboard
        return true;
    }
    
    
    // Textfield should only accept Integer (Quantity field mL)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
}



/* Handle TypeDrink Picker View - Datasource : DrinkTypeArray (Globale Helper class) */
extension EventVC: UIPickerViewDataSource, UIPickerViewDelegate
{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return drinkTypeArray.count;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return drinkTypeArray[row]
    }
}
