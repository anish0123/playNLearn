//
//  ShapeGameModeWithSpeech.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 22.4.2023.
//

import SwiftUI
import ConfettiSwiftUI
import SPConfetti

struct ShapeGameModeWithSpeech: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var score: Int = 0
    @State private var timeRemaining : Double = 30
    @State private var output = ""
    @State private var showPopUp: Bool = false
    @State private var rightAnswer: Bool = false
    var shapes: [Shapes] = ShapeList.shapes
    @State private var randomNum = Int.random(in: 0...ShapeList.shapes.count - 1 )
    
    var body: some View {
        ZStack {
            Image("giraffeneck")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .padding(.leading, 150)
            
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
                .padding(.bottom,50)
                
                Spacer()
                
                Group {
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 20)
                            .opacity(0.3)
                            .foregroundColor(.white)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(1 - timeRemaining/30.0))
                            .stroke(style: StrokeStyle(lineWidth: 20.0))
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
                    .opacity(0.8)
                    .padding(70)
                    .onAppear {
                        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1.0
                            } else {
                                score = 0
                                withAnimation(.easeInOut) {
                                    showPopUp.toggle()
                                }
                                timeRemaining = 30
                                
                            }
                            
                        }
                        RunLoop.current.add(timer, forMode: .common)
                    }
                    Spacer()
                    Text("\(shapes[randomNum].answer)")
                }
                Spacer()
                Divider()
                
                HStack {
                    Button (action : {
                        
                        print("Long gesture ended")
                        stopRecording()
                    }) {
                        ZStack {
                            Image(systemName: "mic.circle")
                                .frame(height: 100)
                                .foregroundColor(.orange)
                                .font(.system(size: 100))
                                .padding()
                        }
                    }
                }
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.1).onEnded({_ in
                        startRecording()
                        print("Long gesture started")
                    })
                    
                )
                Button{
                    timeRemaining = 30
                    randomNum = Int.random(in: 0...ShapeList.shapes.count - 1 )
                } label: {
                    Text("Skip")
                        .frame(width: 150, height: 50)
                        .background(Color(.white))
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .cornerRadius(10)
                }
            }
            .padding(50)
            PopUpWindow(title: rightAnswer ? "Correct Answer" : "Incorrect Answer",
                        buttonText: rightAnswer ? "Continue" : "Retry",
                        show: $showPopUp, answer: $rightAnswer,
                        timeRemaining: $timeRemaining)
        }
        
    }
    
    private func startRecording() {
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
    }
    
    private func stopRecording() {
        // Turning off the speech recognition
        speechRecognizer.stopTranscribing()
        // Processing the output
        output = speechRecognizer.transcript
        // converting string using dictionary
        print("output: \(output) ")
        
        if(shapes[randomNum].answer == output.lowercased()) {
            score += 10
            SPConfetti.startAnimating(.centerWidthToUp, particles: [.triangle, .arc], duration: 1)
            withAnimation(.easeInOut) {
                showPopUp.toggle()
                rightAnswer.toggle()
            }
        } else {
            score = 0
            withAnimation(.easeInOut) {
                showPopUp.toggle()
                
                Rectangle()
                    .fill(Color("lightGreen"))
                    .frame(width: 110, height: 50)
                    .cornerRadius(20)
                    .overlay{
                        Label("Skip", systemImage: "forward")
                            .font(.system(size: 20))
                    }
                    .onTapGesture (count: 1) {
                        randomNum = Int.random(in: 0...ShapeList.shapes.count - 1 )
                    }
            }
        }
        
        //call nextquestion function with a 1 second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            timeRemaining = 30
            randomNum = Int.random(in: 0...ShapeList.shapes.count - 1 )
        }
    }
    
    
}

struct ShapeGameModeWithSpeech_Previews: PreviewProvider {
    static var previews: some View {
        ShapeGameModeWithSpeech()
    }
}
