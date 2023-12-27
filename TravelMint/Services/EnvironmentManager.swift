//
//  EnvironmentManager.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import Foundation


struct EnvironmentManager {
    
    static func getTicketmasterAPIKey() -> String {
        guard let ticketmasterAPIKey = Bundle.main.object(forInfoDictionaryKey: Constants.Environment.TM_API_KEY) as? String else {
            fatalError("Ticketmaster API key not set in plist for this environment.")
        }
        
        return ticketmasterAPIKey
    }
}
