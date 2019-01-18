//
//  PlaylistViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/8/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit

var playListSongs = [Song]()

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let VC = PlayerViewController()
    var song:Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    tableView.delegate = self
    tableView.dataSource = self
    
    clearTableViewLine()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let placesData = UserDefaults.standard.object(forKey: "songs") as? Data
        
        if let placesData = placesData {
            do {let placesArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(placesData)
                playListSongs = placesArray as! [Song]
            } catch {
                print("error")
            }
        }
        tableView.reloadData()
    }
    
    func clearTableViewLine() {
        self.tableView.tableFooterView = UIView()
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if  editingStyle == UITableViewCell.EditingStyle.delete {
        playListSongs.remove(at: indexPath.row)
            do {
                let placesData = try NSKeyedArchiver.archivedData(withRootObject: playListSongs, requiringSecureCoding: false)
                UserDefaults.standard.set(placesData, forKey: "songs")
            } catch {
                print("error")
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playListSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! playlistTableViewCell
        cell.songName.text = playListSongs[indexPath.row].title
        cell.removeButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player?.stop()
        indexP = indexPath.row
        performSegue(withIdentifier: "ToPlayScreen", sender: nil)
        song = playListSongs[indexP]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPlayScreen" {
            let destVC = segue.destination as! PlayerViewController
            destVC.currentSong = playListSongs[indexP]
            destVC.isPlaying = true
    }
}
    @objc func buttonAction(sender: UIButton!) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let index = (self.tableView.indexPathForRow(at: buttonPosition)?.row)!
        playListSongs.remove(at: index)
        do {
            let placesData = try NSKeyedArchiver.archivedData(withRootObject: playListSongs, requiringSecureCoding: false)
            UserDefaults.standard.set(placesData, forKey: "songs")
        } catch {
            print("error")
        }
        tableView.reloadData()
    }
}
