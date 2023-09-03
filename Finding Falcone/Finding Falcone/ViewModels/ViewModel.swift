//
//  ViewModel.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation

class SelectPlanetViewModel: ObservableObject {
    @Published var successMessage: String = ""
    @Published var timeTaken: String = ""
    @Published var planetFound: String = ""
    @Published var status: String = ""
}


class OnboardingViewModel: ObservableObject {
    @Published var spacecraftResponse = SpacecraftsResponse()
    @Published var planetResponse = PlanetsResponse()
    @Published var vehicleList = [String]()
    @Published var planetList = [String]()
}
