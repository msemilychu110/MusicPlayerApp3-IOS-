//
//  playlistTableViewCell.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/26/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit

class playlistTableViewCell: UITableViewCell {

    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
