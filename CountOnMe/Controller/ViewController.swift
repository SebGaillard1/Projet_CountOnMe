//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved
//
import UIKit

class ViewController: UIViewController {
    //MARK: - IBOultets
    @IBOutlet var textView: UITextView!
    
    //MARK: - Variable
    private var formatedTextView: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    private var calculator = CalculatorManager()
    
    //MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculator.results.append("0")
        calculator.currentOperation = formatedTextView
    }
    
    //MARK: - IBActions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        // Si il y a déjà un calcul, on fait de la place pour les nouveaux calculs
        if calculator.expressionHaveResult() {
            textView.text = ""
        } else if textView.text == "0" {
            textView.text = ""
        }
        textView.text.append(numberText)
        scrollToBottom()
        calculator.currentOperation = formatedTextView
    }
    
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        if calculator.expressionIsCorrectAndCanAddOperator {
            textView.text.append(" \(sender.title(for: .normal)!) ")
            scrollToBottom()
            calculator.currentOperation = formatedTextView
        } else {
            if sender.title(for: .normal) != "-" {
            let alertVC = UIAlertController(title: "Ajout impossible", message: "Vous ne pouvez pas ajouter cet operateur !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            } else {
                if calculator.currentOperation.last != "-" {
                textView.text.append(" \(sender.title(for: .normal)!) ")
                scrollToBottom()
                calculator.currentOperation = formatedTextView
                } else {
                    let alertVC = UIAlertController(title: "Saisie invalide !", message: "Vous avez déjà saisi un moins !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
        
        // Dans le cas ou l'utilisateur veux effectuer un calcul depuis le resultat précedent
        if calculator.expressionHaveResult() {
            textView.text = "\(calculator.results.last!)"
            textView.text.append(" \(sender.title(for: .normal)!) ")
            textView.text = textView.text.replacingOccurrences(of: ".0 ", with: " ")
            calculator.currentOperation = formatedTextView
        }
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        textView.text = "0"
        calculator.currentOperation.removeAll()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrectAndCanAddOperator else {
            let alertVC = UIAlertController(title: "Incorrect!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Incomplet!", message: "Le calcul est incomplet ! Veuillez le compléter ou recommencer un nouveau calcul.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.validDivision() else {
            textView.text = "0"
            calculator.currentOperation.removeAll()
            let alertVC = UIAlertController(title: "Erreur!", message: "Vous ne pouvez pas diviser par zéro !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard !calculator.expressionHaveResult() else {
            textView.text = "0"
            calculator.currentOperation.removeAll()
            let alertVC = UIAlertController(title: "Déjà calculé!", message: "Vous avez déjà calculé !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        textView.text.append(" = \(calculator.performOperation())")
        textView.text = textView.text.replacingOccurrences(of: ".0", with: "", options: .anchored, range: Range(NSMakeRange(textView.text.count - 2, 2), in: textView.text))
        scrollToBottom()
        calculator.currentOperation = formatedTextView
    }
    
    private func scrollToBottom() {
        let range = NSRange(location: textView.text.count - 1, length: 0)
        textView.scrollRangeToVisible(range)
    }
}

