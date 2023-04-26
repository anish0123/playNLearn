//
//  ShapeGameView.swift
//  PlayNLearn
//
//  Created by iosdev on 15.4.2023.
//

import SwiftUI
import SPConfetti

struct ShapeGameView: View {
    @State var showPopUp: Bool = false
    @State private var rightAnswer: Bool = false
    @State private var timeRemaining = 30.0
    @State var randomNum: Int
    var shapes: [Shapes] = ShapeList.shapes
    
    var body: some View {
        
        ZStack {
            Image("zebra")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Group {
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 20)
                            .opacity(0.3)
                            .foregroundColor(.white)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(1 - timeRemaining/30.0))
                            .stroke(style: StrokeStyle(lineWidth: 20.0, lineJoin: .round))
                            .foregroundColor(timeRemaining > 8 ? .green : .red)
                            .rotationEffect(.degrees(-90))
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 180, height: 180)
                        
                        Image(shapes[randomNum].question)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 200)
                    .padding(60)
                    .onAppear {
                        startTimer()
                    }
                }
                
                Rectangle()
                    .fill(Color("rectangularbox"))
                    .frame(width: 380, height: 200)
                    .cornerRadius(30)
                    .overlay{
                        HStack {
                            Image(shapes[randomNum].option[0])
                                .resizable()
                                .frame(width: 80, height: 80)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color("optionstroke"), lineWidth: 4)
                                        .frame(width: 90, height: 90)
                                )
                                .padding()
                                .onTapGesture (count: 1) {
                                    checkAnswer(shapes[randomNum].question, shapes[randomNum].option[0])

                                }
                            
                            Image(shapes[randomNum].option[1])
                                .resizable()
                                .frame(width: 80, height: 80)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color("optionstroke"), lineWidth: 4)
                                        .frame(width: 90, height: 90)
                                )
                                .padding()
                                .onTapGesture (count: 1) {
                                    checkAnswer(shapes[randomNum].question, shapes[randomNum].option[1])

                                }
                            
                            Image(shapes[randomNum].option[2])
                                .resizable()
                                .frame(width: 80, height: 80)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color("optionstroke"), lineWidth: 4)
                                        .frame(width: 90, height: 90)
                                )
                                .padding()
                                .onTapGesture (count: 1) {
                                    checkAnswer(shapes[randomNum].question, shapes[randomNum].option[2])

                                }
                        }
                    }
                    .padding()
                
                Rectangle()
                    .fill(Color("lightGreen"))
                    .frame(width: 110, height: 50)
                    .cornerRadius(20)
                    .overlay{
                        Label("skip", systemImage: "forward")
                            .font(.system(size: 20))
                    }
                    .onTapGesture (count: 1) {
                        timeRemaining = 30.0
                        randomNum = Int.random(in: 0...ShapeList.shapes.count - 1 )
                    }
            }
            .padding(80)
            
            PopUpWindow(title: rightAnswer ? "Correct Answer" : "Incorrect Answer",
                        buttonText: rightAnswer ? "Continue" : "Retry",
                        show: $showPopUp, answer: $rightAnswer,
                        timeRemaining: $timeRemaining)
            
            
        }
    }
    
    func startTimer(){
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                randomNum = Int.random(in: 0...ShapeList.shapes.count - 1 )
                timeRemaining = 30
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func nextQuestion(){
        timeRemaining = 30.0
        randomNum = Int.random(in: 0...ShapeList.shapes.count - 1 )
    }
    
    func checkAnswer(_ question: String, _ answer: String) {
        
        if question == answer {
            SPConfetti.startAnimating(.centerWidthToUp, particles: [.triangle, .arc], duration: 1)
            SoundManager.instance.playSound(sound: .win)
            withAnimation(.easeInOut) {
                showPopUp.toggle()
                rightAnswer.toggle()
            }
            
        }else {
            SoundManager.instance.playSound(sound: .lose)
            withAnimation(.easeInOut) {
                showPopUp.toggle()
            }
        }
        
        // Wait for 1 second before calling the funciton nextQuestion
        DispatchQueue.main.asyncAfter(deadline: .now() +  1){
            nextQuestion()
        }
    }

}

struct ShapeGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeGameView(randomNum: 3)
    }
}
