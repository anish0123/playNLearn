//
//  ContentView.swift
//  PlayNLearn
//
//  Created by Ritesh Ghimire on 3.4.2023.
//

import SwiftUI

struct ContentView: View {
    @State public var imageName: String = "numbers"
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
                    
                    Image(imageName)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                    
                    Divider()
                    Spacer()
                    ScrollView(showsIndicators: false) {
                        ScrollViewList(title: "Number Game", description: "Select the correct number", image: "numbers", color: "button", imageName: $imageName)
                        ScrollViewList(title: "Color Game", description: "Guess the color", image: "colors", color: "orange", imageName: $imageName)
                        ScrollViewList(title: "Shape Game", description: "Learn about shapes", image: "Shapes", color: "blue", imageName: $imageName)
                        ScrollViewList(title: "Car Game", description: "Play car game", image: "cargame", color: "lightGreen", imageName: $imageName)
                    }
                    .frame(width: UIScreen.main.bounds.width , height: 410)
                    .background(Color("lightwhite"))
                    .cornerRadius(30)
                }
            }
                .toolbar {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.black)
                    }
                }
            }
        }
}

struct ScrollViewList: View {
    var title: String
    var description: String
    var image: String
    var color : String
    @Binding var imageName: String
    
    var body: some View {
        
        VStack(spacing: 20) {
            Rectangle()
                .fill(Color(color))
                .frame(width: UIScreen.main.bounds.width - 40, height: 150)
                .cornerRadius(30)
                .overlay{
                    HStack{
                        VStack(alignment: .leading, spacing: 5){
                            Text(title)
                                .frame(width: 210, height: 30, alignment: .leading)
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold, design: .default))
                            
                            Text(description)
                                .frame(width: 210, height: 30, alignment: .leading)
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular, design: .default))
                            
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: 110, height: 50)
                                .cornerRadius(20)
                                .overlay{
                                    HStack{
                                        NavigationLink(destination: NumberGameView(randomNum: 1)){
                                            Label("", systemImage: "play.circle")
                                                .font(.system(size: 25))
                                            
                                            Text("Play")
                                                .foregroundColor(.black)
                                                .font(.system(size: 20, weight: .bold, design: .default))
                                                .cornerRadius(20)
                                        }
                                    }
                                    
                                }
                        }
                        
                        Spacer()
                        
                        Image(image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    }
                    .padding()
                    
                }
        }
        .padding(.top, 20)
        .onTapGesture (count: 1) {
            self.imageName = image
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imageName: "numbers")
    }
}

