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
    
    @IBOutlet weak var albumSampleImageView: UIImageView!
    
    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var albumDescriptionLabel: UILabel!
    
    var model: Album?
    {
        didSet
        {
            albumNameLabel.text = model?.title
            albumDescriptionLabel.text = model?.description
//            albumSampleImageView.image = 
            
        }
    }
}
