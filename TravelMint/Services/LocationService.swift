//
//  LocationService.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import CoreLocation
import Foundation
import MapKit

class LocationService: NSObject {
    
    private var addresses: [AddressResult] = []
    
    private lazy var searchCompleter: MKLocalSearchCompleter = {
        let searchCompleter = MKLocalSearchCompleter()
        searchCompleter.resultTypes = .address
        searchCompleter.delegate = self
        return searchCompleter
    }()
    
    private func getCoordinates(for address: AddressResult) async throws -> CLLocationCoordinate2D {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = DataFormatter.formatAddressResult(address)
        searchRequest.resultTypes = .address
        
        let search = MKLocalSearch(request: searchRequest)
        
        let searchResponse = try await search.start()
        
        guard let mapItem = searchResponse.mapItems.first else { return CLLocationCoordinate2D() }
        
        return mapItem.placemark.coordinate
    }
    
}

// MARK: MKLocalSearchCompleterDelegate Methods

extension LocationService: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.addresses = completer.results.map { AddressResult(title: $0.title, subtitle: $0.subtitle) }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
    
}
