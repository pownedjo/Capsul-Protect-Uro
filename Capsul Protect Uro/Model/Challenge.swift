import UIKit


/** Challenge Model **/
class Challenge: NSObject
{
    let id: Int         // Unique ID
    let title: String
    let succeed: Bool
    
    
    init(id: Int, title: String, succeed: Bool)
    {
        self.id = id
        self.title = title
        self.succeed = succeed
    }
    
    
    // Method in WebService.swift ? Maybe..
    func getDatasFromWebService()
    {
        
    }
}
