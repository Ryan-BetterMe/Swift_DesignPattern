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

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
