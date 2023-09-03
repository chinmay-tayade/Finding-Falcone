//
//  AppUtils.swift
//  Finding Falcone
//
//  Created by chinmay on 02/09/23.
//

import Foundation
import UIKit

public class AppUtils {
    
    public func getUserAgent() -> String {
        let deviceModel = UIDevice.current.model
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion

        return "\(deviceModel) \(systemName) \(systemVersion)"
    }
}
