//
//  ShapeGameView.swift
//  PlayNLearn
//
//  Created by iosdev on 15.4.2023.
//

import SwiftUI

struct ShapeGameView: View {
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
                        
                        Circle()
                            .fill(.white)
                        
                        Rectangle()
                            .stroke(lineWidth: 10)
                            .frame(width: 50, height: 80)
                        
                        
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
                    .frame(width: 380, height: 200)
                    .cornerRadius(30)
                    .overlay{
                        HStack {
                            Rectangle()
                                .stroke(lineWidth: 5)
                                .frame(width: 40, height: 60)
                                .padding(25)
                                .background(Color("lightGreen"))
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color("optionstroke"), lineWidth: 4)
                                )
                                .padding()
                            
                            Circle()
                                .stroke(lineWidth: 5)
                                .frame(width: 40, height: 40)
                                .padding(25)
                                .background(Color("lightGreen"))
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color("optionstroke"), lineWidth: 4)
                                )
                                .padding()
                            
                            Rectangle()
                                .stroke(lineWidth: 5)
                                .frame(width: 40, height: 40)
                                .padding(25)
                                .background(Color("lightGreen"))
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color("optionstroke"), lineWidth: 4)
                                )
                                .padding()
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
                    }
            }
            .padding(80)
            
        }
    }
    
    func startTimer(){
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timeRemaining = 30
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
}

struct ShapeGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeGameView()
    }
}
