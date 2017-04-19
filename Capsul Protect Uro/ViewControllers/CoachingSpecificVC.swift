import UIKit

class CoachingSpecificVC: UIViewController
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var youtubeVideoContainer: UIWebView!
    @IBOutlet weak var detailsTextView: UITextView!
    
    var coachingTitle: String! = ""
    var youtubeVideoURL: String! = ""
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = getLogoImageView()
        handleUI()
    }
    
    
    func handleUI()
    {
        // Set Label & TextView text
        titleLabel.text = coachingTitle
        // detailsTextView.text = ""
        
        let webViewURL = "<iframe width=\"\(youtubeVideoContainer.frame.width)\" height=\"\(youtubeVideoContainer.frame.height)\" src=\"\(youtubeVideoURL!)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>"
        youtubeVideoContainer.allowsInlineMediaPlayback = true
        youtubeVideoContainer.loadHTMLString(webViewURL, baseURL: nil)     // Load YT video
    }
}
