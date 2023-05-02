//
//  LottieView.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 24.4.2023.
//

import SwiftUI
import Lottie
import UIKit

// This view is created to display lottie animations in other views.
// Source : https://www.hackingwithswift.com/forums/swiftui/how-to-switch-animations-with-lottie-in-swiftui/1704
struct LottieView: UIViewRepresentable {
    // Initialising variables
    typealias UIViewType = UIView
     var fileName : String
    var loopMode: LottieLoopMode = .loop

    // Method for creating the lottie animation view
        func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
            let view = UIView()
            return view
        }
    
    // Method for updating varibales if there is any changes in relatable variables.
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
            uiView.subviews.forEach({ $0.removeFromSuperview() })
            let animationView = LottieAnimationView()
            animationView.translatesAutoresizingMaskIntoConstraints = false
            uiView.addSubview(animationView)

            NSLayoutConstraint.activate([
                animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
                animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
            ])

        animationView.animation = LottieAnimation.named(fileName)
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = loopMode
            animationView.play()
        }
}


