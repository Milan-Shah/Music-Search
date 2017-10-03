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
    
    
}
