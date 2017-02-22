import UIKit

class User: NSObject
{
    
    // PROPERTIES :
    let name: String
    let email: String
    let id: String
    let profilePic: UIImage
    
    
    // INITS :
    init(name: String, email: String, id: String, profilePic: UIImage)
    {
        self.name = name
        self.email = email
        self.id = id
        self.profilePic = profilePic
    }
    
    
    // METHODS :
    static func registerUser(name: String, email: String, password: String) -> Bool
    {
        
        // COMPLETE REGISTRATION PROCESS, IF SUCEED :
        
        let userInfo = ["email" : email, "password" : password]
        UserDefaults.standard.set(userInfo, forKey: "userInformation")
        
        return true
    }
    
    
    static func loginUser(email: String, password: String) -> Bool
    {
        //if error == nil
        let userInfo = ["email": email, "password": password]
        UserDefaults.standard.set(userInfo, forKey: "userInformation")
        
        return true
    }
    
    
    static func logoutUser() -> Bool
    {
        UserDefaults.standard.removeObject(forKey: "userInformation")
        return true
    }
    
    
    static func getUserInfo()
    {
        // Base on User id, retieve any informations necesaary from backend service
    }

}
