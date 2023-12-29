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
    
    var onResultsUpdated: (([AddressResult]) -> Void)?
    var onError: ((Error) -> Void)?
    
    private lazy var searchCompleter: MKLocalSearchCompleter = {
        let searchCompleter = MKLocalSearchCompleter()
        searchCompleter.resultTypes = .address
        searchCompleter.delegate = self
        return searchCompleter
    }()
    
    func search(with query: String) {
        searchCompleter.queryFragment = query
    }
    
    func getCoordinates(for address: AddressResult) async throws -> CLLocationCoordinate2D {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = address.toFullAddress()
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
        let addresses = completer.results.map { AddressResult(title: $0.title, subtitle: $0.subtitle) }
        onResultsUpdated?(addresses)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        onError?(error)
    }
}
