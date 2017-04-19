import UIKit


class LandingVC: UIViewController
{
    //@IBOutlet var bouncingImage: SpringImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        pushTo(viewController: .welcome)
    }
    
    
    
    // Check if user is signed in or not
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.pushTo(viewController: .welcome)
        
        /*
        if let userInformation = UserDefaults.standard.dictionary(forKey: "userInformation")
        {
            let email = userInformation["email"] as! String
            let password = userInformation["password"] as! String
            
             User.loginUser(withEmail: email, password: password, completion: { [weak weakSelf = self] (status) in
             DispatchQueue.main.async {
             if status == true {
             weakSelf?.pushTo(viewController: .modules)
             } else {
             weakSelf?.pushTo(viewController: .welcome)
             }
             weakSelf = nil
             }
             })
        }
        else
        {
            self.pushTo(viewController: .welcome)
        }*/
    }
    
    
    // Push to relevant ViewController
    func pushTo(viewController: ViewControllerType)
    {
        switch viewController
        {
        case .modules:
            
            print("modules VC instantiate")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Modules") as! ModulesVC
            self.present(vc, animated: false, completion: nil)
        case .welcome:
            
            print("welcome VC instantiate")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Welcome") as! WelcomeVC
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    
    /*  Error while building Spring - consider replacing it
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
