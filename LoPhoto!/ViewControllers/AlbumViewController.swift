//
//  ViewController.swift
//  LoPhoto!
//
//  Created by Prateek Ropia on 22/08/2019.
//  Copyright © 2019 Prateek Ropia. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    static let ShowPhotosSegueIdentifier = "ShowAlbumPhotos"
    
    @IBOutlet weak var albumTableView: AlbumTableView!
    
    var listOfAlbums = [Album]()
    var photosInAlbums: [[Photo]] = [[]]
    var thumbnailsForAlbums: [Int: UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Albums"
        
        albumTableView.tableFooterView = UIView()
        loadAlbumData()
    }
    
    // datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfAlbums.count
    }
    
    // delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumViewCell = tableView.dequeueReusableCell(withIdentifier: AlbumViewCell.CellIdentifier, for: indexPath) as! AlbumViewCell
        
        let album = listOfAlbums[indexPath.row]
        
        albumViewCell.albumNameLabel.text = album.title
        albumViewCell.albumDescriptionLabel.text = album.description
        if let image = thumbnailsForAlbums[album.id] {
            // now val is not nil and the Optional has been unwrapped, so use it
            albumViewCell.albumSampleImageView.image = image
            albumViewCell.albumSampleImageView.backgroundColor = UIColor.white
            albumViewCell.activityIndicator.stopAnimating()
        }
        
        return albumViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: AlbumViewController.ShowPhotosSegueIdentifier, sender: tableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == AlbumViewController.ShowPhotosSegueIdentifier) {
            
        }
    }
    
    private func loadAlbumData() {
        WebServices.shared.getAlbums() {
            albums, error in
            
            guard let freshPhotoAlbums = albums else {
                print("no albums here")
                // maybe show alert with error?
                return
            }
            
            self.listOfAlbums = freshPhotoAlbums
            DispatchQueue.main.async {
                self.albumTableView.reloadData()
            }
            
            // albums are loaded, load thumbnail images for the albums
            self.loadAlbumPhotos()
        }
    }
    
    private func loadAlbumPhotos() {
        for album in listOfAlbums {
            WebServices.shared.loadAlbumPhotos(album) {
                photos, error in
                
                guard let freshPhotos = photos else {
                    print("no photos man")
                    // maybe show alert with error?
                    return
                }
                
                if (freshPhotos.count > 0) {
                    self.photosInAlbums.append(freshPhotos)
                    self.loadAlbumThumbnails()
                }
            }
        }
    }
    
    private func loadAlbumThumbnails() {
        for photos in photosInAlbums {
            if (photos.count > 0) {
                WebServices.shared.loadImageData(photos[0].thumbnailUrl) {
                    data, error in
                    
                    guard let imageData = data else {
                        print("no photos man")
                        // maybe show alert with error?
                        return
                    }
                    
                    self.thumbnailsForAlbums[photos[0].albumId] = UIImage(data: imageData)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.albumTableView.reloadData()
        }
    }
}

