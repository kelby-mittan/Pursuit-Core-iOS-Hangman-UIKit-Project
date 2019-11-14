//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputWordTextField: UITextField!
    @IBOutlet weak var enteredWord: UILabel!
    @IBOutlet weak var inputGuessTextField: UITextField!
    @IBOutlet weak var legoImage: UIImageView!
    @IBOutlet weak var player2Label: UILabel!
    
    private var enteredGuess = Set<String>()
    private var wordEntered = ""
    private var letterArray = [String]()
    private var letterGuess = ""
    private var guessCount = 6
    private var enterWord = ""
    private var incorrectGuess = Bool()
    private var gameOverBool = false
    
    var inputLetterArray = [String]()
    var wordAsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputWordTextField?.delegate = self
        inputGuessTextField?.delegate = self
        player2Label?.text = ""
        enteredWord?.text = ""
        
    }
    
    func underScores() -> String {
        for _ in wordEntered {
            letterArray.append("_")
        }
        enterWord = letterArray.joined(separator: " ")
        return enterWord
    }
    
    func replaceUnderscores() {
        for (index, char) in wordEntered.enumerated() {
            
            if String(char) == letterGuess {
                letterArray[index] = letterGuess
            }
        }
        enteredWord.text = letterArray.joined(separator: " ")
    }
    
    func checkUsersGuess() {
        
        if wordEntered.contains(letterGuess) {
            print("correct")
        } else {
            guessCount -= 1
            incorrectGuess = true
            player2Label.text = "\(guessCount) guesses left"
            player2Label.textColor = .red
            print("nope")
        }
    }
    
    func gameOver() {
        if guessCount == 0 {
            gameOverBool = true
            player2Label.text = "HE DEAD !!"
            inputGuessTextField.isEnabled = false
        } else if !letterArray.contains("_") {
            gameOverBool = true
            player2Label.text = "You Saved Him !!"
            inputGuessTextField.isEnabled = false
        }
    }
    
    func changeImage() {
        switch guessCount {
        case 6:
            legoImage.image = UIImage(named: "legoShark1")
        case 5:
            legoImage.image = UIImage(named: "legoShark2")
        case 4:
            legoImage.image = UIImage(named: "legoShark3")
        case 3:
            legoImage.image = UIImage(named: "legoShark4")
        case 2:
            legoImage.image = UIImage(named: "legoShark5")
        case 1:
            legoImage.image = UIImage(named: "legoShark6")
        case 0:
            legoImage.image = UIImage(named: "legoShark7")
        default:
            legoImage.image = UIImage(named: "legoShark8")
        }
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
            
            if (isBackSpace == -92) || currentText.count > 1 {
                return false
            }
            
            
//            if currentText.count > 1) {
//                return false
//            }
        } else {
            guard let text = textField.text else {
                return false
            }
            let currentText = text + string
            if currentText.count > 7 {
                return false
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if textField == inputWordTextField {
            legoImage.image = UIImage(named: "legoShark1")
            wordEntered = inputWordTextField.text?.lowercased() ?? ""
            enteredWord.text = underScores()
            inputWordTextField.isEnabled = false
            player2Label?.text = "Guess A Letter !!"
            print(wordEntered)
        } else if textField == inputGuessTextField {
            
            letterGuess = inputGuessTextField.text?.lowercased() ?? ""
            checkUsersGuess()
            replaceUnderscores()
            
            if incorrectGuess {
                changeImage()
            } else if gameOverBool {
                
            }
            gameOver()
            print(gameOverBool)
            print(letterArray)
        }
        textField.text = ""
        
        return true
    }
}

