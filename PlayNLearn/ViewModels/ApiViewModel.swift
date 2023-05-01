//
//  NumberViewModel.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 26.4.2023.
//


import Foundation
// This class is created for fetching the data for number game from api in JSON format
class apiCall {
    
    // Method to call the fetch request
    func getNumbersForVoice(completion:@escaping ([NumbersForVoice]) -> ()) {
        guard let url = URL(string: "https://users.metropolia.fi/~anishm/mad/Json/NumbersForVoice.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let numbersForVoice = try! JSONDecoder().decode([NumbersForVoice].self, from: data!)
            print(numbersForVoice)
            
            DispatchQueue.main.async {
                completion(numbersForVoice)
            }
        }
        .resume()
    }
    
    // Method to call the fetch request for getting shapes from the api
    func getShapes(completion:@escaping ([Shapes]) -> ()) {
        guard let url = URL(string: "https://users.metropolia.fi/~anishm/mad/Json/shapes.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let shapes = try! JSONDecoder().decode([Shapes].self, from: data!)
            print(shapes)
            
            DispatchQueue.main.async {
                completion(shapes)
            }
        }
        .resume()
    }
}
