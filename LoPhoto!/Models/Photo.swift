//
//  Photo.swift
//  LoPhoto!
//
//  Created by Prateek Ropia on 23/08/2019.
//  Copyright © 2019 Prateek Ropia. All rights reserved.
//

import Foundation

class Photo {
    var albumId = -1
    var id = -1
    var title = "Default photo title"
    var url = "https://fake-image-fake-url"
    var thumbnailUrl = "https://fake-thumbnail-fake-url"
}

extension Photo {
    convenience init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
        let albumId = json["albumId"] as? Int,
        let title = json["title"] as? String,
        let url = json["url"] as? String,
        let thumbnailUrl = json["thumbnailUrl"] as? String
        else {
            return nil
        }
        
        // initialize and set properties
        self.init()
        self.id = id
        self.albumId = albumId
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
