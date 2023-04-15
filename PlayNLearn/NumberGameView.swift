//
//  NumberGameView.swift
//  PlayNLearn
//
//  Created by iosdev on 3.4.2023.
//

import SwiftUI
import ConfettiSwiftUI
import SPConfetti

struct NumberGameView: View {
    @State private var showPopUp: Bool = false
    @State private var rightAnswer: Bool = false
    var numbers: [Numbers] = NumberList.numbers
    @State var randomNum: Int
    @State private var counter = 0
    @State private var timeRemaining = 30.0

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
                        
                        Text("\(numbers[randomNum].question)")
                            .font(.system(size: 80, weight: .bold))
                            .frame(width: 150,height: 150)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                        
                    }
                    .frame(width: 200)
                    .opacity(0.9)
                    .padding(60)
                    .onAppear {
                        startTimer()
                    }
                    
                }
                
                Rectangle()
                    .fill(Color("rectangularbox"))
                    .frame(width: 320, height: 250)
                    .cornerRadius(30)
                    .overlay{
                        VStack {
                            HStack {
                                Text("\(numbers[randomNum].option[0])")
                                    .font(.system(size: 25, weight: .regular))
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(Color("lightGreen"))
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color("optionstroke"), lineWidth: 4)
                                    )
                                    .padding()
                                    .onTapGesture (count: 1) {
                                        checkAnswer(numbers[randomNum].question, numbers[randomNum].option[0])

                                    }
                                
                                Text("\(numbers[randomNum].option[1])")
                                    .font(.system(size: 25, weight: .regular))
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(Color("lightGreen"))
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color("optionstroke"), lineWidth: 4)
                                    )
                                    .padding()
                                    .onTapGesture (count: 1) {
                                        checkAnswer(numbers[randomNum].question, numbers[randomNum].option[1])
                                    }
                            }
                            
                            HStack {
                                Text("\(numbers[randomNum].option[2])")
                                    .font(.system(size: 25, weight: .regular))
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(Color("lightGreen"))
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color("optionstroke"), lineWidth: 4)
                                    )
                                    .padding()
                                    .onTapGesture (count: 1) {
                                        checkAnswer(numbers[randomNum].question, numbers[randomNum].option[2])
                                    }
                                
                                Text("\(numbers[randomNum].option[3])")
                                    .font(.system(size: 25, weight: .regular))
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(Color("lightGreen"))
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color("optionstroke"), lineWidth: 4)
                                    )
                                    .padding()
                                    .onTapGesture (count: 1) {
                                        checkAnswer(numbers[randomNum].question, numbers[randomNum].option[3])
                                    }
                            }
                        }
                    }
                .padding()
                Rectangle()
                    .fill(Color("lightGreen"))
                    .frame(width: 110, height: 50)
                    .cornerRadius(20)
                    .overlay{
                        Label("Skip", systemImage: "forward")
                            .font(.system(size: 20))
                    }
                    .onTapGesture (count: 1) {
                        timeRemaining = 30.0
                        startTimer()
                        randomNum = Int.random(in: 0...NumberList.numbers.count - 1 )
                    }
            }
            .padding(50)
            
            PopUpWindow(title: rightAnswer ? "Correct Answer" : "Incorrect Answer",
                        buttonText: rightAnswer ? "Continue" : "Retry",
                        show: $showPopUp, answer: $rightAnswer)
        }
    }
    
    func startTimer(){
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { i in
            
            if timeRemaining > 0 && showPopUp == true {
                i.invalidate()
            } else if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                randomNum = Int.random(in: 0...NumberList.numbers.count - 1 )
                timeRemaining = 30
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    
    func nextQuestion() {
        randomNum = Int.random(in: 0...NumberList.numbers.count - 1 )
    }
    
    func checkAnswer(_ question: Int, _ answer: Int) {
        
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
        nextQuestion()
        startTimer()
    }

}


struct NumberGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumberGameView(randomNum: 3)
    }
}

