//
//  TicketmasterService.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import Foundation
import TicketmasterFoundation
import TicketmasterDiscoveryAPI
import CoreLocation

class TicketmasterService {
    
    static let shared = TicketmasterService()

    var isConfigured: Bool {
        return configuration != nil
    }
    
    private var configuration: Configuration?
    
    private var discoveryService: DiscoveryService?
}

// MARK: Discovery Service API Calls
extension TicketmasterService {
    
    // Search For Events By Location
    func searchForEvents(_ location: CLCircularRegion, dateRange: (start: Date, end: Date)? = nil) {
        var criteria = DiscoveryEventSearchCriteria()
        criteria.location = location
                
        discoveryService?.eventSearch(criteria) { response in
            print(response)
            switch response {
            case .success(let results):
                print(results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Search For Events By Filter Text
    func searchForEvents(_ text: String) {}
}


// MARK: Discovery Service Setup
extension TicketmasterService {
    
    func configure(configuration: Configuration) async {
        guard !configuration.apiKey.isEmpty else {
            fatalError("TicketMaster api key must be set in order to use ; go to https://developer.ticketmaster.com")
        }
        
        print("Configuring Discovery API...")
        
        await withCheckedContinuation { continuation in
            TMDiscoveryAPI.shared.configure(apiKey: configuration.apiKey, region: configuration.region) { didConfigure in
                
                if !didConfigure {
                    TMDiscoveryAPI.shared.marketDomain = .US
                }
                
                self.discoveryService = TMDiscoveryAPI.shared.discoveryService
                self.configuration = configuration
                
                print("Discovery Service Configured")
                
                continuation.resume()
            }
        }
    }
}
