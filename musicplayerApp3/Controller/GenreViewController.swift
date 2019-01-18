//
//  GenreViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/8/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class GenreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var genreModel = GenreModel()
    
    @IBOutlet weak var table: UITableView!
    
    var query:MPMediaQuery?
    var mediaitems:[MPMediaItem]?
    var genres = [Genre]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                    // Code you want to be delayed
                    
                    self.genres = self.genreModel.getGenre()
                    self.table.reloadData()
                    
                }
            } else {
                print("error with authorization")
            }
        }
        
        
        
        clearTableViewLines()
    }
 
    func clearTableViewLines() {
        self.table.tableFooterView = UIView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentGenre = genres[indexPath.row ]
        let cell = table.dequeueReusableCell(withIdentifier: "cell1") as! GenreTableViewCell
        cell.genreLabel.text = currentGenre.representativeItem?.genre
        cell.genreImageView.image = currentGenre.representativeItem?.artwork?.image(at: (cell.imageView?.frame.size)!)
        cell.genreImageView.layer.cornerRadius = 30
        print(currentGenre)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1" {
            let destVC = segue.destination as! DetailViewController
            destVC.collection1 = genres[index]
        }
    }
}
