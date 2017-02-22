import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Colorof background Nav Bar :
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        // Color of items in Nav Bar :
        UINavigationBar.appearance().tintColor = globalAppColor
        
        return true
    }

}

