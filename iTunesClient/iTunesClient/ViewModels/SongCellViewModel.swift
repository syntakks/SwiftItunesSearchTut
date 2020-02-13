//
//  SongCellViewModel.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import Foundation

struct SongCellViewModel {
    let songTitle: String
    let runtime: String
}

extension SongCellViewModel {
    init(song: Song) {
        self.songTitle = song.name
        
        // Track time in milliseconds
        let timeInSeconds = song.trackTime / 1000
        let minutes = timeInSeconds / 60 % 60
        let seconds = timeInSeconds % 60
        var secondsString: String
        if seconds < 10 {
            secondsString = "0\(seconds)"
        } else {
            secondsString = "\(seconds)"
        }

        self.runtime = "\(minutes):\(secondsString)"
    }
}
