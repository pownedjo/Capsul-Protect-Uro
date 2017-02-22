import UIKit

class EventVC: UITableViewController, UITextFieldDelegate
{
    @IBOutlet weak var changedEventType: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var drinkTypePicker: UIPickerView!
    
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
    
    lazy var eventsManager = { return EventModelController.eventsSharedInstance }()
    
    
    // Hide Save Event Button (or disable it before user do anyhting on the view)
    // Show back button - navigationController.navigationBar
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Custom Back Button
        self.navigationController?.navigationBar.backItem?.hidesBackButton = false
        
        self.hideKeyboardWhenTappedAround() // Hide Keyboard when tapping in the view
        quantityField.delegate = self       // Set Textfield Delegate
        drinkTypePicker.delegate = self     // Set PickerView Delegate
        drinkTypePicker.dataSource = self   // Set PickerView Datasource
    }

    
    
    // Change Event type and Update Static Table View
    @IBAction func changedEventTypeButtonPressed(_ sender: Any)
    {
        tableView.reloadData()  // Adapt tableView to Selected Event Type
        print("Index selected \(changedEventType.selectedSegmentIndex)")
    }
    
    
    
    @IBAction func saveEventButtonPressed(_ sender: Any)
    {
        print("SAVE EVENT PRESSED")

        // CHECK INPUT DATAS FOR GIVEN TYPE
        // THEN CREATE EVENT
        
        switch changedEventType.selectedSegmentIndex {
        case 0:         // Boisson
            
            let drinkEvent = EventBoisson.init(date: datePicker.date, quantite: 100.0, typeBoisson: "")
            print("ADD EVENT BOISSON = \(eventsManager.addEvent(event: drinkEvent))")
            self.navigationController?.popViewController(animated: true)

            
            
        case 1:         // Fuite

            let fuiteEvent = EventFuites.init(date: datePicker.date, importance: "", circonstances: "")
            print("ADD EVENT FUITE = \(eventsManager.addEvent(event: fuiteEvent))")
            self.navigationController?.popViewController(animated: true)

            
        case 2:        // Toilette

            let toiletEvent = EventToilette(date: datePicker.date, quantite: Double(quantityField.text!)!)
            
            // App crash when unwrap non optional value : Quantity TEXT
            
            print("ADD EVENT TOILET = \(eventsManager.addEvent(event: toiletEvent))")
            self.navigationController?.popViewController(animated: true)

            
        case 3:         // Date
            
            let simpleEvent = Event.init(type: .DateTime, date: datePicker.date)
            print("ADD EVENT BASIC = \(eventsManager.addEvent(event: simpleEvent))")
            self.navigationController?.popViewController(animated: true)

            
        default:
            print("DEFAUT")
        }
        
        
        /*
        if eventsManager.addEvent(event: myEvent)
        {
            print("SAVE EVENT SUCEED")
            // Dismiss VC
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            print("SAVE EVENT FAILED")
            // SHow Alerte
            let alert = UIAlertController(title: "Erreur", message: "Echec ajout d'événement", preferredStyle: .alert)

            self.present(alert, animated: true)
        }*/
    }
    
    
    // DatePicker selected Date Changed
    @IBAction func selectedDate(_ sender: Any)
    {
    }
    
    
    
    // Verify Input Datas before Saving Event
    func checkAllInputFields() -> Bool
    {
        // Check Quantity Field (only number) -> REGEX ?
        // Check Selected Date ?
        
        print("Selected Date : \(dateFormatter.string(from: datePicker.date))")
        print("Input Quantity : \(quantityField.text)")
        
        
        if quantityField.hasText
        {
            print("Quantity Field has text")
        }
        else
        {
            print("no quantity entered -> Retry saving event")
        }
        
        return true
    }
    
    
    // Called when return key pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()    // Dismiss the keyboard
        return true;
    }
    
    
    
    
    
    /* HIDE SECTIONS FUNCTION OF EVENT TYPE SELECTED IN SEGMENT CONTROL */
    
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
        case 2:                 // Section Quantité
            if changedEventType.selectedSegmentIndex == 1 || changedEventType.selectedSegmentIndex == 3
            {
                return true
            }
            return false
        case 3:                 // Section Type Date (Réveil, Dodo, Change Protec)
            if changedEventType.selectedSegmentIndex == 0 || changedEventType.selectedSegmentIndex == 1 || changedEventType.selectedSegmentIndex == 2
            {
                return true
            }
            return false
        case 4:                 // Section Circonstances Fuites (A l'effort, Impérieuse, Mixte)
            if changedEventType.selectedSegmentIndex == 0 || changedEventType.selectedSegmentIndex == 2 || changedEventType.selectedSegmentIndex == 3
            {
                return true
            }
            return false
        case 5:                 // Section Type Boisson
            if changedEventType.selectedSegmentIndex == 1 || changedEventType.selectedSegmentIndex == 2 || changedEventType.selectedSegmentIndex == 3
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



extension EventVC
{
    
}




/* Handle TypeDrink Picker View - Datasource : typeBoissonArray (Globale Helper class) */
extension EventVC: UIPickerViewDataSource, UIPickerViewDelegate
{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return typeBoissonArray.count;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return typeBoissonArray[row]
    }
    
    // selected row method ?
}
