import UIKit

class CoachingMainVC: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.titleView = getLogoImageView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    

    // Pass coaching title, yt video URL & details description to next VC (CoachingSpecificVC)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("Prepare For Segue!")
        let coachingSpecific = segue.destination as? CoachingSpecificVC     // Destination VC
        let backItem = UIBarButtonItem()
        backItem.title = "Retour"
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "coachingKegel"
        {
            coachingSpecific?.coachingTitle = "Conseils pour réussir vos exercices de Keggel"
            coachingSpecific?.youtubeVideoURL = "https://www.youtube.com/embed/idxkLOpfdvE"
            
            // ADD custom TextView description for specific coaching
        }
        
        if segue.identifier == "coachingStimuation"
        {
            coachingSpecific?.coachingTitle = "Réaliser vos exercices de stimulation"
            coachingSpecific?.youtubeVideoURL = "https://www.youtube.com/embed/VrswTgjqUxE"
        }
    
        if segue.identifier == "coachingKine"
        {
            coachingSpecific?.coachingTitle = "Conseils pour kinésithérapie"
            coachingSpecific?.youtubeVideoURL = "https://www.youtube.com/embed/wcjQLkVW65A"
        }
    }

    
    @IBAction func backButtonPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)    // Go back to ModulesVC
    }
}
