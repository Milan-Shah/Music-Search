//
//  Track.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/2/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation

/*
Call the apple API and display all the returned track names, artist name, album name, and image of album in a cell
Modling the data!! - an important task to do -
*/

struct Track {
    let name : String?
    let artist : String?
    let album : String?
    let cover : URL?
}

extension Track {
    private enum Keys: String, SerializationKey {
        case trackName = "trackName"
        case artistName = "artistName"
        case albumName = "collectionName"
        case coverImage = "artworkUrl100"
    }
    
    init(serialization : Serialization) {
        name = serialization.value(forKey: Keys.trackName)
        artist = serialization.value(forKey: Keys.artistName)
        album = serialization.value(forKey: Keys.albumName)
        if let url: String = serialization.value(forKey: Keys.coverImage) {
            cover = URL(string: url)
        } else {
            cover = nil
        }
    }
}
