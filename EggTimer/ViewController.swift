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
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 5*60, "Medium": 7*60, "Hard": 12*60]
    var timer: Timer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer?.invalidate()
        
        let hardness = sender.currentTitle!
        if let time = eggTimes[hardness] {
            infoLabel.text = hardness
            progressBar.progress = 0.0
            countdownTimer(time: time)
        }
    }
    
    func countdownTimer(time: Int) {
        var countdownTime = time
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if countdownTime > 0 {
                countdownTime -= 1
                self.progressBar.progress = Float(time - countdownTime) / Float(time)
            } else {
                timer.invalidate()
                self.infoLabel.text = "Egg is ready!"
                self.playSound()
            }
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

