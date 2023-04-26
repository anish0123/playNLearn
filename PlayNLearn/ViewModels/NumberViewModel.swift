//
//  NumberViewModel.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 26.4.2023.
//

import Foundation

class apiCall {
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
}
