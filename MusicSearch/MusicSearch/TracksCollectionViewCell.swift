//
//  TracksCollectionViewCell.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/3/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation
import UIKit
class TracksCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var trackCoverImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackAlbumLabel: UILabel!
    @IBOutlet weak var trackArtistLabel: UILabel!
    @IBOutlet weak var trackBgView: UIView!
    @IBOutlet weak var trackColorView: UIView!
}
