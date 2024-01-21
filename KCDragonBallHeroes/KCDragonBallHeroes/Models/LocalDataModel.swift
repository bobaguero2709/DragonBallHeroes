//
//  LocalDataModel.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/20/24.
//

import Foundation

struct LocalDataModel {
    private enum Constants {
        static let tokenKey = "KCToken"
    }
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        return userDefaults.string(forKey: Constants.tokenKey)
    }
    
    static func save(token: String){
        userDefaults.setValue(token, forKey: Constants.tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: Constants.tokenKey)
    }
}
