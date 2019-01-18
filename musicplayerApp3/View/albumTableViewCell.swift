//
//  albumTableViewCell.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/25/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit

class albumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
