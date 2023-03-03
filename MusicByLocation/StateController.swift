//
//  StateController.swift
//  MusicByLocation
//
//  Created by Lysander Myrddin-Evans on 03/03/2023.
//

import Foundation

class StateController: ObservableObject {
    var lastKnownLocation: String = "" {
        didSet {
            getArtists(target: lastKnownLocation)
        }
    }
    @Published var artistsInPlace: String = ""
    let locationHandler: LocationHandler = LocationHandler()
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func getArtists(target: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(target)&entity=musicArtist")
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let response = self.parseJson(json: data) {
                    let names = response.results.map {
                        return $0.name
                    }
                    
                    DispatchQueue.main.async {
                        self.artistsInPlace = names.joined(separator: ", ")
                    }
                }
            }
        }.resume()
    }
    
    func parseJson(json: Data) -> ArtistResponse? {
        let decoder = JSONDecoder()
        
        if let artistResponse = try? decoder.decode(ArtistResponse.self, from: json) {
            return artistResponse
        } else {
            print("Error decoding JSON")
            return nil
        }
    }
    
}
