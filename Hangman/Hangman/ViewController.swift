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
    
    private var enteredGuess = Set<String>()
    private var wordEntered = ""
    private var letterArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputWordTextField?.delegate = self
        inputGuessTextField?.delegate = self
//        enteredWord.text = "xxx"
    }
    func underScores() -> String {
        var enterWord = ""
        for _ in wordEntered {
            letterArray.append("_ ")
        }
//        for char in letterArray {
//            print(char, terminator: " ")
//        }
        enterWord = letterArray.joined()
        return enterWord
    }
    
    func checkUsersGuess() {
//        let enterWord = inputWordTextField.text ?? ""
        let guessedLetter = inputGuessTextField.text ?? "x"
        print(wordEntered)
        enteredGuess.insert(guessedLetter)
        if wordEntered.contains(guessedLetter) {
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
        
//        print(inputWordTextField.text ?? "error")
        wordEntered = inputWordTextField.text ?? ""
        let letterGuessed = inputGuessTextField.text ?? ""
        print(inputGuessTextField.text ?? "error")
        enteredWord.text = underScores()
        checkUsersGuess()
//        print(wordEntered)
        print(letterGuessed)
        // clear textField
        textField.text = ""
        
        
        return true
    }
}

