//
//  ColorGameTouchModeView.swift
//  PlayNLearn
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI
import SPConfetti

struct ColorGameTouchModeView: View {
    @State var showPopUp: Bool = false
    @State private var rightAnswer: Bool = false
    @State var timeRemaining = 30.0
    @StateObject private var viewModel = ColorViewModel()
    
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var drag:some Gesture {
        DragGesture()
            .onChanged {state in
                viewModel.update(dragPosition: state.location)
            }
            .onEnded {state in
                viewModel.update(dragPosition: state.location)
                if viewModel.checkAnswer() == true {
                    SPConfetti.startAnimating(.centerWidthToUp, particles: [.triangle, .arc], duration: 1)
                    SoundManager.instance.playSound(sound: .win)
                    withAnimation(.easeInOut) {
                        showPopUp.toggle()
                        rightAnswer.toggle()
                    }
                }
            }
    }
    
    var body: some View {
        ZStack{
            LazyVGrid(columns: gridItems,spacing: 100){
                ForEach(viewModel.optionContainers, id: \.id) { colorGame in
                    OptionContainer(
                        colorGame: colorGame,
                        viewModel: viewModel
                    )
                }
            }
            if let currentObject = viewModel.currentObject {
                DragObjectForColorGame(
                    colorGame: currentObject,
                    position: viewModel.currentPosition,
                    gesture: drag
                )
                .opacity(viewModel.draggableObjectOpacity)
                
            }
            PopUpWindow(title: rightAnswer ? "Correct Answer" : "Incorrect Answer",
                        buttonText: rightAnswer ? "Continue" : "Retry",
                        show: $showPopUp, answer: $rightAnswer,
                        timeRemaining: $timeRemaining)
        }
        .onAppear{
            viewModel.setupGame()
        }
    }

}

struct ColorGameTouchModeView_Previews: PreviewProvider {
    static var previews: some View {
        ColorGameTouchModeView()
    }
}