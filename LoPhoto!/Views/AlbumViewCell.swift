//
//  AlbumViewCell.swift
//  LoPhoto!
//
//  Created by Prateek Ropia on 22/08/2019.
//  Copyright © 2019 Prateek Ropia. All rights reserved.
//

import Foundation
import UIKit

class AlbumViewCell : UITableViewCell {
    
    static let CellIdentifier = "AlbumViewCell"
    
    @IBOutlet weak var albumSampleImageView: UIImageView!
    
    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var albumDescriptionLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
}
