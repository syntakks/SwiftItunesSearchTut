//
//  AlbumListDataSource.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import UIKit

class AlbumListDataSource: NSObject, UITableViewDataSource {
    private var albums: [Album]
    
    let pendingOperations = PendingOperations()
    let tableView: UITableView
    
    init(albums: [Album], tableView: UITableView) {
        self.albums = albums
        self.tableView = tableView
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reuseIdentifier, for: indexPath) as! AlbumCell
        let album = albums[indexPath.row]
        let viewModel = AlbumCellViewModel(album: album)
        albumCell.configure(with: viewModel)
        albumCell.accessoryType = .disclosureIndicator
        
        if album.artworkState == .placeholder {
            downloadArtwork(for: album, atIndexPath: indexPath)
        }
        
        return albumCell
    }
    
    // MARK: - Helper Methods
    
    func album(at indexPath: IndexPath) -> Album {
        return albums[indexPath.row]
    }
    
    func update(with albums: [Album]) {
        self.albums = albums
    }
    
    func downloadArtwork(for album: Album, atIndexPath indexPath: IndexPath) {
        // We've already created an operation for this cell.
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
             return
        }
        
        let downloader = ArtworkDownloader(album: album)
        
        // Completion block for downloader.
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        // These below are called first. 
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}
