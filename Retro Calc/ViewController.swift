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

    var btnSounds: AVAudioPlayer!
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
        
    }

    
    @IBAction func numberPressed(sender:UIButton){
        playSound()
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

