//
//  ViewController.swift
//  UB4strd
//
//  Created by Yasin Cengiz on 24.01.2020.
//  Copyright © 2020 MrYC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var score = 0
    var highScore = 0
    
    var timer = Timer()
    var counter = 0
    
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    //
    
    @IBOutlet weak var kenny0: UIImageView!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny10: UIImageView!
    @IBOutlet weak var kenny11: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        // image
        
        kenny0.isUserInteractionEnabled = true
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        kenny10.isUserInteractionEnabled = true
        kenny11.isUserInteractionEnabled = true
        
        let recognizer0 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer10 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer11 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny0.addGestureRecognizer(recognizer0)
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        kenny10.addGestureRecognizer(recognizer10)
        kenny11.addGestureRecognizer(recognizer11)
        
        kennyArray = [kenny0, kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9, kenny10, kenny11]
        
        //timer
        
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
        
    }

    @objc func hideKenny() {
        
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int( arc4random_uniform( UInt32(kennyArray.count - 1) ) )
        kennyArray[random].isHidden = false
        
    }
    
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore {
                
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"

                //save data
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
                
            }
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                // Replay Function
                
                self.score = 0
                self.counter = 10
                self.scoreLabel.text = "Score: \(self.score)"
                self.timeLabel.text = "\(self.score)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    
    
    
}

