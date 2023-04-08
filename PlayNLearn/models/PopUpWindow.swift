//
//  PopUpWindow.swift
//  PlayNLearn
//
//  Created by iosdev on 6.4.2023.
//

import SwiftUI
import SPConfetti

struct PopUpWindow: View {
    var title: String
    var message: String
    var buttonText: String
    @Binding var show: Bool
    @Binding var answer: Bool
    
    
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.9 : 0).edgesIgnoringSafeArea(.all)
                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(answer ? Color(#colorLiteral(red: 0.1098039216, green: 0.6196078431, blue: 0.2509803922, alpha: 1)) :
                                        Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))

                    GifImage(answer ? "congratulation" : "sadface")
                        .frame(height: 380)
                    
                    Button(action: {
                        // Dismiss the PopUp
                        SPConfetti.stopAnimating()
                        withAnimation(.linear) {
                            show = false
                            answer = false
                        }
                    }, label: {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(answer ? Color(#colorLiteral(red: 0.1098039216, green: 0.6196078431, blue: 0.2509803922, alpha: 1)) :
                                            Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                            .font(Font.system(size: 23, weight: .semibold))
                    }).buttonStyle(PlainButtonStyle())
                }
                .frame(width: UIScreen.main.bounds.width)
                .border(Color.white, width: 2)
                .background(answer ? .green : Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
            }
        }
    }
}

struct PopUpWindow_Previews: PreviewProvider {
    static var previews: some View {
        PopUpWindow(title: "Incorrect Answer", message: "", buttonText: "Retry", show: .constant(true), answer: .constant(false))
    }
}
