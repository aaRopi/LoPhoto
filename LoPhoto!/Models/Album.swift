//
//  Album.swift
//  LoPhoto!
//
//  Created by Prateek Ropia on 22/08/2019.
//  Copyright © 2019 Prateek Ropia. All rights reserved.
//

import Foundation

class Album {
    var id = -1
    var userId = -1
    var title = "Album Title"
    var description = "Album description"
    
    var sampleImageUrl: URL?
    
    init() {
    }
}

extension Album {
    convenience init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
        let userId = json["userId"] as? Int,
        let title = json["title"] as? String
        else {
            return nil
        }
        
        // initialize and set properties
        self.init()
        self.id = id
        self.userId = userId
        self.title = title
    }
}
