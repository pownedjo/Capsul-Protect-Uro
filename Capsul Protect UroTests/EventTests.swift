import XCTest
@testable import Capsul_Protect_Uro


class EventTests: XCTestCase {
    
    var eventsManager: EventModelController!
    let aDate = "14/05/2017"
    var drinkEvent: EventBoisson!
    var drinkEvent2: EventBoisson!
    
    
    
    override func setUp()
    {
        super.setUp()

        eventsManager = { return EventModelController.eventsSharedInstance }()
        
        drinkEvent = EventBoisson(date: dateFormatter.date(from: aDate)!, quantite: 100, typeBoisson: 2)
        
        drinkEvent2 = EventBoisson(date: dateFormatter.date(from: aDate)!, quantite: 150, typeBoisson: 3)

    }
    
    
    
    override func tearDown()
    {
        super.tearDown()
        
        eventsManager = nil
        drinkEvent = nil
        drinkEvent2 = nil
    }
    
    
    
    func testPerformanceExample()
    {
        self.measure
        {
            
        }
    }
    
    
    // Test Quantity for 2 EventBoisson 
    func testDrinkEventQuantity()
    {
        XCTAssertTrue(drinkEvent2.quantite > drinkEvent.quantite)
    }
    
}
