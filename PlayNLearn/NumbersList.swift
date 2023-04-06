//
//  NumbersList.swift
//  PlayNLearn
//
//  Created by iosdev on 3.4.2023.
//

import SwiftUI

struct Numbers: Identifiable {
    let id = UUID()
    let question: Int
    let option: [Int]
    let answer: Int
    
}

struct NumberList {
    static let numbers = [
        Numbers(question: 01, option: [01,10,11], answer: 01),
        Numbers(question: 02, option: [20,02,22], answer: 02),
        Numbers(question: 03, option: [31,30,03], answer: 03),
        Numbers(question: 04, option: [04,40,42], answer: 04),
        Numbers(question: 05, option: [50,05,54], answer: 05),
        Numbers(question: 06, option: [60,06,66], answer: 06),
        Numbers(question: 07, option: [70,07,78], answer: 07),
        Numbers(question: 08, option: [80,08,88], answer: 08),
        Numbers(question: 09, option: [09,90,91], answer: 09),
        Numbers(question: 10, option: [10,11,01], answer: 10)
    ]
}
