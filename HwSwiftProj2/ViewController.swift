//
//  ViewController.swift
//  HwSwiftProj2
//
//  Created by Alex Wibowo on 14/9/21.
//

import UIKit

class ViewController: UIViewController {

    var countries = [String]()
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    
    var correctAnswer = 0
    var quizIndex = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria",
                      "poland", "russia", "spain", "us", "uk"]
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        button2.layer.borderWidth = 1
        button2.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        button3.layer.borderWidth = 1
        button3.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        playNext()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                                            target: self,
                                                            action: #selector(currentHighScore))
        
 
    }
    
    @objc func currentHighScore(){
        let defaults = UserDefaults.standard
        let currentHighScore = defaults.integer(forKey: "highscore")
        
        let uac = UIAlertController(title: "High score", message: "Current high score is \(currentHighScore)", preferredStyle: .alert)
        uac.addAction(UIAlertAction(title: "OK", style: .default))
        present(uac, animated: true)
    }
    
    func playNext(){
        quizIndex += 1
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
                        
        correctAnswer = Int.random(in: 0...2)
        
        title = countries[correctAnswer].uppercased()
    }
    
    func reset(){
        score = 0
        quizIndex = 0
        playNext()
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        
        let correctAnswer = sender.tag ==  correctAnswer
        var title : String
        if (correctAnswer){
            score += 1
            title = "Correct!"
        } else {
            if (score > 0) {
                score -= 1
            }
            
            title = "Wrong. That is the flag of \(countries[sender.tag].uppercased())"
        }
        
        if quizIndex == 10 {
            let defaults = UserDefaults.standard
            let currentHighScore = defaults.integer(forKey: "highscore")
            let message: String
            var updatedHighScore = currentHighScore
            if score > currentHighScore {
                message = "New high score: \(score)! Previous score: \(currentHighScore)."
                updatedHighScore = score
            } else {
                message = "You have not defeated the current high score \(currentHighScore)."
            }
            
            let uac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            uac.addAction(UIAlertAction(title: "Play again", style: .default, handler: { [weak self] ACTION in
                defaults.setValue(updatedHighScore, forKey: "highscore")
                self?.reset()
            }))
            present(uac, animated: true)
        } else {
            
            let uac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            uac.addAction(UIAlertAction(title: "Next", style: .default, handler: { [weak self] ACTION in
                self?.playNext()
            }))
            present(uac, animated: true)
        }
        
    }
    
}

