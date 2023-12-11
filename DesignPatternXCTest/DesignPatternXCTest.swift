//
//  DesignPatternXCTest.swift
//  DesignPatternXCTest
//
//  Created by 向辉 on 2023/12/10.
//

import XCTest

final class DesignPatternXCTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherStation() {
        let s = WeatherStation()
        let display1 = CurrentConditionDisplay()
        let display2 = StatisticDisplay()
        let display3 = ForecastDisplay()
        s.registerObserver(display1)
        s.registerObserver(display2)
        s.registerObserver(display3)
        
        NSLog("\n")
        s.receiveDataChanged(temp: 10, humidity: 8, pressure: 6.5)
        
        s.removeObserver(display1)
        
        NSLog("\n")
        s.receiveDataChanged(temp: 6, humidity: 5, pressure: 4)
    }
    
    func testCartManager() {
        let cartManager = CartManager()
        
        let navigationBar = NSToolbar()
        let cartVC = NSViewController()
        
        cartManager.add(subscriber: navigationBar)
        cartManager.add(subscriber: cartVC)
        
        let apple = Food(id: 1, name: "Apple", price: Decimal.init(2), calories: 1)
        let tShirt = Clothes(id: 2, name: "T-Shirt", price: Decimal.init(6), size: "XL")
        
        cartManager.add(product: apple)
        cartManager.add(product: tShirt)
        
        cartManager.remove(product: apple)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
