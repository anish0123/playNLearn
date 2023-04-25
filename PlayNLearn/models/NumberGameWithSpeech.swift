//
//  NumberGameWithSpeech.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 5.4.2023.
//

import Foundation
import SwiftUI

// Enum for cases of getting right and wrong answer
enum GuessResult {
    case right, wrong
}

// Struct created to have number games random number in range of lowest and highest number
struct NumberGameWithSpeech {
    let low: Int
    let high: Int
    let correctAnswer: Int
    
    init(low: Int = 0, high: Int = 20) {
        self.low = low
        self.high = high
        self.correctAnswer = Int.random(in: low...high)
    }
    
    // Method to check the output given by the user it it's correct or not
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

struct NumbersForVoice {
    let writtenNumbers : LocalizedStringKey
    let numbers : Int
}

extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
}

extension String {
    static func localizedString(for key: String,
                                locale: Locale = .current) -> String {
        
        let language = locale.language.languageCode?.identifier
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        
        return localizedString
    }
}

extension LocalizedStringKey {
    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.stringKey ?? "", locale: locale)
    }
}


extension NumbersForVoice {
    static let numbers = [
        NumbersForVoice(writtenNumbers: "one", numbers: 1),
        NumbersForVoice(writtenNumbers: "two", numbers: 2),
        NumbersForVoice(writtenNumbers: "three", numbers: 3),
        NumbersForVoice(writtenNumbers: "four", numbers: 4),
        NumbersForVoice(writtenNumbers: "five", numbers: 5),
        NumbersForVoice(writtenNumbers: "six", numbers: 6),
        NumbersForVoice(writtenNumbers: "seven", numbers: 7),
        NumbersForVoice(writtenNumbers: "eight", numbers: 8),
        NumbersForVoice(writtenNumbers: "nine", numbers: 9),
        NumbersForVoice(writtenNumbers: "ten", numbers: 10),
    
    ]
}

