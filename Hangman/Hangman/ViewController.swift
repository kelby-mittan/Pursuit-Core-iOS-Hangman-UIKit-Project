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
    
    var enteredGuess = Set<String>()
    var wordEntered = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputWordTextField?.delegate = self
        inputGuessTextField?.delegate = self
    }

    func checkUsersGuess() {
    //        guessingGameModel.getResult(inputTextField)
        let enterWord = inputWordTextField.text ?? ""
        let guessedLetter = inputGuessTextField.text ?? "x"
        
        if enterWord.contains(guessedLetter) {
            print("correct")
        } else {
            print("nope")
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
        guard let text = textField.text else {
            return false
        }
        let currentText = text + string
        
        if enteredGuess.contains(currentText) {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // dismiss keyboard
        textField.resignFirstResponder()
        print(inputWordTextField.text ?? "error")
        wordEntered = inputWordTextField.text ?? ""
        let letterGuessed = inputGuessTextField.text ?? ""
        print(inputGuessTextField.text ?? "error")
        checkUsersGuess()
        print(wordEntered)
        print(letterGuessed)
        if wordEntered.contains(letterGuessed) {
            print("correct")
        } else {
            print("oh so wrong")
        }
        // clear textField
        textField.text = ""
        
        
        return true
    }
}

