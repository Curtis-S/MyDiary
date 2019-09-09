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
            commentTextField.text = detail.comment
            
            if let loacation = detail.location{
                geoLocationInfoLabel.text = loacation
                
            } else {
                 geoLocationInfoLabel.text = "no location saved"
            }
            
            dateLabel.text = String(describing: detail.createdOn)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        
        
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
    @IBAction func test(_ sender: Any) {
        changeEntryText(to:commentTextField.text!)
        print("chanegd")
       self.navigationController?.popViewController(animated: true)
    
        
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
            commentTextField.isSelectable = true
            commentTextField.isEditable = true
            SaveButton.isHidden = true
            cancelEditingButton.isHidden = true
            commentTextField.layer.borderWidth = 0
            commentTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    
}

