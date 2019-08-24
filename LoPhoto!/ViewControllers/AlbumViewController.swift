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
    var listOfImages: [Int: UIImage] = [:]
    
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
        
        return albumViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: AlbumViewController.ShowPhotosSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == AlbumViewController.ShowPhotosSegueIdentifier) {
            
        }
    }
    
    private func loadAlbumData() {
        // make web call
        guard let albumUrl = URL(string: WebResources.AlbumResource) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: albumUrl)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for errors first
            guard error == nil else {
                print("error getting albums!")
                print(error!)
                return
            }
            
            // print response to console
            print("Response: ")
            print(response ?? "no response")
            
            // did we get some data?
            guard let responseData = data else {
                print("No error but no data!")
                return
            }
            
            // parse JSON
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [[String: Any]] else {
                        print("error trying to convert data to JSON")
                        return
                    }
                
                print(jsonData)
                
                for jsonDataPiece in jsonData {
                    guard let album = Album(json: jsonDataPiece) else { continue }
                    self.listOfAlbums.append(album)
                }
                
                DispatchQueue.main.async {
                    self.albumTableView.reloadData()
                }
                
            } catch {
                print("error error JSON terror")
                return
            }
        }
        
        dataTask.resume()
    }
}

