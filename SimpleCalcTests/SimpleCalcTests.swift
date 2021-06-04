//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

    func testGiven15_WhenAdding5_ThenResultShouldBe20() {
        let newOperation = AnOperation(operations: ["15", "+", "5"])
        XCTAssertEqual(newOperation.getResult(), "20")
    }
    
    func testGiven15_WhenSubstracting5_ThenResultShouldBe10() {
        let newOperation = AnOperation(operations: ["15", "-", "5"])
        XCTAssertEqual(newOperation.getResult(), "10")
    }
    
    func testGiven15_WhenMultiplyingBy5_ThenResultShouldBe35() {
        let newOperation = AnOperation(operations: ["15", "X", "5"])
        XCTAssertEqual(newOperation.getResult(), "75")
    }
    
    func testGiven15_WhenDividingBy5_ThenResultShouldBe3() {
        let newOperation = AnOperation(operations: ["15", "%", "5"])
        XCTAssertEqual(newOperation.getResult(), "3")
    }
}
