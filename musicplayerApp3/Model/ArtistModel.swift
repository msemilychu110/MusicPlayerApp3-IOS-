//
//  ArtistModel.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/27/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import Foundation
import AVKit
import MediaPlayer

var genreModelArrays = [MPMediaItemCollection]()

class ArtistModel {
    func getArtist() -> [MPMediaItemCollection] {
        query = MPMediaQuery.artists()
        let artistCollections = query?.collections
        if let artistCollect = artistCollections {
        for artist in artistCollect {
            genreModelArrays.append(artist)
        }
        }
        return genreModelArrays
    }
}
