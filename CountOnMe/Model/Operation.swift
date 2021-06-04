//
//  Brain.swift
//  CountOnMe
//
//  Created by Sebastien Gaillard on 04/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Operation {
    
    private var operationsToReduce: [String]
  
    init(operations: [String]) {
        operationsToReduce = operations
        performOperation()
    }
    
    private func performOperation() {
        // Iterate over operations while an operand still here
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
    }
    
    func getResult() -> String {
        return operationsToReduce.first!
    }
}
