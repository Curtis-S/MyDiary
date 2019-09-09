//
//  FechtedResultControllers.swift
//  MyDiary
//
//  Created by curtis scott on 06/09/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import CoreData

class EventFetchedResultsController: NSFetchedResultsController<Event> {
    init(request: NSFetchRequest<Event>, context: NSManagedObjectContext) {
        super.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetch()
    }
    
    func fetch() {
        do {
            try performFetch()
        } catch {
            fatalError()
        }
    }
}


