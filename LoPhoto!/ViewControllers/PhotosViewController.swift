//
//  PhotosViewController.swift
//  LoPhoto!
//
//  Created by Prateek Ropia on 23/08/2019.
//  Copyright © 2019 Prateek Ropia. All rights reserved.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        
        loadAlbumPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.CellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        
        photoCollectionViewCell.photoNameLabel.text = photo.title
//        photoCollectionViewCell.photoThumbnailView.image =
        
        return photoCollectionViewCell
    }
    
    private func loadAlbumPhotos() {
        // demo data, make web calls later
        photos.append(Photo())
        photos.append(Photo())
        photos.append(Photo())
    }
}
