//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1Message: UILabel!
    @IBOutlet weak var inputWordTextField: UITextField!
    @IBOutlet weak var enteredWord: UILabel!
    @IBOutlet weak var inputGuessTextField: UITextField!
    @IBOutlet weak var legoImage: UIImageView!
    @IBOutlet weak var player2Label: UILabel!
    
    var game = GameBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player2Label?.text = ""
        enteredWord?.text = ""
        inputGuessTextField?.isEnabled = false
        inputGuessTextField?.isHidden = true
        legoImage?.layer.cornerRadius = 15
        inputWordTextField?.delegate = self
        inputGuessTextField?.delegate = self
        
    }
    
    func replaceUnderscores() {
        for (index, char) in game.wordEntered.enumerated() {
            
            if String(char) == game.letterGuess {
                game.letterArray[index] = game.letterGuess
            }
        }
        enteredWord.text = game.letterArray.joined(separator: " ")
    }
    
    func checkUsersGuess() {
        
        if game.wordEntered.contains(game.letterGuess) {
            player2Label.text = "Good Guess !!"
            player2Label.textColor = .blue
            print("correct")
        } else {
            game.guessCount -= 1
            game.incorrectGuess = true
            player2Label.text = "\(game.guessCount) guesses left"
            player2Label.textColor = .red
            print("nope")
        }
    }
    
    func gameOver() {
        if game.guessCount == 0 {
            game.gameOverBool = true
            player2Label.text = "HE DEAD !!"
            inputGuessTextField.isHidden = true
            inputGuessTextField.isEnabled = false
        } else if !game.letterArray.contains("_") {
            game.gameOverBool = true
            player2Label.text = "YOU SAVED HIM !!"
            inputGuessTextField.isHidden = true
            legoImage.image = UIImage(named: "legoShark10")
            player2Label.textColor = .blue
            inputGuessTextField.isEnabled = false
        }
    }
    
    @IBAction func newGameAction(_ sender: UIButton) {
        inputWordTextField.isEnabled = true
        inputWordTextField.isHidden = false
        player1Message.isHidden = false
        player2Label?.text = ""
        enteredWord?.text = ""
        game.letterArray.removeAll()
        game.guessCount = 6
        game.enteredGuess.removeAll()
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("shouldChangeCharactersIn")
        
        if textField == inputGuessTextField {
            guard let text = textField.text else {
                return false
            }
            let currentText = text + string
            
            // source: https://stackoverflow.com/questions/29504304/detect-backspace-event-in-uitextfield/29505548
            
            let  char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            let textAsSet: Set = [currentText]
            
            if currentText.count != 1 || (isBackSpace == -92) || textAsSet.isSubset(of: game.enteredGuess) {
                return false
            }

        } else {
            guard let text = textField.text else {
                return false
            }
            let currentText = text + string
            if currentText.count > 8 || !game.alphabet.contains(string) {
                return false
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if textField == inputWordTextField {
            legoImage.image = UIImage(named: "legoShark1")
            game.wordEntered = inputWordTextField.text?.lowercased() ?? ""
            enteredWord.text = game.underScores()
            inputWordTextField.isEnabled = false
            inputWordTextField.isHidden = true
            inputGuessTextField.isEnabled = true
            inputGuessTextField.isHidden = false
            player1Message.isHidden = true
            player2Label?.text = "Guess A Letter !!"
            player2Label?.textColor = .blue
            print(game.wordEntered)
        } else if textField == inputGuessTextField {
            game.letterGuess = inputGuessTextField.text?.lowercased() ?? ""
            checkUsersGuess()
            replaceUnderscores()
            game.enteredGuess.insert(game.letterGuess)
            if game.incorrectGuess {
                game.changeImage(legoImage)
            }
            gameOver()
            print(game.gameOverBool)
            print(game.letterArray)
        }
        textField.text = ""
        return true
    }
}
