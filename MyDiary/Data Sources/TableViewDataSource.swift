//
//  TableViewDataSource.swift
//  MyDiary
//
//  Created by curtis scott on 06/09/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TableViewDataSource:  NSObject, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCell = tableView.dequeueReusableCell(withIdentifier: EntryViewCell.identifier, for: indexPath) as! EntryViewCell
        
        let event = fetchedResultsController.object(at: indexPath)
        let date = event.createdOn
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d , MMMM"
        eventCell.dateLabel.text =  dateFormatter.string(from: date! as Date)
        eventCell.entryCommentLabel.text = event.comment
        if let location = event.location {
            eventCell.geoLocationTextLabel.text = location
            eventCell.geoLocationTextLabel.isHidden = false
        } else {
            eventCell.geoLocationImg.isHidden = true
            eventCell.geoLocationTextLabel.isHidden = true
        }
        return eventCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           self.context!.delete(fetchCrontroller().object(at: indexPath))
            
            do {
               try context!.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    private let tableView: UITableView
    private let fetchedResultsController: EventFetchedResultsController
    weak var context:NSManagedObjectContext?
    
    
   
    init(fetchRequest: NSFetchRequest<Event>, managedObjectContext context: NSManagedObjectContext, tableView: UITableView) {
        self.tableView = tableView
        self.fetchedResultsController = EventFetchedResultsController(request: fetchRequest, context: context)
        self.context = context
        super.init()
        self.fetchedResultsController.delegate = self
    }
    
    
  
    
    
    
}

extension TableViewDataSource: NSFetchedResultsControllerDelegate {
    
    func fetchCrontroller() -> EventFetchedResultsController {
        return self.fetchedResultsController
    }
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
