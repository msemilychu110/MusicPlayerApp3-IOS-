//
//  AlbumViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/8/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var albumModel = AlbumModel()
    @IBOutlet weak var tableView: UITableView!
    
    var Albums = [Album]()
    var number = 0
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                    // Code you want to be delayed
                    
                    self.Albums = self.albumModel.getAlbum()
                    self.tableView.reloadData()
                    
                }
            } else {
                print("error with authorization")
            }
        }
        
        
       
        
        clearTableViewLines()
    }
    
 
    func clearTableViewLines() {
        self.tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        number = indexPath.row
        let currentAlbum = Albums[indexPath.row ]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! albumTableViewCell
        cell.albumLabel.text  = currentAlbum.representativeItem?.albumTitle
        cell.albumImageView.image = currentAlbum.representativeItem?.artwork?.image(at: cell.albumImageView.frame.size)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1" {
            let destVC = segue.destination as! DetailViewController
            destVC.collection1 = Albums[index]
        }
    }
}
