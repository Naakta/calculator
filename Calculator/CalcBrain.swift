//
//  CalcBrain.swift
//  Calculator
//
//  Created by Doug Wagner on 2/19/18.
//  Copyright © 2018 Doug Wagner. All rights reserved.
//

import Foundation

class CalcBrain {
    var currentString: String = ""
    var operand1: String = ""
    var theOperator: String = ""
    var hasPeriod = false
    var hasOperand1 = false
    var hasOperator = false
    var isNegative = false
    
    func addInput(_ str: String) -> String {
        var strCopy = checkPeriod(str) // if there is already a . then the incoming str becomes ""
        
        if str == "." {
            self.hasPeriod = true
        } else if str == "0" && currentString == "0" { // does not allow more than one 0 before a .
            strCopy = ""
        }
        
        // flavor text for starting a decimal number
        // later to be checked for if user tries to enter operator with only "0." entered
        if currentString == "" && str == "." {
            currentString = "0."
            return currentString
        }
        
        currentString += strCopy
        return currentString
    }
    
    func setEquation(_ str: String) -> String {
        if self.hasOperator == true && currentString == "" { // allows operator to be changed if wrong one is hit first
            theOperator = str
            return "0"
        } else if currentString == "" { // this is not a number to operator cannot be set yet
            return "0"
        } else if currentString == "0." { // this is not a number so operator cannot be set yet
            return "0."
        } else { // set first operand, and the operator. currentString is now building the second operand
            theOperator = str
            self.hasOperator = true
            
            self.operand1 = currentString
            self.hasOperand1 = true
            currentString = ""
            isNegative = false
            
            return "0"
        }
    }
    
    func fullyEquate() -> String {
        // there is either no operand1 or operand2, or both are empty
        // doesn't allow equation ro run because there is not enough data
        if currentString == "" || hasOperand1 == false {
            return ""
        }
        
        var theAnswer = 0.0
        
        if theOperator == "x" {
            theAnswer = Double(operand1)! * Double(currentString)!
            return checkIntOrDouble(theAnswer)
        } else if theOperator == "/" {
            theAnswer = Double(operand1)! / Double(currentString)!
            return checkIntOrDouble(theAnswer)
        } else if theOperator == "+" {
            theAnswer = Double(operand1)! + Double(currentString)!
            return checkIntOrDouble(theAnswer)
        } else if theOperator == "-" {
            theAnswer = Double(operand1)! - Double(currentString)!
            return checkIntOrDouble(theAnswer)
        }
        
        return "Unforseen Operator" // shouldn't ever hit this
    }
    
    func singleOperator(_ op: String) -> String {
        if currentString == "" {
            return "0"
        }
        
        if op == "%" {
            return String(Double(currentString)! / 100)
        } else if op == "sq" {
            let thisNum = pow(Double(currentString)!, 2.0)
            return checkIntOrDouble(thisNum)
        } else if op == "sqrt" {
            let thisNum = sqrt(Double(currentString)!)
            return checkIntOrDouble(thisNum)
        }
        
        return "Unforseen Operator" // shouldn't ever hit this
    }
    
    func toggleNeg() {
        isNegative = !isNegative
    }
    
    func checkPeriod(_ str: String) -> String {
        // changes input to "" if there is already a period and user tries to enter another
        // otherwise, the incoming string is not changed
        if self.hasPeriod == true && str == "." {
            return ""
        } else {
            return str
        }
    }
    
    func checkIntOrDouble(_ ans: Double) -> String {
        // truncates the answer and adds .0 to the end of it, then compares to the original
        // this checks if the number is an integer or a decimal number
        // returns an int if it's an int or a double if it's a decimal number
        if String(Int(ans)) + ".0" == String(ans) {
            return String(Int(ans))
        } else {
            return String(ans)
        }
    }
}
