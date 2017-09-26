//
//  ViewController.swift
//  Retro Calc
//
//  Created by Michael Jay Abalos on 25/09/2017.
//  Copyright © 2017 Michael Jay Abalos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    
    
    enum Operation: String{
        case Divide =  "/"
        case Multiply =  "*"
        case Subtract =  "-"
        case Add =  "+"
        case Empty =  ""
    }
    
    var btnSounds: AVAudioPlayer!
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        let path: String? = Bundle.main.path(forResource: "btn", ofType: "wav")
        if let btnPath = path {
            let urlPath: URL? = URL.init(fileURLWithPath: btnPath)
            print("urlpath = \(urlPath!)")
            
            do{
                try btnSounds = AVAudioPlayer.init(contentsOf: urlPath!)
                btnSounds.prepareToPlay()
            }catch let err as NSError{
                print("error playing = \(err.debugDescription)")
            }
        }
        
        //initialize display here
        display.text = ""
        
    }

    @IBAction func dividePressed(sender:UIButton){
        processOperation(operation: .Divide)
    }
    @IBAction func multiplyPressed(sender:UIButton){
        processOperation(operation: .Multiply)
    }
    @IBAction func adddPressed(sender:UIButton){
        processOperation(operation: .Add)
    }
    @IBAction func subtractPressed(sender:UIButton){
        processOperation(operation: .Subtract)
    }
    @IBAction func equalsPressed(sender:UIButton){
        processOperation(operation: currentOperation)
    }
    
    func processOperation(operation:Operation) {
        playSound()
        
        print("opertion = \(operation)")
        print("left = \(leftValStr)")
        print("right = \(rightValStr)")
        
        if currentOperation != .Empty{
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == .Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }
                else if currentOperation == .Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                else if currentOperation == .Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                else if currentOperation == .Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                display.text = result
            }
            
            currentOperation = operation
            
        }else{
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    @IBAction func numberPressed(sender:UIButton){

        playSound()
        
        if sender.tag != -100{
            runningNumber += "\(sender.tag)"
            display.text = runningNumber
        }
        
    }
    
    func playSound(){
        if btnSounds.isPlaying {
            btnSounds.stop()
        }
        btnSounds.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

