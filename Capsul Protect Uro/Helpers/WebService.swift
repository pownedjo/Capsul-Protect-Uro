import UIKit
import Alamofire
import CryptoSwift
import SwiftyJSON

/*
Chaque requête doit être authentifiée avec l'entête HTTP "X-WSSE"
 
    PROCESS :
        GET SALT
        STORE SALT LOCALLY
        GET ABOUTME - verify if conect
*/
class WebService: NSObject
{
    let headers: HTTPHeaders =
    [
        "X-WSSE": "UsernameToken QWxhZGRpbjpvcGVuIHNlc2FtZQ==", // User Token - testing purposes
    ]
    
    
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
    
    
    
    static func loginRequest(username: String, password: String)
    {
        Alamofire.request(webServiceURL + "users/salt", method: .post, parameters: ["email": username],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
                
            case .success(let data):

                let json = JSON(data)
                let salt_result = json["salt"].stringValue
                let hashed_password = hashPassword(pass: password, salt: salt_result)
                print("Hashed Pass: \(String(describing: hashed_password))")
                
                if let header = WSSEManager(username: username, password: hashed_password!).getWsseHeader()
                {
                    print("Header : \(header)")
                    
                    // generate header (user token)
                    // store localy : username, hashedpassword, salt
                    
                    // regenrate token for every request (token expires after 1min on server side)
                    
                    // Alamofire.getMe()
                }
                break
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
