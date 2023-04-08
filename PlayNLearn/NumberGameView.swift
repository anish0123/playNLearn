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

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Learn Numbers")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.bottom)
                
                Text("Score")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.bottom)
                
                
                HStack {
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Image(systemName: "star")
                }
                .padding(.bottom,20)
                
                Text("Select the correct number")
                    .font(.system(size: 25, weight: .semibold))

                
                Circle()
                    .strokeBorder(.white, lineWidth: 10)
                    .overlay {
                        Text("\(numbers[randomNum].question)")
                            .font(.system(size: 60, weight: .regular))
                    }
                    .padding()
                
                
                Spacer()
                
                Rectangle()
                    .fill(Color.white)
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
                                            .stroke(.green, lineWidth: 4)
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
                                            .stroke(.green, lineWidth: 4)
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
                                            .stroke(.green, lineWidth: 4)
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
                                            .stroke(.green, lineWidth: 4)
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
                    randomNum = Int.random(in: 0...NumberList.numbers.count - 1 )
                } label: {
                    Text("Skip")
                        .frame(width: 200, height: 50)
                        .background(Color("button"))
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .cornerRadius(25)
                }
            }
            
            PopUpWindow(title: rightAnswer ? "Correct Answer" : "Incorrect Answer",
                        message: "",
                        buttonText: rightAnswer ? "Continue" : "Retry",
                        show: $showPopUp, answer: $rightAnswer)
        }
    }
    
    func nextQuestion() {
        randomNum = Int.random(in: 0...NumberList.numbers.count - 1 )
    }
    
    func checkAnswer(_ question: Int, _ answer: Int) {
        
        if question == answer {
            SPConfetti.startAnimating(.centerWidthToUp, particles: [.triangle, .arc], duration: 1)

            withAnimation(.easeInOut) {
                showPopUp.toggle()
                rightAnswer.toggle()
            }
        }else {
            withAnimation(.easeInOut) {
                showPopUp.toggle()
            }
        }
        
        //call nextquestion function with a 1 second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            nextQuestion()
         }
    }
}


struct NumberGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumberGameView(randomNum: 3)
    }
}

