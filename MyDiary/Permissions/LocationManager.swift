//
//  LocationManager.swift
//  MyDiary
//
//  Created by curtis scott on 06/09/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationError:Error {
    case unnkownError
    case disallowedByUser
    case UnableToFindLocation
    
}

class LocationManager : NSObject {
   let manager = CLLocationManager()
    let clGeocoderManger = CLGeocoder()
    var locationcood :CLLocation?
    var locationPlace:CLPlacemark?
    
    
    override init() {
        super.init()
        
    }
    
    func requestLocationAuthorization() throws {
        let authurisationStatus = CLLocationManager.authorizationStatus()
        
        if authurisationStatus == .restricted || authurisationStatus == .denied {
            throw LocationError.disallowedByUser
        } else if authurisationStatus == .notDetermined {
            
            manager.requestWhenInUseAuthorization()
        } else {
            return
            
        }
        
        
    }
    
    func requestLocationAuthorizationAgain() throws {
        manager.requestWhenInUseAuthorization()
        let authurisationStatus = CLLocationManager.authorizationStatus()
        if authurisationStatus == .restricted || authurisationStatus == .denied {
            
            throw LocationError.disallowedByUser
        } else if authurisationStatus == .notDetermined {
            
            manager.requestWhenInUseAuthorization()
        } else {
            return
            
        }
        
        
    }
    
    func requestLocation(){
        manager.requestLocation()
    }
    
    
 
  
    }

    
    






