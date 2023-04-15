//
//  ContentView.swift
//  PlayNLearn
//
//  Created by Ritesh Ghimire on 3.4.2023.
//

import SwiftUI

struct ContentView: View {
    @State public var imageName: String = "numbers"
    @State public var titleName: String = "Number Game"
    var body: some View {
        NavigationView{
            ZStack {
                Image("homeimage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        VStack {
                            Text(titleName)
                                .font(.system(size: 30, weight: .bold))
                            
                            Image(imageName)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                        }
                    }
                    
                        VStack {
                            HStack {
                                ScrollViewList(title: "Number Game", titleName: $titleName, image: "numbers", imageName: $imageName)
                                ScrollViewList(title: "Color Game", titleName: $titleName, image: "colors", imageName: $imageName)
                            }
                            
                            HStack {
                                ScrollViewList(title: "Shape Game", titleName: $titleName, image: "Shapes", imageName: $imageName)
                                ScrollViewList(title: "Car Game", titleName: $titleName, image: "cargame", imageName: $imageName)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width , height: 420)
                        .cornerRadius(30)
                    
                    NavigationLink(destination: NumberGameView(randomNum: 2), label: {
                        Rectangle()
                            .fill(Color("lightGreen"))
                            .frame(width: 150, height: 50)
                            .cornerRadius(20)
                            .overlay{
                                Label("Let's play", systemImage: "play")
                                    .font(.system(size: 20))
                            }
                    } )
                    
                }
                .padding(30)
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
    @Binding var titleName: String
    var image: String
    @Binding var imageName: String
    
    var body: some View {
        
        Image(image)
            .resizable()
            .frame(width: 120, height: 120)
            .aspectRatio(contentMode: .fit)
            .clipShape(Rectangle())
            .padding()
            .opacity(0.9)
            .onTapGesture (count: 1) {
                self.imageName = image
                self.titleName = title
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imageName: "numbers")
    }
}

