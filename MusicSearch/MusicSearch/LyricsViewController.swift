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
    fileprivate var imageLoader = ImageCacheLoader()
    var selectedTrackObj: Track! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        setUpUI()
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
        }
        
    }
    
    @IBAction func backBarButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

private extension LyricsViewController {
    
    func fetchLyrics(artistName : String, songName : String) {
        let tracksResource = TracksResource()
        let tracksRequest = ApiRequest(resource: tracksResource, url: APIUrls.getLyricsOfSongUrl(artistName: artistName, songName: songName))
        request = tracksRequest
        tracksRequest.load { [weak self] (tracks: [Track]?) in
            self?.turnOffActivityIndicator()
            if (tracks != nil){
                print("Results received: \(tracks ?? [])")
                self?.tracksArray = tracks!
                self?.resultsCollectionView.reloadData()
            } else {
                print ("No results received")
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

