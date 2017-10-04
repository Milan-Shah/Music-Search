//
//  LyricsViewController.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/1/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation
import UIKit
class LyricsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lyricsTextView: UITextView!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var customNavBar: UINavigationBar!
    fileprivate var request: AnyObject?
    fileprivate var imageLoader = ImageCacheLoader()
    var selectedTrackObj: Track! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        setUpUI()
        self.hideKeyboardWhenTappedAround()
    }

    func setUpUI() {
        if (selectedTrackObj != nil){
            if let tName = selectedTrackObj.name {
                trackNameLabel.text = tName
                trackNameLabel.lineBreakMode = .byWordWrapping
                trackNameLabel.numberOfLines = 0
            }
            if let tAlbum = selectedTrackObj.album {
                albumNameLabel.text = tAlbum
                albumNameLabel.lineBreakMode = .byWordWrapping
                albumNameLabel.numberOfLines = 0
            }
            if let tArtist = selectedTrackObj.artist {
                artistNameLabel.text = tArtist
                artistNameLabel.lineBreakMode = .byWordWrapping
                artistNameLabel.numberOfLines = 0
            }
            if let coverImageURL = selectedTrackObj.cover {
                
                albumCoverImageView.layer.masksToBounds = true
                albumCoverImageView.layer.cornerRadius = 6.0
                albumCoverImageView.layer.borderWidth = 0.3
                albumCoverImageView.layer.borderColor = UIColor.lightGray.cgColor
                
                imageLoader.obtainImageWithPath(imagePath: coverImageURL.absoluteString, completionHandler: { (coverImage) in
                    self.albumCoverImageView.image = coverImage
                })
            }
            
            //fetching lyrics
            fetchLyrics(artistName: selectedTrackObj.artist!, songName: selectedTrackObj.name!)
        }
        
    }
    
    @IBAction func backBarButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

private extension LyricsViewController {
    
    func fetchLyrics(artistName : String, songName : String) {
        turnOnActivityIndicator()
        let lyricsResource = LyricsResource()
        let lyricsRequest = ApiRequest(resource: lyricsResource, url: APIUrls.getLyricsOfSongUrl(artistName: artistName, songName: songName))
        request = lyricsRequest
        lyricsRequest.load { [weak self] (lyricsArray: [Lyrics]?) in
            self?.turnOffActivityIndicator()
            if (lyricsArray != nil){
                let lyricsObject = lyricsArray?.first
                self?.lyricsTextView.text = lyricsObject?.lyrics
            } else {
                self?.lyricsTextView.text = "No results received from an API."
            }
        }
    }
    
    func turnOnActivityIndicator() {
        if (self.activityIndicator.isHidden){
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        }
    }
    
    func turnOffActivityIndicator() {
        if (!self.activityIndicator.isHidden){
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
}

