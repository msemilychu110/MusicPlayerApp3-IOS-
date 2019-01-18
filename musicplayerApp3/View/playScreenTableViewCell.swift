//
//  playScreenTableViewCell.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/22/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit 

class playScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
