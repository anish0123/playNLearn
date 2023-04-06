//
//  ContentView.swift
//  PlayNLearn
//
//  Created by Ritesh Ghimire on 3.4.2023.
//

import SwiftUI

struct ContentView: View {
    @State var imageName: String = "numbers"
    var body: some View {
        NavigationView{
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]), startPoint: .topLeading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                    Text("Play N Learn")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                    Divider()
                    Spacer()
                    Image(imageName)
                        .resizable()
                        .frame(width: 380, height: 330)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(60)
                        .padding()
                    
                    Divider()
                    
                    HStack {
                        NavigationLink(destination: NumberGameView(randomNum: 1)) {
                            Image("numbers")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .padding()
                                .onTapGesture (count: 1) {
                                    imageName = "numbers"
                                }
                        }
                        
                        Image("colors")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .padding()
                            .onTapGesture (count: 1) {
                                imageName = "colors"
                            }
                    }
                    
                    HStack {
                        Image("Shapes")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .padding()
                            .onTapGesture (count: 1) {
                                imageName = "Shapes"
                            }
                        Image("cargame")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .padding()
                            .onTapGesture (count: 1) {
                                imageName = "cargame"
                            }
                    }
                    
                    Button{
                        
                    } label: {
                        Text("Let's Play")
                            .frame(width: 280, height: 50)
                            .background(Color("woodencolor"))
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(10)
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imageName: "numbers")
    }
}

