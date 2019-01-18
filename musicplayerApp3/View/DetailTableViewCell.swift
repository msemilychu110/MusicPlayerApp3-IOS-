//
//  DetailTableViewCell.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/21/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var addbutton: UIButton!
    
    
    override func awakeFromNib() {        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
