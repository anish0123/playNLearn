//
//  ColorViewModel.swift
//  PlayNLearn
//
//  Created by iosdev on 19.4.2023.
//

import SwiftUI
import ConfettiSwiftUI
import SPConfetti

class ColorViewModel: ObservableObject {
    @State var showPopUp: Bool = false
    //for gesture properties
    @Published var currentObject: ColorGame?
    @Published var currentPosition = initialPosition
    @Published var highlightedObject: Int?
    @Published var draggableObjectOpacity: CGFloat = 1.0
    @Published var isGameOver = false
    
    //for co-ordinates
    private static let initialPosition = CGPoint(
        x:UIScreen.main.bounds.midX,
        y: UIScreen.main.bounds.maxY - 150
    )
    private var frames: [Int: CGRect] = [:]
    
    //for objects in screen
    private var objects = Array(ColorGame.allColor.shuffled().prefix(6))
    var optionContainers = ColorGame.allColor.shuffled()
    
    //Game lifecycle
    func setupGame() {
        currentObject = objects.popLast()
    }
    func nextRound(){
        currentObject = objects.popLast()
        if currentObject == nil {
            gameOver()
        }else{
            prepareObjects()
        }
        
    }
    func gameOver(){
        objects = Array(ColorGame.allColor.shuffled().prefix(6))
        nextRound()
    }
        
    func prepareObjects(){
        withAnimation{
            optionContainers.shuffle()
        }
        withAnimation(.none){
            resetPosition()
            withAnimation{
                draggableObjectOpacity = 1.0
            }
        } 
    }
        
    //for screenupdate
    func update(frame:CGRect, for id:Int) {
        frames[id] = frame
    }
    
    func update(dragPosition:CGPoint) {
        currentPosition = dragPosition
        for (id, frame)in frames where frame.contains(dragPosition){
            highlightedObject = id
            return
        }
        highlightedObject = nil
    }
    
    // checks if current color matches the draggable color
    func checkAnswer () -> Bool {
        defer {highlightedObject = nil}
        
        guard let highlightedObject = highlightedObject else {
            resetPosition()
            return false
        }
            
        if highlightedObject == currentObject?.id {
            draggableObjectOpacity = 0
            nextRound()
            return true
        }else{
            resetPosition()
            return false
        }
    }
    
    func resetPosition(){
        currentPosition = ColorViewModel.initialPosition
    }
    
    func isHighlightedId(id: Int) ->Bool {
        highlightedObject == id
    }
}

