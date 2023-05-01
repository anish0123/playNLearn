//
//  ContentView.swift
//  PlayNLearn
//
//  Created by Ritesh Ghimire on 3.4.2023.

import SwiftUI

struct ContentView: View {
    @State public var imageName: String = "numbers"
    @State public var titleName: LocalizedStringKey = "numberGame"
    @Environment(\.managedObjectContext) private var moc
        @FetchRequest(entity: SwitchObject.entity(), sortDescriptors: []) private var objects: FetchedResults<SwitchObject>
    var voiceMode: Bool {
        return objects.first?.switchState ?? false
    }
    @State private var showNumberGame = false
    @State private var showShapeGame = false
    @State private var selectedDestination: Destination?
    
    var body: some View {
        NavigationView{
            ZStack {
                AsyncImage(url: URL(string: "https://users.metropolia.fi/~anishm/mad/BackgroundImages/homeimage.jpg")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        VStack {
                            Text(titleName)
                                .font(.system(size: 30, weight: .bold))
                            
                            LottieView(fileName: imageName)
                                
                                .frame(width: 200, height: 200)
                                .background(Color.white)
                                .clipShape(Circle())

                        }
                    }
                    
                    VStack {
                        HStack {
                            ScrollViewList(title: "numberGame", titleName: $titleName, image: "numbers", imageName: $imageName)
                            ScrollViewList(title: "colorGame", titleName: $titleName, image: "colors", imageName: $imageName)
                        }
                        
                        HStack {
                            ScrollViewList(title: "shapeGame", titleName: $titleName, image: "shapes", imageName: $imageName)
                            ScrollViewList(title: "Car Game", titleName: $titleName, image: "cargame", imageName: $imageName)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width , height: 420)
                    .cornerRadius(30)

                    NavigationLink(destination: switchGame(), label: {
                        Rectangle()
                            .fill(Color("lightGreen"))
                            .frame(width: 230, height: 60)
                            .cornerRadius(20)
                            .overlay{
                                HStack{
                                   Text("Let's Play")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color.black)
                                        .padding([.leading],20)
                                    LottieView(fileName: "playButton")
                                }
                                
                            }
                    })
                    .padding([.bottom], 40)
                }
                .toolbar {
                    HStack{
                        NavigationLink(destination: SettingsView()){
                            Label("", systemImage: "line.horizontal.3")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                            
                        }
                    }
                }
            }
        }
    }
    
    func switchGame () -> some View {
        var game: Destination?
        if titleName ==  "numberGame" {
            if voiceMode == true {
                game = .numberGameVoiceMode
            } else {
                game = .numberGame
            }
           
        } else if titleName == "shapeGame" {
            if voiceMode == true {
                game = .shapeGameVoiceMode
            } else {
                game = .shapeGame
            }
            
            
        }else if  titleName == "colorGame" {
            if voiceMode == true {
                game = .colorGameVoiceMode
            } else {
                game = .colorGame
            }
           
        }
        
        
        return game?.getView()
    }
}

struct ScrollViewList: View {
    var title: LocalizedStringKey
    @Binding var titleName: LocalizedStringKey
    var image: String
    @Binding var imageName: String
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 120, height: 120)
            .aspectRatio(contentMode: .fit)
            .clipShape(Rectangle())
            .border(Color.black, width: 2)
            .padding()
            .opacity(0.9)
            .onTapGesture (count: 1) {
                self.imageName = image
                self.titleName = title
            }
    }
}

//open the specific game selected by the user
enum Destination {
    case numberGame
    case numberGameVoiceMode
    case shapeGame
    case colorGame
    case colorGameVoiceMode
    case shapeGameVoiceMode
    
    func getView() -> AnyView {
        switch self {
        case .numberGame:
            return AnyView(NumberGameView(randomNum: 1))
        case .numberGameVoiceMode:
            return AnyView(NumberGameViewWithSpeech())
        case .shapeGame:
            return AnyView(ShapeGameView(randomNum: 1))
        case .colorGame:
            return AnyView(ColorGameTouchModeView())
        case .colorGameVoiceMode:
            return AnyView(ColorGameModeWithSpeech())
        case .shapeGameVoiceMode:
            return AnyView(ShapeGameModeWithSpeech())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imageName: "numbers")
    }
}

