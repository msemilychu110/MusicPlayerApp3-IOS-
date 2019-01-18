//
//  GenreTableViewCell.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/25/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var View: UIView!
    @IBOutlet weak var genreImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
