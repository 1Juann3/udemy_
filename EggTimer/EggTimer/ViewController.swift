//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    
    var counter = 30



    @objc func updateCounter() {
        //example functionality
        if counter > 0 {
            print("\(counter) seconds")
            counter -= 1
        }
    }

    @IBAction func hardnessSelector(_ sender: UIButton) {
        let hardness = sender.currentTitle
        
        if hardness == "Soft" {
            counter = eggTimes["Soft"]!
            print(eggTimes["Soft"]!)
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            return
        }
        
        if hardness == "Medium" {
            counter = eggTimes["Medium"]!
            print(eggTimes["Medium"]!)
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            return
        }
        
        else {
            counter = eggTimes["Hard"]!
            print(eggTimes["Hard"]!)
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
    }
    
    
    
    
}
