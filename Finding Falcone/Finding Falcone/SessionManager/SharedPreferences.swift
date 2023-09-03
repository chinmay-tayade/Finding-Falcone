//
//  UserKeyDefaults.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation

struct SharedPreferences {
    static let token = "token"
    static let vehicleData = "vehicleData"
    static let planetData = "planetData"
    
    
    
   public static func getToken() -> String? {
        if let data = EncryptedPreferences.getPreference(forKey: token) {
            return data
        }
        return nil
    }

   public static func saveToken(value: String) {
       //delete existing token
        EncryptedPreferences.deletePreference(forKey: token)
       
       //update token
        do {
            try EncryptedPreferences.savePreference(data: value, forKey: token)
        } catch {
            print(error)
        }
    }



}



