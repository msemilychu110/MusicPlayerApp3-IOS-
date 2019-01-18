//
//  PlayerViewController.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/8/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer
import MTCircularSlider
import DrawerKit

var songsArray = [Song]()
var player: AVAudioPlayer?
class PlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    var vc = popUpViewController()
    

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var uiView: UIView!

    @IBOutlet weak var circularSlider: MTCircularSlider!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var currentSong:Song?
    var isPlaying:Bool = true
    var index = 0
    var nextSong:Song? 
    var previousSong:Song?
    var nextSongs = [Song]()
    var previousSongs = [Song]()
    var indexes = [Int] ()
    var myMediaPlayer = MPMusicPlayerController.systemMusicPlayer
    var swipeUp = UIPanGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let song = MPMediaQuery.songs()
        myMediaPlayer.setQueue(with: song)
        indexes.append(indexP)
        //myMediaPlayer.play()
        
        setupPlayer(currengSong: currentSong)
        tableView.delegate = self
        tableView.dataSource = self
        let album = Album.init(items: songsArray)
        if indexP != songsArray.count && indexP != (songsArray.count - 1) {
            nextSong = songsArray[album.items.index(after: indexP )]
        } else {
            nextSong = songsArray[0]
        }
        if indexP != 0 {
            previousSong = songsArray[album.items.index(before: indexP)]
            // songArray[album.items.index(before: (indexP))]
            previousSongs.append(previousSong!)
        } else {
            previousSong = songsArray[album.items.index(before: (songsArray.count - 1) )]
            previousSongs.append(previousSong!)
        }
        previousSongs.removeAll()
        previousSongs.append(previousSong!)
        nextSongs.removeAll()
        nextSongs.append(nextSong!)
        tableView.reloadData()
        updateInfo()
        centerImageView.layer.cornerRadius = centerImageView.bounds.size.width / 2.0
        centerImageView.layer.masksToBounds = false
        centerImageView.clipsToBounds = true
       
        let sb = UIStoryboard(name: "Main", bundle: nil)
        vc = sb.instantiateViewController(withIdentifier: "result") as! popUpViewController

        vc.view.frame = CGRect(x: 0, y: self.imageView.frame.height, width: self.imageView.frame.width, height: -50)
        
        self.addChild(vc)
        self.imageView.addSubview(vc.view)
        vc.didMove(toParent: self)
        backgroundImageView.isUserInteractionEnabled = true
        swipeUp = UIPanGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        
       // backgroundImageView.addGestureRecognizer(swipeUp)
        vc.view.addGestureRecognizer(swipeUp)
        vc.view.isUserInteractionEnabled = true
        vc.songUpDelegate = self
    }
    @objc func swipeGesture(sender: UIPanGestureRecognizer) {
        let yLocationTouched = swipeUp.location(in: self.imageView).y
        if yLocationTouched > 0 && yLocationTouched < imageView.frame.height - 40 {
        //imageView.frame.origin.y = yLocationTouched
        UIView.animate(withDuration: 0.5) {
            self.vc.view.frame =  CGRect(x: 0, y: yLocationTouched, width: self.imageView.frame.width, height: self.imageView.frame.height )
        }
        }
       // vc.view.frame.origin.y = yLocationTouched + 200
    }
    func updateInfo() {
        
        backgroundImageView.image = currentSong?.artwork?.image(at: (backgroundImageView?.frame.size)!)
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0.3
        
        centerImageView.image = currentSong?.artwork?.image(at: (centerImageView?.frame.size)!)
        
        centerImageView.alpha = 1.3
        songTitle.text = currentSong?.title
        artistName.text = currentSong?.artist
    }
    func progressSlider() {
        
        circularSlider.valueMinimum = 0
        circularSlider.valueMaximum = CGFloat((player?.duration)!)
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (t) in
            self.circularSlider.value = CGFloat((player?.currentTime)!)
        }
        
    }
    func rotateAlbum () {
        if isPlaying == true {
            self.centerImageView.layer.cornerRadius = self.centerImageView.bounds.size.width / 2
            UIView.animate(withDuration:  2, animations: {
                
                self.centerImageView.transform = self.centerImageView.transform.rotated(by: 5 * CGFloat(Double.pi)/180)
            }) { (status) in
                
                self.rotateAlbum()
            }
        }
    }
    
    private func setupCommandCenter() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "MM Music Player"]
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            
            self?.updateNowPlayingInfoCenter()
            player?.play()
            self?.isPlaying = true
            
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            player?.pause()
            self?.isPlaying = false
            
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.nextSong(UIButton())
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.previousSong(UIButton())
            return .success
        }
    }
    
    private func updateNowPlayingInfoCenter(artwork: UIImage? = nil) {
        guard let file = currentSong else {
            MPNowPlayingInfoCenter.default().nowPlayingInfo = [String: AnyObject]()
            return
        }
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: file.title as Any,
            MPMediaItemPropertyAlbumTitle: file.albumTitle ?? "",
            MPMediaItemPropertyArtist: file.artist  ?? "",
            MPMediaItemPropertyPlaybackDuration: player?.duration as Any,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: player?.duration as Any ]
        if let artwork = artwork {
            MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: artwork.size, requestHandler: { (Bool) -> UIImage in
                return artwork
            })
        }
    }
    func setupPlayer(currengSong: Song? )  {
        //        currentSong = songArray[indexP]
        //        currentSong = Albums[number].items[indexP]
        
        guard let url =  currentSong?.assetURL     else {
            return
        }
        
        do {
            try
                player = AVAudioPlayer(contentsOf: url)
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            
            debugPrint("AVAudioSession is Active and Category Playback is set")
            UIApplication.shared.beginReceivingRemoteControlEvents()
            setupCommandCenter()
        } catch {
            debugPrint("Error: \(error)")
        }
        if isPlaying {
            player!.play()
        }
        rotateAlbum()
        progressSlider()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "upNext"
        }
        return "Previous"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return nextSongs.count
        }
        return previousSongs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! playScreenTableViewCell
            cell.imageView1.image = nextSongs.first!.artwork?.image(at: cell.imageView1.frame.size)
            cell.songTitle.text = nextSongs.first!.title
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! playScreenTableViewCell
        cell.imageView1.image = previousSongs.first!.artwork?.image(at: cell.imageView1.frame.size)
        cell.songTitle.text = previousSongs.first!.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = Album.init(items: songsArray)
        if indexPath.section == 0 {
            vc.album = nil
            song = nextSong
            vc.viewDidLoad()
            if indexP != (songsArray.count-1) && indexP != (songsArray.count - 2) {
                indexP += 1
                nextSong = songsArray[album.items.index(after:(indexP ))]
            } else {
                print(indexP)
                nextSong = songsArray[0]
                indexP = 0
            }
            isPlaying = true
            currentSong = nextSongs.first
            //myMediaPlayer.nowPlayingItem = currentSong
            
            setupPlayer(currengSong: currentSong)
            updateInfo()
            progressSlider()
            nextSongs.removeAll()
            nextSongs.append(nextSong!)
            tableView.reloadData()
            
        }
        if indexPath.section == 1 {
            vc.album = nil
            song = previousSong
            vc.viewDidLoad()
            if indexP != 1 && indexP != 0 {
                print(indexP)
                indexP -= 1
                previousSong = songsArray[album.items.index(before: indexP)]
                // songArray[album.items.index(before: (indexP))]
                
            } else {
                print(indexP)
                previousSong = songsArray[album.items.index(before: ((songsArray.count)) )]
                indexP = 15
                
            }
            currentSong = previousSongs.first
            setupPlayer(currengSong: currentSong)
            updateInfo()
            progressSlider()
            previousSongs.removeAll()
            previousSongs.append(previousSong!)
            updateInfo()
            tableView.reloadData()
            
        }
    }
    

    
    
    @IBAction func sliderPulled(_ sender: MTCircularSlider) {
        if sender.isTouchInside {
            player?.stop()
            player?.currentTime = TimeInterval(circularSlider.value)
            player?.prepareToPlay()
            player?.play()
        }
        
    }
    @IBAction func addButtonTapped(_ sender: UIButton) {
        playListSongs.append(currentSong!)
        do {
            let placesData = try NSKeyedArchiver.archivedData(withRootObject: playListSongs, requiringSecureCoding: false)
            UserDefaults.standard.set(placesData, forKey: "songs")
        }
        catch {
            print("error")
        }
    }
    @IBAction func nextSong(_ sender: UIButton) {
        
        let nextSongIndex = songsArray.index(after: indexP)
        if indexP != (songsArray.count - 1) {
            currentSong = songsArray[nextSongIndex]
            indexP = nextSongIndex
        } else {
            currentSong = songsArray[0]
            indexP = 0
        }
        vc.album = nil
        song = currentSong
        vc.viewDidLoad()
        setupPlayer(currengSong: currentSong)
        
        progressSlider()
        updateInfo()
    }
    
    @IBAction func previousSong(_ sender: UIButton) {
        let previousSongIndex = songsArray.index(before: indexP)
        if indexP != 0 {
            currentSong = songsArray[previousSongIndex]
            indexP = previousSongIndex
        } else {
            currentSong = songsArray[(songsArray.count - 1)]
            indexP = (songsArray.count-1)
        }
        vc.album = nil
        song = currentSong
        vc.viewDidLoad()
        setupPlayer(currengSong: currentSong)
        progressSlider()
        updateInfo()
    }
    
    @IBAction func playPauseSong(_ sender: Any) {
        if isPlaying {
            player?.pause()
            //            myMediaPlayer.pause()
            isPlaying = false
            playPauseButton.setBackgroundImage(UIImage(named: "play.png"), for: .normal)
            
        } else if !isPlaying {
            player?.play()
            //            myMediaPlayer.pause()
            isPlaying = true
            rotateAlbum()
            playPauseButton.setBackgroundImage(UIImage(named: "pause.png"), for: .normal)
        }
    }
    
    @IBAction func repeatSong(_ sender: UIButton) {
        myMediaPlayer.nowPlayingItem = currentSong
        currentSong = myMediaPlayer.nowPlayingItem
        setupPlayer(currengSong: currentSong)
        progressSlider()
        updateInfo()
        
    }
    
    @IBAction func shuffleSong(_ sender: Any) {
        var shuffleSongs = songsArray.shuffled()
        currentSong = shuffleSongs[indexP]
        vc.album = nil
        song = currentSong
        vc.viewDidLoad()
        setupPlayer(currengSong: currentSong)
        progressSlider()
        updateInfo()
    }
    
}

extension PlayerViewController: songUpdateDelegate {
    func songUpdate(currentSong1: Song?) {
         currentSong = currentSong1
        setupPlayer(currengSong: currentSong)
        progressSlider()
        updateInfo()
//        vc.tableView.reloadData()
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
