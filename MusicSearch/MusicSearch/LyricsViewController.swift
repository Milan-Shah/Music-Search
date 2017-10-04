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

