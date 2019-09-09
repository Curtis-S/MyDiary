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
    private let manager = CLLocationManager()
    let clGeocoderManger = CLGeocoder()
    var locationcood :CLLocation?
    var locationPlace:CLPlacemark?
    
    var delegate: LocationManagerHelper?
    
    override init() {
        super.init()
        manager.delegate = self
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
    
    
    //
   func printlocation(){
    if let locaction = locationcood {
        print("\(locaction.coordinate.latitude) and \(locaction.coordinate.longitude)")
    }
    }
    
    func getdestination(location:CLLocation,completion: @escaping (CLPlacemark?)->()  ){
        clGeocoderManger.reverseGeocodeLocation(location){ placmarks ,error in
            if let place = placmarks {
                print("")
                self.locationPlace = place.first
                completion(place.first)
                print(" country is \(self.locationPlace?.country)   city is \(self.locationPlace?.locality)    name is \(self.locationPlace?.name)")
            }
            
            
            
        }
    }
    
    
    
}

extension LocationManager: CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
           
            
        }else {
          
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let error = error as? CLError else {
            return
        }
        print(error.localizedDescription)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("error")
            return
        }
         self.locationcood = location
        
        printlocation()
    }
}




