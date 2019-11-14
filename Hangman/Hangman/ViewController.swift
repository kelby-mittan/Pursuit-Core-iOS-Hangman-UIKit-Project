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
    private var guessCount = 7
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
            print("nope")
        }
    }
    
    func gameOver() {
        if guessCount == 0 || !letterArray.contains("_") {
            gameOverBool = true
            legoImage.image = UIImage(named: "legoShark8")
        }
    }
    
    func changeImage() {
        switch guessCount {
        case 7:
            legoImage.image = UIImage(named: "legoShark9")
        case 6:
            legoImage.image = UIImage(named: "legoShark2")
        case 5:
            legoImage.image = UIImage(named: "legoShark3")
        case 4:
            legoImage.image = UIImage(named: "legoShark4")
        case 3:
            legoImage.image = UIImage(named: "legoShark5")
        case 2:
            legoImage.image = UIImage(named: "legoShark6")
        case 1:
            legoImage.image = UIImage(named: "legoShark7")
        case 0:
            legoImage.image = UIImage(named: "legoShark8")
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
            if currentText.count > 1 {
                return false
            }
        } else {
            guard let text = textField.text else {
                return false
            }
            let currentText = text + string
            if currentText.count > 6 {
                return false
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
//        gameOver()
        if textField == inputWordTextField {
            wordEntered = inputWordTextField.text ?? ""
            enteredWord.text = underScores()
            inputWordTextField.isEnabled = false
            player2Label?.text = "Guess A Letter !!"
            print(wordEntered)
        } else if textField == inputGuessTextField {
            
            letterGuess = inputGuessTextField.text ?? ""
//            guessCount -= 1
            checkUsersGuess()
            replaceUnderscores()
            if incorrectGuess {
                changeImage()
            }
        }
        textField.text = ""
        
        return true
    }
}

