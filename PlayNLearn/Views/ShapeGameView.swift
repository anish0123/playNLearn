//
//  ShapeGameView.swift
//  PlayNLearn
//
//  Created by iosdev on 15.4.2023.
//

import SwiftUI
import SPConfetti

// This struct is created as view for shape game that can played by selecting the provided option
struct ShapeGameView: View {
    // Initialising vairbales needed for the view
    @State private var showingAlert = false
    @State var showPopUp: Bool = false
    @State var myShapeArray = ["diamond"]
    @State private var rightAnswer: Bool = false
    @State private var timeRemaining = 30.0
    @State var randomNum: Int
    var shapes: [Shapes] = ShapeList.shapes
    @State private var score  = 0
    
    var body: some View {
        
        ZStack {
            Image("zebra")
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
                
                //button to skip the current question
                Button{
                    nextQuestion()
                } label: {
                    Text("skip")
                        .frame(width: 120)
                    LottieView(fileName: "next", loopMode: .loop)
                }
                .font(.system(size: 25, weight: .bold, design: .default))
                .frame(width: 200, height: 50)
                .background(Color(.orange))
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .cornerRadius(10)
            }
            .padding(80)
            
            PopUpWindow(title: rightAnswer ? "Correct Answer" : "Incorrect Answer",
                        buttonText: rightAnswer ? "Continue" : "Retry",
                        show: $showPopUp, answer: $rightAnswer,
                        timeRemaining: $timeRemaining)
        }
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("Game Over"),
                message: Text("Play Again"),
                dismissButton: .default(Text("Continue")){
                    nextQuestion()
                }
            )
        }
    }
    
    // Method to start the timer of the game so after 30 seconds the game is over if user doesnot answer
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
    
    //Method for getting next question
    func nextQuestion(){
        var number: Int
        timeRemaining = 30.0
        number = Int.random(in: 0...ShapeList.shapes.count - 1 )
        
        //shows the unique question each time
        repeat{
            number = Int.random(in: 0...ShapeList.shapes.count - 1 )
            if myShapeArray.count == 7 {
                showingAlert = true
                myShapeArray.removeAll()
            }
        } while myShapeArray.contains(shapes[number].question)
        
        randomNum = number
        
        myShapeArray.append(shapes[number].question)
    }
    
    //Checks if the selected option is correct
    func checkAnswer(_ question: String, _ answer: String) {
        
        if question == answer {
            SPConfetti.startAnimating(.centerWidthToUp, particles: [.triangle, .arc], duration: 1)
            SoundManager.instance.playSound(sound: .win)
            withAnimation(.easeInOut) {
                showPopUp.toggle()
                rightAnswer.toggle()
            }
            
        } else {
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
