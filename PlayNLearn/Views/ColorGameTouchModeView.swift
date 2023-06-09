//
//  ColorGameTouchModeView.swift
//  PlayNLearn
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI
import SPConfetti

//This struct is created as view for color game that can played by selecting the right color
struct ColorGameTouchModeView: View {
    @State private var showingAlert = false
    @State private var score  = 0
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
                    score += 10
                    withAnimation(.easeInOut) {
                        showPopUp.toggle()
                        rightAnswer.toggle()
                    }
                }
            }
    }
    
    var body: some View {
        ZStack{

            Image("giraffeneck")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    if (score > 50) {
                        ratingView(number: 5)
                    } else if (score > 40) {
                        ratingView(number: 4)
                    } else if (score > 30) {
                        ratingView(number: 3)
                    } else if (score > 20) {
                        ratingView(number: 2)
                    } else if ( score > 10) {
                        ratingView(number: 1)
                    }
                }
                .padding()
                
                LazyVGrid(columns: gridItems,spacing: 80){
                    ForEach(viewModel.optionContainers, id: \.id) { colorGame in
                        OptionContainer(
                            colorGame: colorGame,
                            viewModel: viewModel
                        )
                    }
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
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("Game Over"),
                message: Text("Play Again"),
                dismissButton: .default(Text("Continue"))
            )
        }

    }

}

struct ColorGameTouchModeView_Previews: PreviewProvider {
    static var previews: some View {
        ColorGameTouchModeView()
    }
}
