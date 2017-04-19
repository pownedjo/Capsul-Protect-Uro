import UIKit

class ChallengeVC: UIViewController
{
    @IBOutlet weak var tableViewChallenges: UITableView!
    
    var arrayChallenges: Array<Challenge?> = []   // Array of Challenges to populate TableView
    var arrayTest = ["Challenge 1", "Challenge 2", "Challenge 3", "Challenge 4"]
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = getLogoImageView()
        
        tableViewChallenges.addSubview(self.refreshControl)  // Add refreshControl to tableView
        tableViewChallenges.tableFooterView = UIView()  // Hide empty cells in tableView
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableViewChallenges.reloadData()
    }
    
    
    
    func handleRefresh(refreshControl: UIRefreshControl)
    {
        // Fetch more objects from Web Service
        
        print("Hit Pull to refresh")
        
        arrayTest.append("Challenge \(arrayTest.count + 1)")   // Test adding event while pull to refresh
        tableViewChallenges.reloadData()
        refreshControl.endRefreshing()
    }
    
    /* GET DATAS FROM WEB SERVICE */
}



/* Handle Table View Delegate & Datasource Methods */
extension ChallengeVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayTest.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ChallengeTableViewCell = tableView.dequeueReusableCell(withIdentifier: challengeCellID) as! ChallengeTableViewCell
        
        // cell.imageChallenge = #imageLiteral(resourceName: "Checkmark-icon.png")    // CHeckMark icon
        cell.descriptionLabel.text = arrayTest[indexPath.row]
        
        /* cell.descriptionEventLabel.text = eventsManager.tableViewDescriptionFor(anEvent: tableViewEventsData[indexPath.row]!)*/
        
        return cell
    }
}

