//
//  NumberGameView.swift
//  PlayNLearn
//
//  Created by iosdev on 3.4.2023.
//

import SwiftUI

struct NumberGameView: View {
    @State var imageName: Int = 13
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
                
                Text("Select the correct number")
                    .font(.system(size: 25, weight: .semibold))
                
                Text("13")
                    .font(.system(size: 60, weight: .regular))
                    .frame(width: 180,height: 180)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                    .padding(.top, 20)
                
                Spacer()
                Divider()
                
                HStack {
                    Text("\(imageName)")
                        .font(.system(size: 30, weight: .regular))
                        .frame(width: 50,height: 50)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding()
                        .onTapGesture (count: 1) {
                        }
                    
                    Text("\(imageName + 5)")
                        .font(.system(size: 30, weight: .regular))
                        .frame(width: 50,height: 50)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding()
                        .onTapGesture (count: 1) {
                        }
                    
                    Text("\(imageName + 2)")
                        .font(.system(size: 30, weight: .regular))
                        .frame(width: 50,height: 50)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding()
                        .onTapGesture (count: 1) {
                        }
                }
                .padding()
                Button{
                    
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


struct NumberGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumberGameView()
    }
}

