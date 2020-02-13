//
//  Artist.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import Foundation

class Artist {
    let id: Int
    let name: String
    let primaryGenre: String
    var albums: [Album]
    
    init(id: Int, name: String, primaryGenre: String, albums: [Album]) {
        self.id = id
        self.name = name
        self.primaryGenre = primaryGenre
        self.albums = albums
    }
}

extension Artist {
    convenience init?(json: [String: Any]) {
        
        struct Key {
            static let artistName = "artistName"
            static let artistId = "artistId"
            static let primaryGenreId = "primaryGenreId"
            static let primaryGenreName = "primaryGenreName"
        }
        
        guard let artistName = json[Key.artistName] as? String,
            let artistId = json[Key.artistId] as? Int,
            let primaryGenre = json[Key.primaryGenreName] as? String else {
                return nil
        }
        
        self.init(id: artistId, name: artistName, primaryGenre: primaryGenre, albums: [])
    }
}
