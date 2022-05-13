//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = [
        "Soft": 3,
        "Medium": 4,
        "Hard": 7
    ]
    
    var alarmPlayer = AVAudioPlayer.self()
    var totalSeconds = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.setProgress(0, animated: false)
        // progressBar rounded edges
        progressBar.layer.cornerRadius = 11
        progressBar.clipsToBounds = true
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.setProgress(0, animated: false)
        
        let hardness = sender.currentTitle!
        totalSeconds = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if(totalSeconds >= secondsPassed) {
//            progressBar.progress = Float(secondsPassed) / Float(totalSeconds)
            progressBar.setProgress(Float(secondsPassed) / Float(totalSeconds), animated: true)
            textLabel.text! = String(secondsPassed) + " seconds"
            secondsPassed += 1
        } else {
            timer.invalidate()
            secondsPassed = 0
            textLabel.text! = "Done!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            alarmPlayer = try! AVAudioPlayer(contentsOf: url!)
            alarmPlayer.play()
        }
    }

}
