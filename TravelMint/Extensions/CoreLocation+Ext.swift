//
//  CoreLocation+Ext.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/28/23.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    func toCircularRegion(_ radius: CLLocationDistance) -> CLCircularRegion {
        return CLCircularRegion(center: self, radius: .meters(fromMiles: radius), identifier: "")
    }
}

extension CLLocationDistance {
    static func meters(fromMiles miles: Double) -> CLLocationDistance {
        return miles * 1609.34
    }
}
