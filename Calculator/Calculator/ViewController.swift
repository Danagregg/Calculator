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
    
    var brain = CalculatorBrain()
  
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
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        
    }
    
    @IBAction func clear() {
        display.text! = "0"
        brain.clear()
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
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if (display.text!.hasSuffix(".")){
            display.text = display.text! + "0"
        }
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        } else {
            displayValue = 0
        }
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

