//
//  LottieView.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 24.4.2023.
//

import SwiftUI
import Lottie
import UIKit

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    
     var fileName : String
    var loopMode: LottieLoopMode = .loop

        func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
            let view = UIView()
            return view
        }
    
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


