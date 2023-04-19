//
//  ShapeList.swift
//  PlayNLearn
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI

struct Shapes: Identifiable {
    let id = UUID()
    let question: String
    let option: [String]
    let answer: String
    
}

struct ShapeList {
    static let shapes = [
        Shapes(question: "circle", option: ["circle", "star", "diamond"], answer: "circle"),
        Shapes(question: "diamond", option: ["heart", "rectangle", "diamond"], answer: "diamond" ),
        Shapes(question: "heart", option: ["heart", "star", "diamond"], answer: "heart"),
        Shapes(question: "triangle", option: ["diamond", "square", "triangle"], answer: "triangle"),
        Shapes(question: "square", option: ["rectangle", "square", "circle"], answer: "square"),
        Shapes(question: "rectangle", option: ["square", "rectangle", "diamond"], answer: "rectangle"),
        Shapes(question: "star", option: ["star", "heart", "diamond"], answer: "star")
    ]
}
