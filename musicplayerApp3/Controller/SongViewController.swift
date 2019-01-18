//
//  SongViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/8/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit


var indexP = 0

class SongViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var songModel = SongModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemCollections: MPMediaItemCollection?
    var songArray = [Song]()
    var searchBarArray = [Song]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                    // Code you want to be delayed
                
                self.songArray = self.songModel.getSongs()
                self.insertSong()
                print(self.songArray)
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
 
    func insertSong() {
        songsArray.removeAll()
        songsArray = songArray
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarArray = songArray.filter { ($0.title!.lowercased().prefix(searchText.count) == searchText.lowercased())}
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        searchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchBarArray.count
        } else {
            return songArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentTrack = songArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! songTableViewCell
        if searching {
            cell.songTitle.text = searchBarArray[indexPath.row].title
            cell.artistName.text = searchBarArray[indexPath.row].artist
        } else {
            cell.songTitle.text = currentTrack.title
            cell.artistName.text = currentTrack.artist
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexP = indexPath.row
        print(indexP)
        tableView.reloadData()
        performSegue(withIdentifier: "ToPlayScreen", sender: self)
        song = songArray[indexP]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPlayScreen" {
            let destVC = segue.destination as! PlayerViewController
            destVC.currentSong = songArray[indexP]
            destVC.isPlaying = true 
            
        }
    }
}
