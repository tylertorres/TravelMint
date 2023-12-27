//
//  SearchViewModel.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    
    private let locationService: LocationService
    private let ticketmasterService: TicketmasterService
    
    init(locationService: LocationService = LocationService(),
         ticketmasterService: TicketmasterService = TicketmasterService.shared) {
        self.locationService = locationService
        self.ticketmasterService = ticketmasterService
        configureTMService()
    }
    
    private func configureTMService() {
        let configuration = Configuration(apiKey: EnvironmentManager.getTicketmasterAPIKey())
        self.ticketmasterService.configure(configuration: configuration)
    }
}
