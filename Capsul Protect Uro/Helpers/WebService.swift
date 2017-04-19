import UIKit
import Alamofire
import SwiftyJSON

class WebService: NSObject
{
    let headers: HTTPHeaders =
    [
        "X-WSSE": "UsernameToken QWxhZGRpbjpvcGVuIHNlc2FtZQ==", // Send Token in Header
    ]
    
    
    static func userRequest()
    {
        // GET SALT
        // STORE SALT LOCALLY //
        // GET ABOUTME - verify if conect 
    }
    
    /** Ces requêtes doivent être authentifiées avec l'entête HTTP "X-WSSE" **/
    
    static func loginRequest(username: String, password: String)
    {
        Alamofire.request(webServiceURL + "users/salt", method: .post, parameters: ["email": username],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
                
            case .success(let data):

                let json = JSON(data)
                let salt_result = json["salt"].stringValue
                print("SALT = " + salt_result)
                
                let hashed_password = LoginManager.hashPassword(pass: password, salt: salt_result)
                print("Hashed Pass: \(hashed_password)")
                
                
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
