import UIKit

class GroupChallengeVC: UIViewController
{
    /* Handle group of Challenges - Group Names (static?), Design and VC FLow */

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = getLogoImageView()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let backItem = UIBarButtonItem()
        backItem.title = "Retour"
        navigationItem.backBarButtonItem = backItem
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)    // Go back to ModulesVC
    }
    
    // kegelChallengesSegue - sleepChallengesSegue - drinkChallengesSegue
}
