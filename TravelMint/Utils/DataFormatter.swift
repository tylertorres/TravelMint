//
//  DataFormatter.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import Foundation


struct DataFormatter {
    
    static func formatAddressResult(_ address: AddressResult) -> String {
        return "\(address.title) \(address.subtitle)"
    }
}
