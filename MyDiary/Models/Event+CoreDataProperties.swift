//
//  Event+CoreDataProperties.swift
//  MyDiary
//
//  Created by curtis scott on 06/09/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//
//

import Foundation
import CoreData
import CoreLocation


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        let request = NSFetchRequest<Event>(entityName: "Event")
        let sortderscripotpr = NSSortDescriptor(key: "createdOn", ascending: false)
        request.sortDescriptors = [sortderscripotpr]
        return request
        
    }

    @NSManaged public var editedOn: NSDate?
    @NSManaged public var createdOn: NSDate?
    @NSManaged public var comment: String
    @NSManaged public var location: String?
    @NSManaged public var photo: Photo?

    
    
    @nonobjc class func with (caption:String, location:CLPlacemark? ,in context: NSManagedObjectContext) -> Event {
        let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as! Event
        event.comment = caption
        event.createdOn = Date() as NSDate
        if let placemark = location {
            
            
            event.location = "\(placemark.name!) , \(placemark.country!) -\(placemark.locality!)"
        }else {
            event.location = nil
            
        }
        event.photo = nil
        
        return event
        
        
    }
    
    
    
}
