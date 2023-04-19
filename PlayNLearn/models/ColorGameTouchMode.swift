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
}

extension ColorGame {
    static let allColor = [
        ColorGame(id: 1,color: Color("colorGameRed")),
        ColorGame(id: 2,color: Color("blue")),
        ColorGame(id: 3,color: Color("colorGameGreen")),
        ColorGame(id: 4,color: Color("colorGameBlack")),
        ColorGame(id: 5,color: Color("colorGameOrange")),
        ColorGame(id: 6,color: Color("colorGamePurple")),
    ]
}
