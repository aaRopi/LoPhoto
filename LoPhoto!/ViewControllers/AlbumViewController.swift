//
//  ViewController.swift
//  LoPhoto!
//
//  Created by Prateek Ropia on 22/08/2019.
//  Copyright © 2019 Prateek Ropia. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var albumTableView: AlbumTableView!
    
    var listOfAlbums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        albumTableView.tableFooterView = UIView()
        loadAlbumData()
    }
    
    // datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfAlbums.count
    }
    
    // delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumViewCell = tableView.dequeueReusableCell(withIdentifier: "AlbumViewCell", for: indexPath) as! AlbumViewCell
        
        albumViewCell.model = listOfAlbums[indexPath.row]
        return albumViewCell
    }
    
    private func loadAlbumData() {
        
        // demo data, make web calls later
        listOfAlbums.append(Album())
        listOfAlbums.append(Album())
        listOfAlbums.append(Album())
    }
}

