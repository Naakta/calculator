//
//  ViewController.swift
//  Calculator
//
//  Created by Doug Wagner on 2/19/18.
//  Copyright © 2018 Doug Wagner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var myBrain = CalcBrain()

    @IBOutlet weak var calcOutput: UILabel!
    
    override func viewDidLoad() {
        calcOutput.text = "0"
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeInNumber(sender: UIButton) {
        //print(sender.currentTitle!)
        calcOutput.text = myBrain.addInput(sender.currentTitle!)
    }
    
    @IBAction func takeInOperator(sender: UIButton) {
        //print(sender.currentTitle!)
        calcOutput.text = myBrain.setEquation(sender.currentTitle!)
    }
    
    @IBAction func completeEquation(sender: UIButton) {
        // fullyEquate() will return either an answer or an ""
        // depending on whether or not it has enough data to calculate an answer
        let equalOutput = myBrain.fullyEquate()
        if equalOutput == "" {
            return
        } else {
            calcOutput.text = equalOutput
            myBrain = CalcBrain()
        }
    }
    
    @IBAction func performSingleOperator(sender: UIButton) {
        //print(sender.currentTitle!)
        calcOutput.text = myBrain.singleOperator(sender.currentTitle!)
        myBrain = CalcBrain()
    }
    
    @IBAction func toggleNegative() {
        myBrain.toggleNeg()
        if myBrain.isNegative {
            calcOutput.text = "-" + myBrain.currentString
        } else {
            calcOutput.text = myBrain.currentString
        }
    }
    
    @IBAction func clearAll() {
        calcOutput.text = "0"
        myBrain = CalcBrain()
    }


}

