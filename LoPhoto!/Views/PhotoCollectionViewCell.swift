//
//  PhotoCollectionViewCell.swift
//  LoPhoto!
//
//  Created by Prateek Ropia on 23/08/2019.
//  Copyright © 2019 Prateek Ropia. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let CellIdentifier = "PhotoCollectionViewCell"
    
    @IBOutlet weak var photoThumbnailView: UIImageView!
    
    @IBOutlet weak var photoNameLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
}
