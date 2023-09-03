//  ApiModels.swift
//  Finding Falcone
//  Created by chinmay on 02/09/23

import Foundation

struct Planet: Codable {
    let name: String
    let distance: Int
}

typealias PlanetsResponse = [Planet]


struct Spacecraft: Codable {
    let name: String?
    let totalNo, maxDistance, speed: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case totalNo = "total_no"
        case maxDistance = "max_distance"
        case speed
    }
}

typealias SpacecraftsResponse = [Spacecraft]


struct TokenResponse :Decodable {
    let token: String
}

struct FindRequest: Codable {
    let token        : String
    let planetNames  :[String]
    let vehicleNames :[String]
    

    enum CodingKeys: String, CodingKey {
        case token
        case planetNames = "planet_names"
        case vehicleNames = "vehicle_names"
    }
}


struct FindResponse: Decodable {
    let planetName: String?
    let status: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case planetName = "planet_name"
        case status
        case error
    }
}
