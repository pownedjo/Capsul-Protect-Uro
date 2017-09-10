import UIKit
import KDCircularProgress

class WelcomeUrologieVC: UIViewController
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var circularChart1: KDCircularProgress!
    @IBOutlet weak var circularChart2: KDCircularProgress!
    @IBOutlet weak var circularChart3: KDCircularProgress!
    
    @IBOutlet weak var labelChart1: UILabel!
    @IBOutlet weak var labelChart2: UILabel!
    @IBOutlet weak var labelChart3: UILabel!
    
    
    /* TESTING PURPOSE */
    lazy var eventsManager = { return EventModelController.eventsSharedInstance }() // Singleton Instance

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = getLogoImageView()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)

        handleUIForChartViews(circularChart: circularChart1, labelValue: 180)   // 50%
        handleUIForChartViews(circularChart: circularChart2, labelValue: 288)   // 80%
        handleUIForChartViews(circularChart: circularChart3, labelValue: 108)   // 30%
        
        parseArrayTest()
    }
    
    
    // Adapat Circular Chart Views UI
    func handleUIForChartViews(circularChart: KDCircularProgress, labelValue: Double)
    {
        circularChart.startAngle = -90
        circularChart.progressThickness = 0.2
        circularChart.trackThickness = 0.6
        circularChart.clockwise = true
        circularChart.roundedCorners = true
        circularChart.glowMode = .forward
        circularChart.glowAmount = 0.7
        circularChart.set(colors: UIColor.red ,UIColor.orange, UIColor.green)
        
        // Start Progress Animation on Chart View - Metric : %
        handleProgessOnChartViews(chart: circularChart, metric: labelValue)
    }
    
    
    
    // Set final angle and start progression for Circular Chart Views
    func handleProgessOnChartViews(chart: KDCircularProgress, metric: Double)
    {
        chart.animate(fromAngle: 0, toAngle: metric, duration: 1) { completed in
            if completed
            {
                print("Animation completed")
            }
            else
            {
                print("animation stopped, was interrupted")
            }
        }
    }
    
    
    @IBAction func backButtonItemPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)    // Go back to ModulesVC
    }
    

    @IBAction func capsulButtonPressed(_ sender: Any)
    {
        if #available(iOS 10.0, *)
        {
            UIApplication.shared.open(capsulProtectURL!)
        }
        else
        {
            print("Failed to open URL - check iOS version")
        }
    }
    
    
    
    // Allow User to select his profil picture
    @IBAction func editProfileImagePressed(_ sender: Any)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}



/* Handle UIImage Picker Delegate methods */
extension WelcomeUrologieVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
        
        // Store Image Picked on the Device //
        
        // Create unique string for image Path
        /*let imageName = "" // your image name here
        let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(imageName).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
 
        // Storing
        let newImage: UIImage = // create your UIImage here
        try? UIImagePNGRepresentation(newImage)?.write(to: imageUrl) */
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
}
