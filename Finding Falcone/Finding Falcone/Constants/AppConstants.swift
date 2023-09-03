//
//  AppConstants.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation

public struct AppConstants{
    public static var serverURL = "https://findfalcone.geektrust.com"
}

enum Endpoint {
    static let planets = "/planets"
    static let vehicles = "/vehicles"
    static let token = "/token"
    static let find = "/find"
    
}


enum HttpMethod {
    static let GET = "GET"
    static let POST = "POST"
    static let PUT = "PUT"
    static let PATCH = "PATCH"
    static let DELETE = "DELETE"
}
