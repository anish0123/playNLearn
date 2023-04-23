//
//  NumberGameWithSpeech.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 5.4.2023.
//

import Foundation

enum GuessResult {
    case right, wrong
}

struct NumberGameWithSpeech {
    let low: Int
    let high: Int
    let correctAnswer: Int
    
    init(low: Int = 0, high: Int = allNumbers.count) {
        self.low = low
        self.high = high
        self.correctAnswer = Int.random(in: low...high)
    }
    
    func checkAnswer(answer:Int) -> GuessResult {
        print("Correct Answer: \(correctAnswer)")
        print("Answer: \(answer)")
        if(answer == correctAnswer) {
            return .right
        } else {
            return .wrong
        }
    }
    
}

extension NumberGameWithSpeech {
    static let allNumbers = ["one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9, "ten": 10, "eleven": 11, "twelve": 12, "thirteen": 13, "fourteen": 14, "fifteen": 15, "sixteen":                                 16, "seventeen": 17, "eighteen": 18, "nineteen": 19, "twenty": 20]
}
