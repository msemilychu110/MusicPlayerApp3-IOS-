//
//  DetailViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/21/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var VC = PlayerViewController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var index = 0
    var songs = [Song]()
    var collection1:Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.delegate = self
       tableView.dataSource = self
        
    /*    songs.sort { (song, song2) -> Bool in
            if let one = song.title, let two = song2.title {
                return one < two
            } else {
                return true
            }
        }*/
      
        getSongs()
        updateInfo()
    }
    func getSongs() {
        for item in (collection1?.items)! {
            songs.append(item)
        }
        songsArray.removeAll()
        songsArray = songs
    }
    func updateInfo() {
        imageView.image = collection1?.representativeItem?.artwork?.image(at: imageView.frame.size)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (collection1?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! DetailTableViewCell
        cell.cellLabel.text = songs[indexPath.row].title
        cell.addbutton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       player?.stop()
        VC.myMediaPlayer.nowPlayingItem = songs[indexPath.row]
        indexP = indexPath.row
        performSegue(withIdentifier: "segue1", sender: nil)
        song = songs[indexP]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1" {
            let destVC = segue.destination as! PlayerViewController
            destVC.currentSong = songs[indexP]
            destVC.isPlaying = true
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        index = (self.tableView.indexPathForRow(at: buttonPosition)?.row)!
        
        playListSongs.append(songs[index])
        do {
            let placesData = try NSKeyedArchiver.archivedData(withRootObject: playListSongs, requiringSecureCoding: false)
            UserDefaults.standard.set(placesData, forKey: "songs")
        }
        catch {
            print("error")
        }
    }
}
