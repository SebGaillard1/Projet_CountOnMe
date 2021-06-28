//
//  Brain.swift
//  CountOnMe
//
//  Created by Sebastien Gaillard on 04/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CalculatorManager {
    
    var results = [String]()
    var currentOperation = [String]()
    
    // Error check computed variable
    var expressionIsCorrectAndCanAddOperator: Bool {
        return currentOperation.last != "+" && currentOperation.last != "-" && currentOperation.last != "x" && currentOperation.last != "%" && !currentOperation.isEmpty
    }
    
    var expressionHaveEnoughElement: Bool {
        return currentOperation.count >= 3
    }
    
    // Check if an operation has been done
    func expressionHaveResult() -> Bool {
        for element in currentOperation {
            if element.contains("=") {
                currentOperation.removeAll()
                return true
            }
        }
        return false
    }
    
    // Check if user is trying to divide by zero
    func validDivision() -> Bool {
        if let indexOfDivision = currentOperation.firstIndex(of: "%") {
            if Int(currentOperation[indexOfDivision + 1]) == 0 { // En Int car si l'utilisateur divise par 0 ou 00 ou 000 etc.. Problème potentiel en String
                return false
            }
        }
        return true
    }
    
    // Detect if user want to use negative number
    private func treatNegativeNumbers() {
        if currentOperation[0] == "-" {
            currentOperation[0] += currentOperation[1]
            currentOperation.remove(at: 1)
        }
        
        if currentOperation[2] == "-" {
            currentOperation[2] += currentOperation[3]
            currentOperation.remove(at: 3)
        }
    }
    
    // Perform the operation. Return the result
    func performOperation() -> String {
        treatNegativeNumbers()
        
        var operationsToReduce = currentOperation
        
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            
            var result: Double
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "%": result = left / right
            default: fatalError("Unknown operator !")
            }
            
            result = Double(round(100*result)/100)

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
            
        }
        results.append(contentsOf: operationsToReduce)
        return operationsToReduce.first ?? "Error"
    }
}
