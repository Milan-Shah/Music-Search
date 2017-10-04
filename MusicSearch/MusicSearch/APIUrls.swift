//
//  APIUrls.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/1/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation
class APIUrls: NSObject {
    
    class func getSearchSongUrl(searchedText : String) -> URL {
        print("Making iTunes Search API:::")
        let searchSongUrl : String = "https://itunes.apple.com/search?term="
        let searched : String = searchedText.replace(target: " ", withString: "+")
        let searchTrackString = searchSongUrl.appending(searched)
        print ("API GET URL : \(searchTrackString)")
        return URL(string : searchTrackString)!
    }
    
    class func getLyricsOfSongUrl(artistName : String, songName : String) -> URL {
        print("Making Song Lyrics API:::")
        var searchSongUrl : String = "http://lyrics.wikia.com/api.php?func=getSong&artist="
        let artist : String = artistName.replace(target: " ", withString: "+")
        searchSongUrl.append(artist)
        let name : String = songName.replace(target: " ", withString: "+")
        searchSongUrl.append("&song=")
        searchSongUrl.append(name)
        searchSongUrl.append("&fmt=json")
        print ("API GET URL : \(searchSongUrl)")
        return URL(string : searchSongUrl)!
    }
    
}
