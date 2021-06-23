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
    @IBOutlet var circleButtons: [UIButton]!
    @IBOutlet var rectangleButtons: [UIButton]!
    
    var formatedTextView: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    var calculator = CalculatorManager()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculator.results.append("2")
        calculator.currentOperation = formatedTextView
        
        for button in circleButtons {
            button.layer.cornerRadius = button.bounds.size.width / 2
        }
        
        for button in rectangleButtons {
            button.layer.cornerRadius = button.bounds.size.height / 2
            //button.layer.masksToBounds = true
        }
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.currentOperation = formatedTextView
        
        if calculator.expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
        calculator.currentOperation = formatedTextView
    }
    
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        if calculator.expressionIsCorrectAndCanAddOperator {
            textView.text.append(" \(sender.title(for: .normal)!) ")
            calculator.currentOperation = formatedTextView
        } else {
            if sender.title(for: .normal) != "-" {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            } else {
                if calculator.currentOperation.last != "-" {
                textView.text.append(" \(sender.title(for: .normal)!) ")
                calculator.currentOperation = formatedTextView
                } else {
                    let alertVC = UIAlertController(title: "Saisie invalide !", message: "Vous avez déjà saisi un moins !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
        
        if calculator.expressionHaveResult {
            textView.text = "\(calculator.results.last!)"
            textView.text.append(" \(sender.title(for: .normal)!) ")
            calculator.currentOperation = formatedTextView
        }
    }
    
    @IBAction func acTapped(_ sender: UIButton) {
        textView.text = ""
        calculator.currentOperation = formatedTextView
    }
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrectAndCanAddOperator else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Incomplet!", message: "Le calcul est incomplet ! Veuillez le compléter ou recommencer un nouveau calcul.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.validDivision() else {
            textView.text = ""
            calculator.currentOperation = formatedTextView
            let alertVC = UIAlertController(title: "Erreur!", message: "Vous ne pouvez pas diviser par zéro !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        textView.text.append(" = \(calculator.performOperation())")
    }
}

