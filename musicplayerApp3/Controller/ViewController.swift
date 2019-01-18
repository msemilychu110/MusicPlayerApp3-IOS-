//
//  ViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/8/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit
import SJSegmentedScrollView
import AVKit
import MediaPlayer

class ViewController: SJSegmentedViewController, SJSegmentedViewControllerDelegate {
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isTranslucent = true
        
        if let storyboard = self.storyboard {
            
            let headerController = storyboard
                .instantiateViewController(withIdentifier: "header") as! HeaderViewController
            
            let firstViewController = storyboard
                .instantiateViewController(withIdentifier: "song") as! SongViewController
            firstViewController.title = "Song"
            
            let secondViewController = storyboard
                .instantiateViewController(withIdentifier: "artist") as! ArtistViewController
            secondViewController.title = "Artist"
            
            let thirdViewController = storyboard
                .instantiateViewController(withIdentifier: "album") as! AlbumViewController
            thirdViewController.title = "Album"
            
            let fourthViewController = storyboard
                .instantiateViewController(withIdentifier: "genre") as! GenreViewController
            fourthViewController.title = "Genre"
            
            let fiveViewController = storyboard
                .instantiateViewController(withIdentifier: "playlist") as! PlaylistViewController
            fiveViewController.title = "Playlist"
            
            headerViewController = headerController
            segmentControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController, fiveViewController]
            segmentShadow = SJShadow.light()
            segmentBackgroundColor = UIColor(red: 0.86, green: 0.17, blue: 0.44, alpha: 1)
            selectedSegmentViewColor = UIColor.red
            segmentTitleColor = .lightGray
            headerViewHeight =   100
        
            delegate = self
        }
        super.viewDidLoad()
    }
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        self.segments[selectedIndex].titleColor(.lightGray)
        selectedIndex = index
        self.segments[selectedIndex].titleColor(.white)
        (headerViewController as? HeaderViewController)?.headerNameLabel.text = controller.title ?? ""
    }
}

