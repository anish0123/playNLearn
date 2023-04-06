//
//  NumberGameView.swift
//  PlayNLearn
//
//  Created by iosdev on 3.4.2023.
//

import SwiftUI

struct NumberGameView: View {
    var numbers: [Numbers] = NumberList.numbers
    let workoutDateRange = Date()...Date().addingTimeInterval(60)
    @State var randomNum: Int
    
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
                    .strokeBorder(.white, lineWidth: 15)
                    .overlay {
                        Text("\(numbers[randomNum].question)")
                            .font(.system(size: 60, weight: .regular))
                    }
                    .padding()
                
                Spacer()
                Divider()
            
                Text(Date().addingTimeInterval(30),style: .timer)
                    .frame(width: 150,height: 50)
                    .font(.system(size: 25, weight: .regular))
                    .foregroundColor(.red)
                
                HStack {
                    Text("\(numbers[randomNum].option[0])")
                        .font(.system(size: 30, weight: .regular))
                        .frame(width: 50,height: 50)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding()
                        .onTapGesture (count: 1) {
                            checkAnswer(numbers[randomNum].question, numbers[randomNum].option[0])
                        }
                    
                    Text("\(numbers[randomNum].option[1])")
                        .font(.system(size: 30, weight: .regular))
                        .frame(width: 50,height: 50)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding()
                        .onTapGesture (count: 1) {
                            checkAnswer(numbers[randomNum].question, numbers[randomNum].option[1])
                        }
                    
                    Text("\(numbers[randomNum].option[2])")
                        .font(.system(size: 30, weight: .regular))
                        .frame(width: 50,height: 50)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding()
                        .onTapGesture (count: 1) {
                            checkAnswer(numbers[randomNum].question, numbers[randomNum].option[2])
                        }
                }
                .padding()
                
                Button{
                    print("")
                    randomNum = Int.random(in: 0...NumberList.numbers.count - 1 )
                } label: {
                    Text("Skip")
                        .frame(width: 150, height: 50)
                        .background(Color(.white))
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .cornerRadius(10)
                }
            }
        }
    }
    
    func correctAnswer () {
        
    }
    
    func checkAnswer(_ question: Int, _ answer: Int) {
        
        if question == answer {
           print("correct answer")
        }else {
            print("Wrong answer")
        }
    }
}


struct NumberGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumberGameView(randomNum: 3)
    }
}

