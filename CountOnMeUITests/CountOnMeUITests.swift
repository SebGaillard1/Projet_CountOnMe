//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by Sebastien Gaillard on 04/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest

class CountOnMeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddition() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let textView = app.textViews["calculatorTextView"]
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["7"].tap()
        app.buttons["8"].tap()
        app.buttons["9"].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        XCTAssertTrue(textView.value as! String == "1234567890 + 5 = 1234567895")

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAllOperationTypes() throws {
        let app = XCUIApplication()
        app.launch()
        
        let textView = app.textViews["calculatorTextView"]
        
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["2"].tap()
        app.buttons["%"].tap()
        app.buttons["3"].tap()
        app.buttons["x"].tap()
        app.buttons["4"].tap()
        app.buttons["-"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        
        XCTAssertTrue(textView.value as! String == "100 + 2 % 3 x 4 - 6 = 130")
    }
}
