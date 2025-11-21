//
//  CarbonFootprintStore.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 02/27/25.
//

import Foundation
import Observation

@MainActor
@Observable
final class CarbonFootprintStore {
    static let shared = CarbonFootprintStore()
    private init() {}

    // Latest computed footprint in tCO2e
    var latestFootprint: Double = 0
}
