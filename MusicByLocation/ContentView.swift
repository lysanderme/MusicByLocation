//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Lysander Myrddin-Evans on 01/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        VStack {
            Text(locationHandler.lastKnownLocation)
            Spacer()
            Button("Find Music", action: {
                locationHandler.requestLocation()
            })
        }.onAppear(perform: {
            locationHandler.requestAuthorisation()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
