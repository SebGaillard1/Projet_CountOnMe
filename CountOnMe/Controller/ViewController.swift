//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    var calculator = CalculatorManager()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculator.elements = elements
        
        for button in numberButtons {
            button.layer.cornerRadius = 5
        }
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.elements = elements
        
        if calculator.expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
        calculator.elements = elements
    }
    
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" \(sender.title(for: .normal)!) ")
            calculator.elements = elements
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
        if calculator.expressionHaveResult {
            textView.text = ""
            calculator.elements = elements
            let alertVC = UIAlertController(title: "Zéro!", message: "Vous ne pouvez pas calculer depuis le resultat, veuillez refaire un calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func acTapped(_ sender: UIButton) {
        textView.text = ""
        calculator.elements = elements
    }
    

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.validDivision() else {
            textView.text = ""
            calculator.elements = elements
            let alertVC = UIAlertController(title: "Erreur!", message: "Vous ne pouvez pas diviser par zéro !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        textView.text.append(" = \(calculator.performOperation())")
    }
}

