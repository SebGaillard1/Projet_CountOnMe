//
//  Brain.swift
//  CountOnMe
//
//  Created by Sebastien Gaillard on 04/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CalculatorManager {
    
    var allOperations = [String]()
    var currentOperation = [String]()
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return currentOperation.last != "+" && currentOperation.last != "-" && currentOperation.last != "X" && currentOperation.last != "%"
    }
    
    var expressionHaveEnoughElement: Bool {
        return currentOperation.count >= 3
    }
    
    var canAddOperator: Bool {
        return currentOperation.last != "+" && currentOperation.last != "-" && currentOperation.last != "X" && currentOperation.last != "%"
    }
    
    var expressionHaveResult: Bool {
        for element in currentOperation {
            if element.contains("=") {
                currentOperation.removeAll()
                return true
            }
        }
        return false
    }
    
    private var indexOfDivision: Int? {
        return currentOperation.firstIndex(of: "%")
    }
    
    func validDivision() -> Bool {
        if indexOfDivision != nil {
            if Int(currentOperation[indexOfDivision! + 1]) == 0 { // En Int car si l'utilisateur divise par 0 ou 00 ou 000 etc.. Problème potentiel en String
                return false
            }
        }
        return true
    }
    
    func treatNegativeNumbers() {
        if currentOperation[0] == "-" {
            currentOperation[0] += currentOperation[1]
            currentOperation.remove(at: 1)
        }
        
        if currentOperation[2] == "-" {
            currentOperation[2] += currentOperation[3]
            currentOperation.remove(at: 3)
        }
    }
    
    func performOperation() -> String {
        // Iterate over operations while an operand still here
        treatNegativeNumbers()
        
        var operationsToReduce = currentOperation
        
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
        allOperations.append(contentsOf: operationsToReduce)
        print(allOperations)
        return operationsToReduce.first ?? "Error"
    }
}
