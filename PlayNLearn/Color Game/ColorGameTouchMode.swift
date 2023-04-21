//
//  colorGameTouchMode.swift
//  PlayNLearn
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI

struct ColorGame {
    let id: Int
    let color: Color
    let name: String
}

extension ColorGame {
    static let allColor = [
        ColorGame(id: 1,color: Color("colorgameRed"), name: "red"),
        ColorGame(id: 2,color: Color("blue"), name: "blue"),
        ColorGame(id: 3,color: Color("colorgameGreen"), name: "green"),
        ColorGame(id: 4,color: Color("colorgameBlack"), name: "black"),
        ColorGame(id: 5,color: Color("colorGameOrange"), name: "orange"),
        ColorGame(id: 6,color: Color("colorgamePurple"), name: "purple"),
    ]
}
