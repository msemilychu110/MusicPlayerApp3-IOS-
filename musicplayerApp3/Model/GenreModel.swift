//
//  GenreModel.swift
//  musicplayerApp3
//
//  Created by Emily-Khine Chu on 11/27/18.
//  Copyright © 2018 Emily-Khine Chu. All rights reserved.
//

import Foundation
import AVKit
import MediaPlayer

var genreModelArray = [Genre]()

class GenreModel {
    func getGenre() -> [MPMediaItemCollection]{
        query = MPMediaQuery.genres()
        let genreCollection = query?.collections
        if let genreCollect = genreCollection {
        for genre in genreCollect {
            genreModelArray.append(genre)
        }
        }
        return genreModelArray
    }
}
