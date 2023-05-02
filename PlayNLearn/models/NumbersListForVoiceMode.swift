//
//  NumberGameWithSpeech.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 5.4.2023.
//

import Foundation
import SwiftUI

// Struct designed to contain the number itself and it's written form as localized string key
struct NumbersForVoice: Codable {
    let number : Int
    let writtenNumber : String
    
    // Converting string into localizedStringKey with codable protocol
    // Source: https://stackoverflow.com/questions/73272549/how-to-make-localizedstingkey-type-conform-to-codable-protocol-in-swift
    var localizedDescription: LocalizedStringKey {
        return LocalizedStringKey(writtenNumber)
    }
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



