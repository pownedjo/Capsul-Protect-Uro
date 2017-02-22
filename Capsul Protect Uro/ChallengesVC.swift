import UIKit

class ChallengesVC: UITableViewController
{
    
    var tableViewChallenges: Array<Challenge?> = []   // Array of Challenges to populate TableView

    var arrayTest = ["", "", ""]
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    

    // MARK: - Table view data source & Delegate

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableViewChallenges.count
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //return cell
    }*/

}
