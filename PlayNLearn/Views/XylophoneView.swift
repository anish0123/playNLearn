//
//  XylophoneView.swift
//  PlayNLearn
//
//  Created by iosdev on 2.5.2023.
//

import SwiftUI

struct XylophoneView: View {
    var soundOption: [String] = ["C", "D", "E", "F", "G", "A", "B"]
    var widthOf = UIScreen.main.bounds.size.width - 15
    var body: some View {
        
        ZStack {
            Image("zebra")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Twinkle Twinkle little Star \n C  C  G  G  A  A  G \n F  F  E  E  D  D  C ")
                    .font(.system(size: 20))
                    .frame(width: UIScreen.main.bounds.size.width, height: 100)
                    .background(Color.brown)
                    .multilineTextAlignment(.center)
                    .opacity(0.9)
                
                ForEach (0..<soundOption.count, id: \.self) { i in
                    Text(soundOption[i])
                        .font(.system(size: 40, weight: .bold))
                        .frame(width: widthOf - CGFloat(i * 15), height: 90)
                        .background(Color(soundOption[i]))
                        .onTapGesture{
                            SoundManager.instance.playSound(sound: soundOption[i])
                        }
                        .opacity(0.9)
                }
            }
            
        }
    }
}

struct XylophoneView_Previews: PreviewProvider {
    static var previews: some View {
        XylophoneView()
    }
}
