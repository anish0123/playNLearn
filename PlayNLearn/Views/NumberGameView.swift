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
    @State private var showingAlert = false
    @State var myIntArray = [2]
    @State private var isSpinning = false
    @State var showPopUp: Bool = false
    @State private var rightAnswer: Bool = false
    var numbers: [Numbers] = NumberList.numbers
    @State var randomNum: Int
    @State private var counter = 0
    @State var timeRemaining = 30.0
    @State private var score  = 0
    @State private var animate = false

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
            .padding(50)
            
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
    
    func startTimer(){
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { i in
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                
            } else {
                nextQuestion()
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func nextQuestion() {
        var number: Int
        timeRemaining = 30.0
        number = Int.random(in: 0...NumberList.numbers.count - 1 )
        
        repeat{
            number = Int.random(in: 0...NumberList.numbers.count - 1 )
            if myIntArray.count == 15 {
                showingAlert = true
                myIntArray.removeAll()
            }
        } while myIntArray.contains(numbers[number].question)
        
        randomNum = number
        myIntArray.append(numbers[randomNum].question)
    }
    
    func checkAnswer(_ question: Int, _ answer: Int) {
        
        if question == answer {
            SPConfetti.startAnimating(.centerWidthToUp, particles: [.triangle, .arc], duration: 1)
            SoundManager.instance.playSound(sound: .win)
            score += 10
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

struct ratingView: View {
    @State private var isSpinning = false
    let number: Int
    
    var body: some View {
        HStack{
            ForEach(0..<number,  id: \.self) { i in
                Image(systemName: "star.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(EllipticalGradient(
                        colors:[Color.red, Color.yellow],
                        center: .center,
                        startRadiusFraction: 0.0,
                        endRadiusFraction: 0.5))
                    .hueRotation(.degrees(isSpinning ? 0 : 360))
                    .animation(.linear(duration: 1.5).repeatForever(autoreverses: true).delay(0.2), value: isSpinning)
                    .onAppear() {
                        isSpinning.toggle()
                    }
            }
        }
    }
}


struct NumberGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumberGameView(randomNum: 3)
    }
}

