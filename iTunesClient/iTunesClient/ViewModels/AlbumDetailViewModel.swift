//
//  AlbumDetailViewModel.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import Foundation
import UIKit

struct AlbumDetailViewModel {
    let artwork: UIImage
    let title: String
    let releaseDate: String
    let genre: String
}

extension AlbumDetailViewModel {
    init(album: Album) {
        self.artwork = album.artwork ?? #imageLiteral(resourceName: "placeholder")
        self.title = album.name
        self.genre = album.primaryGenre
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd, yyyy"
        
        self.releaseDate = formatter.string(from: album.releaseDate)
    }
}
