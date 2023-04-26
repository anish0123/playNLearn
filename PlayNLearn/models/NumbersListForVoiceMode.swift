//
//  NumberGameWithSpeech.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 5.4.2023.
//

import Foundation
import SwiftUI

// Struct designed to contain the number itself and it's written form as localized string key
struct NumbersForVoice {
    let writtenNumbers : LocalizedStringKey
    let number : Int
}

// Extension for introducing number for number game with speech
extension NumbersForVoice {
    static let numbers = [
        NumbersForVoice(writtenNumbers: "one", number: 1),
        NumbersForVoice(writtenNumbers: "two", number: 2),
        NumbersForVoice(writtenNumbers: "three", number: 3),
        NumbersForVoice(writtenNumbers: "four", number: 4),
        NumbersForVoice(writtenNumbers: "five", number: 5),
        NumbersForVoice(writtenNumbers: "six", number: 6),
        NumbersForVoice(writtenNumbers: "seven", number: 7),
        NumbersForVoice(writtenNumbers: "eight", number: 8),
        NumbersForVoice(writtenNumbers: "nine", number: 9),
        NumbersForVoice(writtenNumbers: "ten", number: 10),
    
    ]
}


/*
 All of the bottom extensions are used for chaning localized string key to string
 Source: https://stackoverflow.com/questions/60841915/how-to-change-localizedstringkey-to-string-in-swiftui
 */

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



