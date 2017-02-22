import UIKit


/** Challenge Model **/
class Challenge: NSObject
{
    let title: String
    let succeed: Bool
    
    
    init(title: String, succeed: Bool)
    {
        self.title = title
        self.succeed = succeed
    }
    
    
    func configure()
    {
        
    }
    
    
    // Method in WebService.swift ?
    func getDatasFromWebService()
    {
        
    }
}
