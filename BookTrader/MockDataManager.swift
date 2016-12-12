//
//  MockDataManager.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation

struct Credentials {
    
    static let kUsername = "kUsername"
    static let kPassword = "kPassword"
    
    var username : String = ""
    var password : String = ""
    var lastUpdated : Date?
}
class MockDataManager {
    
    static let sharedInstance = MockDataManager()
    
    var creds : Credentials = Credentials()
    
    init()
    {
        storeCredentials()
    }
    private func storeCredentials() {
        let def = UserDefaults.standard
        
        def.set("hackathon", forKey: Credentials.kPassword)
        def.set("forsythetony", forKey: Credentials.kUsername)
        
        def.synchronize()
    }
    func updateCredentialsFromStore() {
        
        let defaults = UserDefaults.standard
        
        if let username = defaults.string(forKey: Credentials.kUsername) {
            creds.username = username
        }
        
        if let pass = defaults.string(forKey: Credentials.kPassword) {
            creds.password = pass
        }
        
        creds.lastUpdated = Date()
    }
    
    
}
