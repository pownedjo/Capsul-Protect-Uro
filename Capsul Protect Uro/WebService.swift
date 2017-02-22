import UIKit
import Alamofire

class WebService: NSObject
{
    
    let headers: HTTPHeaders =
    [
        "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
        "Accept": "application/json"
    ]
    
    
    
    static func postCalendarDatas()
    {
        Alamofire.request("\(webServiceURL)").responseJSON { response in
        
            print("RESULT : \(response.result)")
        
        }
    }
    
    
    
    func parseJSON()
    {
        // Parse content from URL with NSData
        // Then fill models
    }
    
    
    
    func getInterInfos()
    {
        let staticInstance: Array<String>
        
        staticInstance = ["helllo", "Element2", "3"]
        
        for i in staticInstance
        {
            print("Element = \(i)")
        }
        
    }
    
    
    static func userRequest()
    {
        // GET SALT
        // salt stored locally 
        
        // GET ABOUTME - verify if conect
        
    }
    
    
    
    static func testPOSTRequest()
    {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            /* POST REQUEST - HANDLE PARAMS */
            
        
            if let error = response.result.error
            {
                // ERROR CODE : 400
                print("ERROR CODE : \(error)")
            }
            else
            {
                let status = "in progress"
            }
            
            
            if let JSON = response.result.value
            {
                print("REPONSE JSON: \(JSON)")
            }
        }
        
    }

}
