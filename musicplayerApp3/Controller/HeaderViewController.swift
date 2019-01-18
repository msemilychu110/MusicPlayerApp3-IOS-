//
//  HeaderViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/8/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit

class HeaderViewController: UIViewController {
    
    @IBOutlet weak var headerNameLabel: UILabel!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
    }
}
