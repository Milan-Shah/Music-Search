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

/*
extension Track {
    
    init?(json: [String:Any]){
        if let track_name = json["trackName"] as? String{
            self.name = track_name
        } else {
            // Log it
            return nil
        }
        
        if let artist_name = json["artistName"] as? String{
            self.artist = artist_name
        } else {
            // Log it
            return nil
        }
        
        if let album_name = json["collectionName"] as? String{
            self.album = album_name
        } else {
            // Log it
            return nil
        }
        
        if let album_cover = json["artworkUrl100"] as? URL{
            self.cover = album_cover
        } else {
            // Log it
            return nil
        }
    }
}
*/
