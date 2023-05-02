//
//  HoplopUsingAPI.swift
//  PlayNLearn
//
//  Created by Ritesh Ghimire on 17.4.2023.
//

import SwiftUI
import MapKit

struct HoplopUsingAPI: View {
    @State private var data: [Location] = []
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384),
        span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 2.0)
    )

@State  var tapped = false
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: data) { location in
            MapAnnotation(
                
                coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                content: {
                    VStack {
                        if tapped {
                            Text(location.name).onTapGesture {
                                self.tapped.toggle()
                            }.font(.system(size: 12))
                            Text(location.address).onTapGesture {
                                self.tapped.toggle()
                            }
                                .font(.system(size: 12))
                        }
                        Circle()
                                .stroke(.red, lineWidth: 3)
                                .frame(width: 15, height: 10)
                                .onTapGesture {
                                    self.tapped.toggle()
                                }
                    }
                })
        }.onAppear(){loadData()}
    }

    

    func loadData() {
        guard let url = URL(string: "https://users.metropolia.fi/~riteshg/hoplop.json") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let locations = try JSONDecoder().decode([Location].self, from: data)
                    DispatchQueue.main.async {
                        self.data = locations
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct Location: Identifiable, Decodable {
    let id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
}


struct HoplopUsingAPI_Previews: PreviewProvider {
    static var previews: some View {
        HoplopUsingAPI()
    }
}
