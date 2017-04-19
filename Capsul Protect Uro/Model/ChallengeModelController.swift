import UIKit

class ChallengeModelController: NSObject
{
    static let challengesSharedInstance = ChallengeModelController()    // Singleton instance
    var challengesForUser: [Challenge]?

    
    override init()
    {
        print("Init Shared Instance Array")
        challengesForUser = [Challenge]()   // Init ARRAY
    }
    
    
    
    func addChallenge(achallenge: Challenge) -> Bool
    {
        challengesForUser?.append(achallenge)
        return true
    }
    
    
    
    func getChallenge(withID: Int) -> Bool
    {
        for challenge in challengesForUser!
        {
            if withID == challenge.id
            {
                return true
            }
        }
        return false
    }
    
}
