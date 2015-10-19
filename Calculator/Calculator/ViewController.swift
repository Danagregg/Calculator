//
//  ViewController.swift
//  Calculator
//
//  Created by Dana Gregg on 10/18/15.
//  Copyright © 2015 Dana Gregg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
  
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "✖️": performOperation { $0 * $1 }
            case "➗": performOperation { $1 / $0 }
            case "➕": performOperation { $0 + $1 }
            case "➖": performOperation { $1 - $0 }
            case "✔️": performOneOperation { sqrt($0) }
            case "sin": performOneOperation { sin($0) }
            case "cos": performOneOperation { cos($0) }
            default: break
        }
    }
    
    @IBAction func clear() {
        display.text! = "0"
        operandStack = Array<Double>()
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),  operandStack.removeLast())
            enter()
        }
    }
    
    func performOneOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func addDecimal() {
        if !(display.text! as NSString).containsString(".") {
            if userIsInTheMiddleOfTypingANumber{
                display.text = display.text! + "."
            }
            else {
                display.text! = "0."
                userIsInTheMiddleOfTypingANumber = true
            }
        }
    }

    var operandStack = Array<Double>()
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if (display.text!.hasSuffix(".")){
            display.text = display.text! + "0"
        }
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}

