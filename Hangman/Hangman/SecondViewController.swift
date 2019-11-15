//
//  SecondViewController.swift
//  Hangman
//
//  Created by Kelby Mittan on 11/15/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var legoImage2: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    var game = GameBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageLabel?.text = ""
        wordLabel?.text = game.underScoresTwo()
        print("\(game.wordEntered)")
        userInput?.isEnabled = true
        userInput?.isHidden = false
        legoImage2?.layer.cornerRadius = 15
        userInput?.delegate = self
                
    }
    
    @IBAction func newGameButton(_ sender: UIButton!) {
        
    }
        
    func replaceUnderscores() {
            for (index, char) in game.wordEntered.enumerated() {
                
                if String(char) == game.letterGuess {
                    game.letterArray[index] = game.letterGuess
                }
            }
            wordLabel.text = game.letterArray.joined(separator: " ")
        }
        
        func checkUsersGuess() {
            
            if game.wordEntered.contains(game.letterGuess) {
                messageLabel.text = "Good Guess !!"
                messageLabel.textColor = .blue
                print("correct")
            } else {
                game.guessCount -= 1
                game.incorrectGuess = true
                messageLabel.text = "\(game.guessCount) guesses left"
                messageLabel.textColor = .red
                print("nope")
            }
        }
        
        func gameOver() {
            if game.guessCount == 0 {
                game.gameOverBool = true
                messageLabel.text = "HE DEAD !!"
                messageLabel.font = messageLabel.font.withSize(50)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.wordLabel.text = "The word was \(self.game.wordEntered)"
                }
                
                userInput.isHidden = true
                userInput.isEnabled = false
            } else if !game.letterArray.contains("_") {
                game.gameOverBool = true
                messageLabel.text = "YOU SAVED HIM !!"
                messageLabel.font = messageLabel.font.withSize(50)
                userInput.isHidden = true
                legoImage2.image = UIImage(named: "legoShark10")
                messageLabel.textColor = .blue
                userInput.isEnabled = false
            }
        }
    
        @IBAction func newGameAction(_ sender: UIButton) {
            legoImage2.image = UIImage(named: "legoShark1")
            userInput.isEnabled = true
            userInput.isHidden = false
            messageLabel?.text = "Guess A Letter !!"
            messageLabel?.textColor = .blue
            wordLabel?.text = ""
            game.letterArray.removeAll()
            game.guessCount = 6
            game.enteredGuess.removeAll()
            wordLabel?.text = game.underScoresTwo()
            print(game.wordEntered)
        }
    }

    extension SecondViewController: UITextFieldDelegate {
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            print("textFieldShouldBeginEditing")
            return true
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            print("textFieldDidBeginEditing")
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            print("shouldChangeCharactersIn")
            
            if textField == userInput {
                guard let text = textField.text else {
                    return false
                }
                let currentText = text + string
                
                // source: https://stackoverflow.com/questions/29504304/detect-backspace-event-in-uitextfield/29505548
                
                let  char = string.cString(using: String.Encoding.utf8)!
                let isBackSpace = strcmp(char, "\\b")
                let textAsSet: Set = [currentText]
                
                if currentText.count != 1 || (isBackSpace == -92) || textAsSet.isSubset(of: game.enteredGuess) || !game.alphabet.contains(string) {
                    return false
                }

            }
            
            return true
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            textField.resignFirstResponder()
        
                print(game.wordEntered)
            
            if textField == userInput {
                
                if textField.text?.count == 1 {
                    game.letterGuess = userInput.text?.lowercased() ?? ""
                    
                    checkUsersGuess()
                    replaceUnderscores()
                    
                    game.enteredGuess.insert(game.letterGuess)
                    
                    game.changeImage(legoImage2)
                        
                    gameOver()
                    print(game.gameOverBool)
                    print(game.letterArray)
                }
                
            }
            textField.text = ""
            return true
        }
    }
