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

class NumberGameWithSpeech {
    let low: Int
    let high: Int
    let correctAnswer: Int
    
    init(low: Int = 0, high: Int = 20) {
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
