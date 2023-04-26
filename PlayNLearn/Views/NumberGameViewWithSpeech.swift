
//  NumberGameViewWithSpeech.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 5.4.2023.

import SwiftUI
import ConfettiSwiftUI
import SPConfetti

// This struct is created as view for number game that can played using speech to text feature
struct NumberGameViewWithSpeech: View {
    // Initialising vairbales needed for the view
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var output = ""
    @State private var number: Int = 0
    // @State private var choosenNumber = NumbersForVoice.numbers[Int.random(in: 0...NumbersForVoice.numbers.count - 1)]
    @State var numbersForVoice = [NumbersForVoice]()
    @State var choosenNumber: NumbersForVoice
    @State public var timeRemaining = 30.0
    @State private var score  = 0
    @State private var showPopUp: Bool = false
    @State private var rightAnswer: Bool = false
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
                        
                        Text("\(choosenNumber.number)")
                            .font(.system(size: 80, weight: .bold))
                            .frame(width: 150,height: 150)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                        
                    }
                    .frame(width: 200)
                    .opacity(0.8)
                    .padding(70)
                    .onAppear {
                        startTimer()
                    }
                    Spacer()
                        Text(output)
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
        .onAppear() {
            apiCall().getNumbersForVoice { (numbersForVoice) in
                self.numbersForVoice = numbersForVoice
                choosenNumber = numbersForVoice[Int.random(in: 0...numbersForVoice.count - 1)]
                
            }
        }
    }
    
    // Method to start recording the input given by the user
    func startRecording() {
        //reseting the transcript of speech recognizer
        speechRecognizer.resetTranscript()
        // Starting the speech recognizer
        speechRecognizer.startTranscribing()
        isRecording.toggle()
    }
    
    // Method to stop recording the input given by the user and process it
    func stopRecording() {
        // Turning off the speech recognition
        speechRecognizer.stopTranscribing()
        // Processing the output
        output = speechRecognizer.transcript
        // converting string using dictionary
        print("output: \(output) ")
        if(choosenNumber.number <= 9 ) {
            // number = numberMap[output.lowercased()] ?? 0
            print("choosenNumber: ", choosenNumber.localizedDescription.stringValue())
                if(output.lowercased() == choosenNumber.localizedDescription.stringValue()) {
                    number = choosenNumber.number
                }
        } else {
            number = Int(output) ?? 0
        }
        print("output we got \(number). Type of output \(type(of: output))")
        isRecording.toggle()
    }
    
    // Method to start the timer of the game so after 30 seconds the game is over if user doesnot answer
    private func startTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1.0
            } else {
                score = 0
                withAnimation(.easeInOut) {
                    showPopUp.toggle()
                }
                choosenNumber = numbersForVoice[Int.random(in: 0...numbersForVoice.count - 1)]
                timeRemaining = 30
                
            }
            
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    // Method for getting next question
    private func nextQuestion() {
        choosenNumber = numbersForVoice[Int.random(in: 0...numbersForVoice.count - 1)]
        timeRemaining = 30
        output = ""
    }
    
    // Method for checking the answer given by the user
    private func checkAnswer() {
        if( number == choosenNumber.number) {
            print("Correct")
            score += 10
            SPConfetti.startAnimating(.centerWidthToUp, particles: [.triangle, .arc], duration: 1)
            SoundManager.instance.playSound(sound: .win)
            withAnimation(.easeInOut) {
                showPopUp.toggle()
                rightAnswer.toggle()
            }
            
        } else {
            score = 0
            output = ""
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

struct NumberGameViewWithSpeech_Previews: PreviewProvider {
    static var previews: some View {
        NumberGameViewWithSpeech(choosenNumber: NumbersForVoice(number: 1, writtenNumber: "one"))
    }
}
