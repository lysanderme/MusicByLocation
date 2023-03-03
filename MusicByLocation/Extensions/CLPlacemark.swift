//
//  CLPlacemark.swift
//  MusicByLocation
//
//  Created by Lysander Myrddin-Evans on 03/03/2023.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    func getLocationBreakdown() -> String {
        return """
            Street: \(self.thoroughfare ?? "None")
            City: \(self.locality ?? "None")
            Area: \(self.administrativeArea ?? "None")
            Country: \(self.country ?? "None")
            """
    }
}
