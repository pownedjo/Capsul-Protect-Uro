import UIKit
import SCLAlertView


class WelcomeVC: UIViewController
{
    @IBOutlet weak var emailTextField: UITextField!     // Username Field
    @IBOutlet weak var passwordTextField: UITextField!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() // Hide Keyboard when tapping in the view
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func loginButtonPressed(_ sender: Any)
    {
        /* TESTING PURPOSES */
        performSegue(withIdentifier: "goToModulesVC", sender: nil)
        
        /*
        /* Check Input Fields */
        if checkInputDatas()
        {
            // Login Request TEST :
            WebService.loginRequest(username: "tetej171@gmail.com", password: "12345678Ab")
        }
        else
        {
            // AlertController - Username Field & Password field NOT OK
            SCLAlertView().showError("Erreur", subTitle: "Vérifier votre email et votre mot de passe.")
        }*/
    }
    
    
    
    // Check validation of email & password
    func checkInputDatas() -> Bool
    {
        if emailTextField.hasText == false || passwordTextField.hasText == false
        {
            return false
        }
        return true
    }
}
