//
//  AlbumModel.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/27/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import Foundation
import AVKit
import MediaPlayer


var albumModelArray = [MPMediaItemCollection]()

class AlbumModel {
    
    func getAlbum() -> [MPMediaItemCollection] {
        query = MPMediaQuery.albums()
        let albumCollection = query?.collections
        if let albumCollect = albumCollection {
        for album in albumCollect {
            albumModelArray.append(album)
        }
        }
    return albumModelArray
}
}
