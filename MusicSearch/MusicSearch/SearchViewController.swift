//
//  SearchViewController.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/1/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    fileprivate var request: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        searchButton.layer.masksToBounds = true
        searchButton.layer.cornerRadius = 10.0
        self.activityIndicator.isHidden = true
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        if let text = searchTextField.text, !text.isEmpty{
            turnOnActivityIndicator()
            fetchTracks(track: text)
        } else {
            print("Please enter the name of the track you would like to search!")
        }
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
            } else {
                print ("No results received")
            }
        }
    }
    
    
    /*
    func fetchTracks(track : String) {
        
        let tracksRequest = TracksRequest(url : APIUrls.getSearchSongUrl(searchedText: track))
        self.request = tracksRequest
        tracksRequest.load(withCompletion: { /*[weak self]*/ (data: Data?) in
            print("Data: \()")
        })
    }*/
    
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















