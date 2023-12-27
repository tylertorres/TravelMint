//
//  TicketmasterService.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import Foundation
import TicketmasterFoundation
import TicketmasterDiscoveryAPI


class TicketmasterService {
    
    static let shared = TicketmasterService()

    private var configuration: Configuration?

    private(set) var discoveryService: DiscoveryService?
}


// MARK: Discovery Service Setup
extension TicketmasterService {
    
    func configure(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        guard !configuration.apiKey.isEmpty else {
            fatalError("TicketMaster api key must be set in order to use ; go to https://developer.ticketmaster.com")
        }
        
        print("Configuring Discovery API...")
        
        TMDiscoveryAPI.shared.configure(apiKey: configuration.apiKey, region: configuration.region) { didConfigure in
            
            if !didConfigure {
                TMDiscoveryAPI.shared.marketDomain = .US
            }
            
            self.discoveryService = TMDiscoveryAPI.shared.discoveryService
            
            print("Discovery Service Configured")
            
            completion(true)
        }
    }
}
