//
//  LocationManager.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol LocationManagerDelegate {
    func LocationManagerCanNowOperate( manager : LocationManager )
}

struct LocationReading {
    var coordinate : CLLocationCoordinate2D?
    var timestamp : Date?
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationManager()
    
    private let manager : CLLocationManager = CLLocationManager()
    
    var canOperate = false
    
    var userLocationInformation : LocationReading = LocationReading()
    
    var delegate : LocationManagerDelegate?
    
    override init() {
        super.init()
        manager.delegate = self
        checkUserAuthorization()
        
    }
    
    func beginLooking() {
        
        manager.requestLocation()
    }
    
    private func checkUserAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.canOperate = true
        }
        else {
            self.canOperate = false
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let loc = locations.first {
            
            self.userLocationInformation.coordinate = loc.coordinate
            self.userLocationInformation.timestamp = loc.timestamp
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find the users location \(error.localizedDescription)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.canOperate = true
            manager.startUpdatingLocation()
            self.delegate?.LocationManagerCanNowOperate(manager: self)
        }
        self.canOperate = false
    }
}
