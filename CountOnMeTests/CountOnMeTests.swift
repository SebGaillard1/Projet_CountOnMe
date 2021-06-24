//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Sebastien Gaillard on 04/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    var calculator: CalculatorManager!
    
    override func setUp() {
        super.setUp()
        calculator = CalculatorManager()
    }
        
    func testGiven3Minus_WhenAddingMinusAgain_ThenExpressionShouldBeIncorrect() {
        calculator.currentOperation = ["3", "-", "-"]
        XCTAssertFalse(calculator.expressionIsCorrectAndCanAddOperator)
    }
    
    func testGiven3_WhenAddingMinus_ThenCanAddOperatorShouldBeTrue() {
        calculator.currentOperation = ["3"]
        calculator.currentOperation.append("-")
        XCTAssertFalse(calculator.expressionIsCorrectAndCanAddOperator)
    }
    
    func testGivenANumber_WhenTryingDoDivideByZero_ThenShouldNotBeAValidDivision() {
        calculator.currentOperation = ["50", "%", "0"]
        XCTAssertFalse(calculator.validDivision())
    }
    
    func testGivenANumber_WhenDividingByANumberDifferentOfZero_ThenShouldBeAValidDivision() {
        calculator.currentOperation = ["50", "%", "2"]
        XCTAssertTrue(calculator.validDivision())
    }
    
    func testGivenFirstElementIsMinus_WhenANumberIsChoosen_ThenShouldBeTreatedAsANegativeNumberWhilePerformingTheOperation() {
        calculator.currentOperation = ["-", "5", "x", "-", "6"]
        XCTAssertEqual(calculator.performOperation(), "30")
    }
    
    func testGivenzzerze_Wheneztrrze_Thenezrze() {
        calculator.currentOperation = ["x"]
        XCTAssertFalse(calculator.expressionIsCorrectAndCanAddOperator)
        calculator.currentOperation = ["%"]
        XCTAssertFalse(calculator.expressionIsCorrectAndCanAddOperator)
        calculator.currentOperation = []
        XCTAssertFalse(calculator.expressionIsCorrectAndCanAddOperator)
    }
    
    func testGiven3Minus5_WhenCheckingForResult_ThenShouldBeFalse() {
        calculator.currentOperation = ["3","-","5"]
        XCTAssertFalse(calculator.expressionHaveResult())
    }
    
    func testGiven3_WhenMinus1_ThenResultShouldBe2() {
        calculator.currentOperation = ["3", "-", "1"]
        XCTAssertEqual(calculator.performOperation(), "2")
    }
    
    func testGivenEnoughElements_WhenAddingEqual_ThenShouldReturnTrue() {
        calculator.currentOperation = ["3", "-", "1", "="]
        XCTAssertTrue(calculator.expressionHaveEnoughElement)
        XCTAssertTrue(calculator.expressionHaveResult())
    }
    
        func testGiven15_WhenAdding5_ThenResultShouldBe20() {
            calculator.currentOperation = ["15", "+", "5"]
            XCTAssertEqual(calculator.performOperation(), "20")
        }
    
        func testGiven15_WhenSubstracting5_ThenResultShouldBe10() {
            calculator.currentOperation = ["15", "-", "5"]
            XCTAssertEqual(calculator.performOperation(), "10")
        }
    
        func testGiven15_WhenMultiplyingBy5_ThenResultShouldBe35() {
            calculator.currentOperation = ["15", "x", "5"]
            XCTAssertEqual(calculator.performOperation(), "75")
        }
    
        func testGiven15_WhenDividingBy5_ThenResultShouldBe3() {
            calculator.currentOperation = ["15", "%", "5"]
            XCTAssertEqual(calculator.performOperation(), "3")
        }
    
    
}
