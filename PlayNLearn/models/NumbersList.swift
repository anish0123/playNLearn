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

//question, option and answer stored in an array
struct NumberList {
    static let numbers = [
        Numbers(question: 01, option: [01,10,11,12], answer: 01),
        Numbers(question: 02, option: [20,02,22,25], answer: 02),
        Numbers(question: 03, option: [31,30,03,33], answer: 03),
        Numbers(question: 04, option: [04,40,42,44], answer: 04),
        Numbers(question: 05, option: [50,05,54,55], answer: 05),
        Numbers(question: 06, option: [60,06,66,61], answer: 06),
        Numbers(question: 07, option: [70,07,77,76], answer: 07),
        Numbers(question: 08, option: [80,08,88,89], answer: 08),
        Numbers(question: 09, option: [09,90,91,99], answer: 09),
        Numbers(question: 10, option: [10,11,01,13], answer: 10),
        Numbers(question: 11, option: [12,11,01,15], answer: 11),
        Numbers(question: 12, option: [21,11,12,16], answer: 12),
        Numbers(question: 13, option: [31,11,13,18], answer: 13),
        Numbers(question: 14, option: [10,11,14,41], answer: 14),
        Numbers(question: 15, option: [10,15,11,51], answer: 15)
    ]
}
