//
//  AddEntryController.swift
//  MyDiary
//
//  Created by curtis scott on 06/09/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit
import CoreData

import CoreLocation

class AddEntryController: UIViewController {
    
    @IBOutlet weak var locationTextLabel: UILabel!
    var locationPlacemark :CLPlacemark? { willSet(placemark) {
            locationInfoStack.isHidden = false
        if let placemark = placemark {
            locationTextLabel.text = "\(placemark.name!) , \(placemark.country!) -\(placemark.locality!)"
        }
        }
        
    }
    
    var context: NSManagedObjectContext?

    let locationManager = LocationManager()
    
    @IBOutlet weak var locationInfoStack: UIStackView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEntry))
        self.navigationItem.rightBarButtonItem = saveButton
        
        locationInfoStack.isHidden = true
        
    }
    
    
    
    @objc func saveEntry(){
        guard let text = inputTextView.text , let context = context else {
            displayAlert(text: "No text in textbox", message: "please enter entry text")
            return
        }
        
        let _ = Event.with(caption: text, location: locationPlacemark, in: context)
        
        context.saveChanges()
        print("saved entry")
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func addLocation(_ sender: Any) {
        if requestLocation() {
            locationManager.requestLocation()
            let MapVC = self.storyboard!.instantiateViewController(withIdentifier: "MapVC") as! GeoLocationController
            
            MapVC.addEntryController = self
            
            self.present(MapVC, animated: true, completion: nil)
            
        } else  {
            displayAlert(text: "Cannot Add Location", message: "you have to allow location  permissions to add a location to a entry please allow in settings. ")
            
        }
        
    }
    
    
    //helper
    
    func displayAlert(text:String,message:String){
        
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        let action  = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
        
        
    }
    
    
    func requestLocation () -> Bool{
        do{
            try locationManager.requestLocationAuthorization()
        } catch LocationError.disallowedByUser {
            return false
        } catch let error {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
