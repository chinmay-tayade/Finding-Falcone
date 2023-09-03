//
//  EncryptedSharedPreferences.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation
import Security

public class EncryptedPreferences {
    public static func savePreference(data: String, forKey keyName: String) -> OSStatus {
        if let keyData = data.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: keyName,
                kSecValueData as String: keyData
            ]
            return SecItemAdd(query as CFDictionary, nil)
        } else {
            return errSecInvalidData
        }
    }
    
    public static func getPreference(forKey keyName: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyName,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue!
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if status == errSecSuccess,
           let data = result as? Data,
           let dataString = String(data: data, encoding: .utf8) {
            return dataString
        } else {
            return nil
        }
    }
    
    public static func deletePreference(forKey keyName: String) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyName
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
}
