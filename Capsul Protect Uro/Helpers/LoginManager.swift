import UIKit
import CryptoSwift
import Alamofire


class LoginManager: NSObject {
    
    static func hashPassword(pass: String, salt: String) -> String?
    {
        let iterations = 5000
        let salted = "\(pass){\(salt)}"
        var digest = Digest.sha512([UInt8](salted.utf8))
        
        for _ in 1..<iterations
        {
            let buf = [UInt8](salted.utf8)
            digest = Digest.sha512(digest + buf)
        }
        
        let cryptedPass = digest.toBase64()
        return cryptedPass
    }
    
    
    static func login(username: String, password: String, completion: @escaping (Bool, AnyObject?) -> ()) {
        
        /* APIRequest.getSalt(userName: username).send { (success, result) in
            if let result = result as? SaltResult, let salt = result.salt, success == true {
                print("result : \(salt)")
                
                if let hashed = LoginManager.hashPassword(pass: password, salt: salt)
                {
                    /* Session -> Singleton for User  */
                    
                    Session.sharedInstance.hashedPassword = hashed
                    Session.sharedInstance.password = password
                    Session.sharedInstance.username = username
                    
                    if let header = WSSEManager(username: username, password: hashed).getWsseHeader()
                    {
                        Session.sharedInstance.wsseHeader = header
                        
                        APIRequest.getMe().send(completion: { (success, result) in
                            if success == true
                            {
                                completion(true, result)
                            }
                            else
                            {
                                completion(false, result)
                            }
                        })
                    }
                    else
                    {
                        completion(false, "Error generating the WSSE header" as AnyObject?)
                    }
                }
                else
                {
                    completion(false, "Error hashing the password" as AnyObject?)
                }
                
            }
            else
            {
                completion(false, result)
            }
        }*/
    }
}
