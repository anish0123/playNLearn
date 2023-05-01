//
//  ShapeList.swift
//  PlayNLearn
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI

struct Shapes: Identifiable,Codable {
    let id = UUID()
    let question: String
    let option: [String]
    let description: String
    
    var answer: LocalizedStringKey {
        return LocalizedStringKey(description)
    }
    
}

 struct ShapeList {
 static let shapes = [
 Shapes(question: "circle", option: ["circle", "star", "diamond"], description: "circle"),
 Shapes(question: "diamond", option: ["heart", "rectangle", "diamond"], description: "diamond" ),
 Shapes(question: "heart", option: ["heart", "star", "diamond"], description: "heart"),
 Shapes(question: "triangle", option: ["diamond", "square", "triangle"], description: "triangle"),
 Shapes(question: "square", option: ["rectangle", "square", "circle"], description: "square"),
 Shapes(question: "rectangle", option: ["square", "rectangle", "diamond"], description: "rectangle"),
 Shapes(question: "star", option: ["star", "heart", "diamond"], description: "star")
 ]
 }
 
