//
//  DragObjectForColorGame.swift
//  PlayNLearn
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI

struct DragObjectForColorGame<Draggable: Gesture>: View {
    let colorGame: ColorGame
    private let size: CGFloat = 100
    let position: CGPoint
    let gesture: Draggable
    
    var body: some View {
        Circle()
            .fill(colorGame.color)
            .frame(width: size,height: size)
            .shadow(radius: 10)
            .position(position)
            .gesture(gesture)
    }
}

struct DragObjectForColorGame_Previews: PreviewProvider {
    static var previews: some View {
        DragObjectForColorGame(
            colorGame:ColorGame.allColor.first!,
            position: CGPoint(x: 100, y: 100),
            gesture: DragGesture())
    }
}
