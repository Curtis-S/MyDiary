//
//  MasterViewController.swift
//  MyDiary
//
//  Created by curtis scott on 01/09/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {


    var detailViewController: DetailViewController? = nil
  
    let locationManager = LocationManager()
    
    
    let context = CoreDataStack().managedObjectContext
    
    lazy var dataSource: TableViewDataSource = {
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        return TableViewDataSource(fetchRequest: request, managedObjectContext: self.context, tableView: self.tableView)
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        splitViewController!.preferredDisplayMode = UISplitViewController.DisplayMode.allVisible
        self.tableView.rowHeight = 128
        tableView.tableFooterView = UIView()
       
       
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.tableView.dataSource = dataSource
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    

 

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let event = dataSource.fetchCrontroller().object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
               controller.detailItem = event
                controller.context = self.context
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "addEntry" {
           
                
                let controller = segue.destination as! AddEntryController
                
                controller.context = self.context
            
        }
        
        
        
    }

    func requestLocation (){
        do{
            try locationManager.requestLocationAuthorization()
        } catch LocationError.disallowedByUser {
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

   

}

