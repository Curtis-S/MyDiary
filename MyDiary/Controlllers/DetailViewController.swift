//
//  DetailViewController.swift
//  MyDiary
//
//  Created by curtis scott on 01/09/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController {
    
    enum EditMode {
        case enabled, disabled
    }

    @IBOutlet weak var editedDateLabel: UILabel!
    @IBOutlet weak var lastEditedOnLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var commentTextField: UITextView!
    @IBOutlet weak var geoLocationInfoLabel: UILabel!
    @IBOutlet weak var entryPictureView: UIImageView!
    
    @IBOutlet weak var cancelEditingButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    var masterController: MasterViewController?
    var context: NSManagedObjectContext?
    
    func configureView() {
       
        // Update the user interface for the detail item.
        if let detail = detailItem {
             let dateFormatter = DateFormatter()
            if let editedDate = detail.editedOn {
                lastEditedOnLabel.isHidden = false
                editedDateLabel.isHidden = false
                 dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
                editedDateLabel.text = dateFormatter.string(from: editedDate as Date)
                
            }
            commentTextField.text = detail.comment
            
            if let loacation = detail.location{
                geoLocationInfoLabel.text = loacation
                
            } else {
                 geoLocationInfoLabel.text = "no location saved"
            }
            
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy HH:mm:ss"
           
            dateLabel.text = dateFormatter.string(from: detail.createdOn! as Date)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lastEditedOnLabel.isHidden = true
        editedDateLabel.isHidden = true
        
        SaveButton.isHidden = true
        cancelEditingButton.isHidden = true
        
        
        configureView()
    }

    
    var detailItem: Event? {
        didSet {
            // Update the view.
       
        }
    }
    
    func changeEntryText(to comment:String){
        guard let entry = detailItem else {
            return
        }
        entry.comment = comment
        entry.editedOn = Date() as NSDate
        context!.saveChanges()
    }
    
    @IBAction func dissssmisss(_ sender: Any) {
        self.masterController?.navigationController?.popToRootViewController(animated:true)
         print("pop")
        self.masterController?.navigationController?.popViewController(animated: true)
        print("pop")
        dismiss(animated: true, completion: nil)
        print("dismiss")
    }
    
    @IBAction func activateEditMode(_ sender: Any) {
        changeEditMode(to: .enabled)
    }
    @IBAction func save(_ sender: Any) {
        changeEntryText(to:commentTextField.text!)
        print("chanegd")
        configureView()
      changeEditMode(to: .disabled)
    
        
        //self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelEditMode(_ sender: Any) {
         changeEditMode(to: .disabled)
        
    }
    
    
    //
    func changeEditMode(to mode:EditMode)  {
        switch mode {
        case .enabled:
            commentTextField.isSelectable = true
             commentTextField.isEditable = true
            commentTextField.layer.borderWidth = 1
            commentTextField.layer.borderColor = UIColor.red.cgColor
            SaveButton.isHidden = false
            cancelEditingButton.isHidden = false
            
        case .disabled:
            commentTextField.isSelectable = false
            commentTextField.isEditable = false
            SaveButton.isHidden = true
            cancelEditingButton.isHidden = true
            commentTextField.layer.borderWidth = 0
            commentTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    
}

