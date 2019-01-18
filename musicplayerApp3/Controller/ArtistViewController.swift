//
//  ArtistViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/8/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class ArtistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var artistModel = ArtistModel()
    @IBOutlet weak var tableView: UITableView!
    
    var query:MPMediaQuery?
    var mediaItems:[MPMediaItem]?
    var artists = [Artist]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                    // Code you want to be delayed
                    
                    self.artists = self.artistModel.getArtist()
                    self.tableView.reloadData()
                    
                }
            } else {
                print("error with authorization")
            }
        }
        
        
        clearTableViewLine()
    }
    
    func clearTableViewLine() {
        self.tableView.tableFooterView = UIView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentArtist = artists[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! artistTableViewCell
        cell.artistName.text = currentArtist.representativeItem?.artist
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "segue1", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1" {
            let destVC = segue.destination as! DetailViewController
            destVC.collection1 = artists[index]
        }
    }
}
