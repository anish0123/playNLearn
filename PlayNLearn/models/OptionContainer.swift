//
//  OptionContainer.swift
//  PlayNLearn
//
//  Created by iosdev on 19.4.2023.
//

import SwiftUI

struct OptionContainer: View {
    let colorGame: ColorGame
    @ObservedObject var viewModel: ColorViewModel
    private let size: CGFloat = 100
    private let highlightedSize: CGFloat = 130
    
    var body: some View {
        ZStack{
            Circle()
                .fill(colorGame.color)
                .frame(width:size,height:size)
                .overlay {
                    GeometryReader{proxy -> Color in
                        viewModel.update(frame: proxy.frame(in: .global),for: colorGame.id
                        )
                        return Color.clear
                        
                        
                    }
                }
            if viewModel.isHighlightedId(id: colorGame.id){
                Circle()
                    .fill(colorGame.color)
                    .opacity(0.5)
                    .frame(width: highlightedSize, height: highlightedSize)
            }
        }
        .frame(width: highlightedSize,height: highlightedSize)
    }
}

struct OptionContainer_Previews: PreviewProvider {
    static var previews: some View {
        OptionContainer(
            colorGame: ColorGame.allColor.first!,viewModel: ColorViewModel())
    }
}
