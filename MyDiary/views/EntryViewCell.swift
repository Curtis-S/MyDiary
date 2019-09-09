//
//  EntryViewCell.swift
//  MyDiary
//
//  Created by curtis scott on 06/09/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class EntryViewCell: UITableViewCell {
    static let identifier = "EventCell"
    
    
    @IBOutlet weak var geoLocationImg: UIImageView!
    
    @IBOutlet weak var geoLocationTextLabel: UILabel! 
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var entryCommentLabel: UILabel!
    
    @IBOutlet weak var entryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    

}
