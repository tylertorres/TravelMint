//
//  SearchViewModel.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//
import Combine
import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var locationTextInput = ""
    @Published var suggestedAddresses: [AddressResult] = []
    @Published var selectedAddress: AddressResult?
    
    @Published var isTextFieldFocused: SearchFocusable?
    
    private let locationService: LocationService
    private let ticketmasterService: TicketmasterService
    
    private var cancellable: AnyCancellable?
    
    init(locationService: LocationService = LocationService(),
         ticketmasterService: TicketmasterService = TicketmasterService.shared) {
        self.locationService = locationService
        self.ticketmasterService = ticketmasterService
        
        setupLocationTextInput()
        setupLocationServiceUpdates()
        setupLocationServiceError()
    }
    
    func toggleTextFieldFocus() {
        self.isTextFieldFocused = nil
    }
    
    func onAddressResultTapped(_ address: AddressResult) {
        toggleTextFieldFocus()
        self.selectedAddress = address
        self.locationTextInput = address.toFullAddress()
        self.suggestedAddresses = []
    }
    
    private func setupLocationTextInput() {
        cancellable = $locationTextInput
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] textValue in
                guard let self else { return }
                
                if !textValue.isEmpty && selectedAddress == nil {
                    self.locationService.search(with: textValue)
                } else {
                    self.suggestedAddresses = []
                }
            }
    }
    
    private func setupLocationServiceUpdates() {
        locationService.onResultsUpdated = { [weak self] addresses in
            self?.suggestedAddresses = addresses
        }
    }
    
    private func setupLocationServiceError() {
        locationService.onError = { error in
            print(error)
        }
    }
    
    private func configureTMService() {
        let configuration = Configuration(apiKey: EnvironmentManager.getTicketmasterAPIKey())
        self.ticketmasterService.configure(configuration: configuration)
    }
}
