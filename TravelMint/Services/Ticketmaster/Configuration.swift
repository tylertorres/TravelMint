//
//  Configuration.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import Foundation
import TicketmasterAuthentication

struct Configuration {
    let apiKey: String
    let region: TMAuthentication.TMXDeploymentRegion = .US
}
