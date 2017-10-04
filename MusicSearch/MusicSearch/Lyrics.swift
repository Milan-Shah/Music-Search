//
//  Lyrics.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/4/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation

struct Lyrics {
    let lyrics : String?
}

extension Lyrics {
    private enum Keys: String, SerializationKey {
        case lyricsOfSong = "lyrics"
    }
    
    init(serialization : Serialization) {
        lyrics = serialization.value(forKey: Keys.lyricsOfSong)
    }
}
