//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Baynham Makusha on 7/20/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var TimerLbl: UILabel!
    
    var currentCard: Card!
    var previousCard: Card!
    var timer: Timer!
    var currentAnswersCorrect = 0
    var countGame = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
    }
    
    @IBAction func yesPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer(true)
        } else {
            titleLbl.text = "Does this card match the previous?"
            startGame()
        }
        
        showNextCard()
    }
    
    @IBAction func noPressed(_ sender: AnyObject) {
        checkAnswer(false)
        showNextCard()
    }
    
    func startGame() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameVC.startGameCounter), userInfo: nil, repeats: true)
    }
    
    func startGameCounter() {
        countGame = countGame - 1
        if countGame == 60 {
            TimerLbl.text = "1:00"
        } else if countGame == 0 {
            TimerLbl.text = "0:00"
            timer.invalidate()
            gameFinished()
        } else if countGame > 10 {
            TimerLbl.text = "0:\(countGame)"
        } else {
            TimerLbl.text = "0:0\(countGame)"
        }
    }
    
    func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
            previousCard = cardToRemove
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation?, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.isHidden {
                noBtn.isHidden = false
                yesBtn.setTitle("YES", for: UIControlState())
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim:POPAnimation?, finished: Bool) -> Void in
                
            })
            
        }
        
        
    }
    
    func createCardFromNib() -> Card? {
        return Bundle.main.loadNibNamed("Card", owner: self, options: nil)?[0] as? Card
    }
    
    func restartGame() {
        yesBtn.isHidden = true
        yesBtn.setTitle("Start", for: UIControlState())
        currentAnswersCorrect = 0
        countGame = 60
        TimerLbl.text = "1:00"
    }
    
    func checkAnswer(_ isCorrect: Bool) {
        if let previous = previousCard, let current = currentCard {
            if current.shapeImage.image == previous.shapeImage.image {
                current.statusImage.isHidden = false
                current.statusImage.image = UIImage(named: (isCorrect) ? "correct" : "error")
                currentAnswersCorrect = (isCorrect) ? currentAnswersCorrect + 1 : currentAnswersCorrect
                //print("The current is like the previous")
            } else {
                current.statusImage.isHidden = false
                current.statusImage.image = UIImage(named: (!isCorrect) ? "correct" : "error")
                //print("The current is not like the previous")
            }
        }
    }
    
    func gameFinished() {
        let alert = UIAlertController(title: "Game Finished!", message: "You got \(currentAnswersCorrect) answer(s) correct\nDo you want to play again?", preferredStyle: .alert)
        let btAccept = UIAlertAction(title: "Yes", style: .default) { (alertAction: UIAlertAction) in
            self.restartGame()
        }
        let btCancel = UIAlertAction(title: "No", style: .cancel) { (alertAction: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(btAccept)
        alert.addAction(btCancel)
        present(alert, animated: true, completion: nil)
    }
    
    
}
