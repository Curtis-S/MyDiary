//
//  GeoLocationController.swift
//  MyDiary
//
//  Created by curtis scott on 06/09/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit
import MapKit

class GeoLocationController: UIViewController {
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let clGeocoderManger = CLGeocoder()
    
    weak var addEntryController:AddEntryController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomMapintoLocation(lat: 37.33233141, Long: -122.0312186)
        self.mapView.showsUserLocation = true
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func addLocationToEntry(_ sender: Any) {
        
        if let controller = self.addEntryController {
       
            if let location = controller.locationManager.locationcood {
                
                
                clGeocoderManger.reverseGeocodeLocation(location){  placmarks ,error in
                    
                    if let place = placmarks {
                     
                        controller.locationPlacemark = place.first
            
                        print(" got placemarrk")
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        
                        print(error?.localizedDescription)
                    }
                    
                }
            }
           
            
            
//            if location == nil {
//                //  note -add error
//                print(location)
//                displayAlert(text: "Location Error", message: "cannot get location please check connection")
//            } else {
//                controller.locationPlacemark = location
//                dismiss(animated: true, completion: nil)
//            }
            
            
        }
        
    }
    

}

extension GeoLocationController {
    
    
    //helper
    
    func displayAlert(text:String,message:String){
        
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        let action  = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
        
        
    }
    
    
    func zoomMapintoLocation(lat:Double,Long:Double){
        let coord2d = CLLocationCoordinate2D(latitude: lat, longitude: Long)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let USRegion = MKCoordinateRegion(center: coord2d, span: span)
        
        self.mapView.setRegion(USRegion, animated: true)
        
        
    }
    
}
