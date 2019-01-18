//
//  popUpViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/27/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit
var song:Song?
protocol songUpdateDelegate {
    func songUpdate (currentSong1: Song?)
}
class popUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var songUpDelegate: songUpdateDelegate!
    @IBOutlet weak var titleforAlbum: UILabel!

    @IBOutlet weak var tableView: UITableView!
    

    var albums = [Album]()
    var indexD = 0
    var album:Album?
    var items = [Song]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
       
        albums = ((query?.collections?.filter({ (album1) -> Bool in
            album1.items.contains(song!)
        }))!)
        for albu in albums {
            album = albu
        }
        titleforAlbum.text = album?.representativeItem?.albumTitle
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (album?.items.count ?? 0)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! popUpTableViewCell
        cell.songTitle.text = album?.items[indexPath.row].title
        cell.artistName.text = album?.items[indexPath.row].artist
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexD = indexPath.row
        let vc = self.parent as! PlayerViewController
        self.view.frame = CGRect(x: 0, y: vc.imageView.frame.height, width: vc.imageView.frame.width, height: -50)
        songUpDelegate.songUpdate(currentSong1: album?.items[indexPath.row])
//        let vc = self.parent as! PlayerViewController
//        vc.currentSong = (albums.first![indexP] as! Song)
//        vc.isPlaying = true
       // performSegue(withIdentifier: "ToPlayScreen", sender: self)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ToPlayScreen" {
//            let destVC = segue.destination as! PlayerViewController
//            destVC.currentSong = (albums.first![indexP] as! Song)
//            destVC.isPlaying = true
//        }
//    }
}
