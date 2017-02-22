import UIKit


class LandingVC: UIViewController
{
    //@IBOutlet var bouncingImage: SpringImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    
    // Push to relevant ViewController
    func pushTo(viewController: ViewControllerType)
    {
        switch viewController
        {
        case .conversations:
            print("conversations")
            /*
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Navigation") as! NavVC
            self.present(vc, animated: false, completion: nil)*/
        case .welcome:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Welcome") as! WelcomeVC
            self.present(vc, animated: false, completion: nil)
        default:
            print("default switch statement")
        }
    }
    
    
    // Check if user is signed in or not
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if let userInformation = UserDefaults.standard.dictionary(forKey: "userInformation")
        {
            let email = userInformation["email"] as! String
            let password = userInformation["password"] as! String
            /*
            User.loginUser(withEmail: email, password: password, completion: { [weak weakSelf = self] (status) in
                DispatchQueue.main.async {
                    if status == true {
                        weakSelf?.pushTo(viewController: .conversations)
                    } else {
                        weakSelf?.pushTo(viewController: .welcome)
                    }
                    weakSelf = nil
                }
            })*/
        }
        else
        {
            self.pushTo(viewController: .welcome)
        }
    }
    
    
    /*
    func animateLoadingImage()
    {
        bouncingImage.animation = "pop"
        bouncingImage.curve = "linear"
        bouncingImage.force = 1.5
        bouncingImage.duration = 2.0
        bouncingImage.repeatCount = Float(30)    // Repeat animation a number of times
        bouncingImage.animate()
    }*/
    

}
