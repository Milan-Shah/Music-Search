//
//  SearchViewController.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/1/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    fileprivate var request: AnyObject?
    fileprivate var tracksArray = [Track]()
    fileprivate var imageLoader = ImageCacheLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        searchButton.layer.masksToBounds = true
        searchButton.layer.cornerRadius = 10.0
        self.activityIndicator.isHidden = true
        setUpCollectionView()
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        if let text = searchTextField.text, !text.isEmpty{
            turnOnActivityIndicator()
            fetchTracks(track: text)
        } else {
            print("Please enter the name of the track you would like to search!")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracksArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: TracksCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TracksCell", for: indexPath) as! TracksCollectionViewCell
        
        let number = indexPath.row + 1
        if (number % 2 == 0){
            cell.trackColorView.backgroundColor = UIColor.myMountainColor()
        } else if (number % 3 == 0){
            cell.trackColorView.backgroundColor = UIColor.myDarkGrayColor()
        } else {
            cell.trackColorView.backgroundColor = UIColor.myOrangeColor()
        }
        
        cell.trackBgView.layer.masksToBounds = true
        cell.trackBgView.layer.cornerRadius = 6.0
        cell.trackBgView.layer.borderWidth = 0.3
        cell.trackBgView.layer.borderColor = UIColor.lightGray.cgColor
        cell.trackColorView.layer.masksToBounds = true
        cell.trackColorView.layer.cornerRadius = 5.0
        
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOffset = CGSize(width: 0.2, height: 1.0)
        cell.layer.shadowColor = UIColor.black.cgColor
        
        let trackObj : Track = self.trackForIndexPath(indexPath: indexPath)

        if let tName = trackObj.name {
            cell.trackNameLabel.text = tName
        }
        if let tAlbum = trackObj.album {
            cell.trackAlbumLabel.text = tAlbum
        }
        if let tArtist = trackObj.artist {
            cell.trackArtistLabel.text = tArtist
        }
        if let coverImageURL = trackObj.cover {
            imageLoader.obtainImageWithPath(imagePath: coverImageURL.absoluteString, completionHandler: { (coverImage) in
                if let updateCell : TracksCollectionViewCell = collectionView.cellForItem(at: indexPath) as? TracksCollectionViewCell{
                    updateCell.trackCoverImageView.image = coverImage
                }
                
            })
        }
        
        return cell;
        
    }
}

private extension SearchViewController {
    
    func configureCollectionUI (with track : Track){
        print ("Tracks received. Refresh Collection UI")
    }

    
    func fetchTracks(track : String) {
        let tracksResource = TracksResource()
        let tracksRequest = ApiRequest(resource: tracksResource, url: APIUrls.getSearchSongUrl(searchedText: track))
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
    
    func setUpCollectionView() {
        self.resultsCollectionView.delegate = self;
        self.resultsCollectionView.dataSource = self;
        self.resultsCollectionView.register(UINib.init(nibName: "TracksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TracksCell")
        (self.resultsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: self.view.bounds.size.width - 32, height: 145)
    }
    
    func trackForIndexPath(indexPath : IndexPath) -> Track {
        return tracksArray[indexPath.row]
    }

}















