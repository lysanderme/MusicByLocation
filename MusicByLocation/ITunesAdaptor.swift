//
//  ITunesAdaptor.swift
//  MusicByLocation
//
//  Created by Lysander Myrddin-Evans on 07/03/2023.
//

import Foundation

class ITunesAdaptor {
    let baseUrl = "https://itunes.apple.com"
    
    func getArtists(target: String, completion: @escaping ([Artist]?) -> Void) {
        guard let url = URL(string: self.baseUrl + ("/search?term=\(target)&entity=musicArtist".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? baseUrl + "/search?term=London&entity=musicArtist"))
        else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let response = self.parseJson(json: data) {
                    completion(response.results)
                } else {
                    completion(nil)
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
