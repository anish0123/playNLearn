//
//  ColorGameModeWithSpeech.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 21.4.2023.
//

import SwiftUI
import ConfettiSwiftUI
import SPConfetti
// This struct is created as view for color game that can played using speech to text feature
struct ColorGameModeWithSpeech: View {
    // Initialising variables that are needed to run this view.
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var score: Int = 0
    @State private var timeRemaining : Double = 30
    @State private var output = ""
    @State private var showPopUp: Bool = false
    @State private var rightAnswer: Bool = false
    @State private var colorId = ColorGame.allColor[Int.random(in: 0...ColorGame.allColor.count - 1)]
    @State private var isRecording = false
    
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
                        
                        Text(" ")
                            .font(.system(size: 80, weight: .bold))
                            .frame(width: 150,height: 150)
                            .padding()
                            .background(colorId.color)
                            .clipShape(Circle())
                        
                    }
                    .frame(width: 200)
                    .opacity(0.8)
                    .padding(70)
                    .onAppear {
                        startTimer()
                    }
                    Spacer()
                    Text("\(output)")
                }
                Spacer()
                Divider()
                
                HStack {
                    Button (action : {
                        
                        print("Long gesture ended")
                        stopRecording()
                    }) {
                        ZStack {
                            (isRecording ?  AnyView(LottieView(fileName: "mic yellow")
                                .frame(height: 150)
                                .foregroundColor(.orange)
                                
                                .padding()
                            )
                             
                             :   AnyView (Image(systemName: "mic")
                                .frame(height: 150)
                                .foregroundColor(.orange)
                                .font(.system(size: 60))
                                .padding()
                             )
                             
                            )
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
                    checkAnswer()
                } label: {
                    Group {
                        Text("submitAnswer")
                            .frame(width: 150)
                        LottieView(fileName: "submit", loopMode: .loop)
                    }
                }
                .frame(width: 200, height: 50)
                .background(Color(.orange))
                .foregroundColor(.white)
                .font(.system(size: 25, weight: .bold, design: .default))
                .disabled(output == "")
                .opacity(output == "" ? 0.4 : 1)
                .cornerRadius(10)
                
                Button{
                    nextQuestion()
                } label: {
                    Text("skip")
                        .frame(width: 150)
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
        
    }
    
    // Method to start recording the input given by the user
    private func startRecording() {
        output = ""
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording.toggle()
    }
    
    // Method to stop recording the input given by the user and process it
    private func stopRecording() {
        // Turning off the speech recognition
        speechRecognizer.stopTranscribing()
        // Processing the output
        output = speechRecognizer.transcript
        // converting string using dictionary
        print("output: \(output) ")
        isRecording.toggle()
    }
    
    // Method to start the timer of the game so after 30 seconds the game is over if user doesnot answer
    // Source : https://marcgg.com/blog/2020/05/06/circular-progressbar-clock-swiftui/
    private func startTimer(){
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
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
    
    // Method for getting next question
    private func nextQuestion() {
        colorId = ColorGame.allColor[Int.random(in: 0...ColorGame.allColor.count - 1)]
        timeRemaining = 30
        output = ""
    }
    
    // Method for checking the answer given by the user
    private func checkAnswer() {
        if(colorId.name.stringValue() == output.lowercased()) {
            score += 10
            SPConfetti.startAnimating(.centerWidthToUp, particles: [.triangle, .arc], duration: 1)
            SoundManager.instance.playSound(sound: .win)
            withAnimation(.easeInOut) {
                showPopUp.toggle()
                rightAnswer.toggle()
            }
        } else {
            score = 0
            SoundManager.instance.playSound(sound: .lose)
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
                        nextQuestion()
                    }
            }
        }
        //call nextquestion function with a 1 second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            nextQuestion()
        }
    }
    
    
}

struct ColorGameModeWithSpeech_Previews: PreviewProvider {
    static var previews: some View {
        ColorGameModeWithSpeech()
    }
}
