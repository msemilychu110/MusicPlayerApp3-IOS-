//
//  File.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/27/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import Foundation
import AVKit
import MediaPlayer


var query:MPMediaQuery?
 var mediaitems:[MPMediaItem]?
 var songModelArray = [Song]()
class SongModel  {
    
    func getSongs() -> [MPMediaItem] {
        query = MPMediaQuery.songs()
        mediaitems  = query?.items
        if let mediaitem = mediaitems {
            for track in mediaitem {
            songModelArray.append(track)
        }
            
        }
        return songModelArray
}    
}
