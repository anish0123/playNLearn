//
//  NumberGameViewWithSpeech.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 5.4.2023.
//

import SwiftUI

struct NumberGameViewWithSpeech: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var output = ""
    @State private var number: Int = 0
    @State private var numberMap = ["one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9, "ten": 10, "eleven": 11, "twelve": 12, "thirteen": 13, "fourteen": 14, "fifteen": 15, "sixteen": 16, "seventeen": 17, "eighteen": 18, "nineteen": 19, "twenty": 20]
    @State private var game = NumberGameWithSpeech()
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
                .padding(.bottom,50)
                
                Divider()
                
                Group {
                    Text("Please tell the correct number")
                        .font(.system(size: 25, weight: .semibold))
                    
                    Text("\(game.correctAnswer)")
                        .font(.system(size: 60, weight: .regular))
                        .frame(width: 180,height: 180)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding(.top, 20)
                    
                    Text(output)
                    
                }
                
                Spacer()
                Divider()
                
                HStack {
                    Button("Mic On"){
                        // Turning on the speech recognition
                        speechRecognizer.reset()
                        speechRecognizer.transcribe()
                        output = speechRecognizer.transcript
                    }
                    .frame(width: 150, height: 50)
                    .background(Color(.white))
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .cornerRadius(10)
                    
                    Button ("Mic off") {
                        // Turning off the speech recognition
                        speechRecognizer.stopTranscribing()
                        // Processing the output
                        output = speechRecognizer.transcript
                        // converting string using dictionary
                        if(game.correctAnswer < 9 ) {
                            number = numberMap[output.lowercased()] ?? 0
                        } else {
                            number = Int(output) ?? 0
                        }
                        print("output we got \(output). Type of output \(type(of: output))")
                        let result = game.checkAnswer(answer: number)
                        if( result == .right) {
                            print("Correct")
                            game = NumberGameWithSpeech()

                        } else {
                            print("Wrong")
                        }

                    }
                    .frame(width: 150, height: 50)
                    .background(Color(.white))
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .cornerRadius(10)
                }
                .padding()
                Button{
                    game = NumberGameWithSpeech()
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
}

struct NumberGameViewWithSpeech_Previews: PreviewProvider {
    static var previews: some View {
        NumberGameViewWithSpeech()
    }
}
