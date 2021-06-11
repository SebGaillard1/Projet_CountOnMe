//
//  Brain.swift
//  CountOnMe
//
//  Created by Sebastien Gaillard on 04/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CalculatorManager {
    
    var elements: [String] = []
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "X" && elements.last != "%"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "X" && elements.last != "%" 
    }
    
    var expressionHaveResult: Bool {
        for element in elements {
            if element.contains("=") {
                elements.removeAll()
                return true
            }
        }
        return false
    }
    
    func performOperation() -> String {
        // Iterate over operations while an operand still here
        var operationsToReduce = elements
        
        if expressionIsCorrect && expressionHaveEnoughElement {
            while operationsToReduce.count > 1 {
                let left = Int(operationsToReduce[0])!
                let operand = operationsToReduce[1]
                let right = Int(operationsToReduce[2])!
                
                let result: Int
                switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "X": result = left * right
                case "%": result = left / right
                default: fatalError("Unknown operator !")
                }
                
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
                
            }
            return operationsToReduce.first ?? "Error"
        }
        return "Error"
    }
}
