//
//  AlbumDetailController.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import UIKit

class AlbumDetailController: UITableViewController {
    
    var album: Album? {
        didSet {
            if let album = album {
                self.title = album.artistName
                dataSource.update(with: album.songs)
                configure(with: album)
                tableView.reloadData()
            }
        }
    }
    
    var dataSource = SongListDataSource(songs: [])
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumGenreLabel: UILabel!
    @IBOutlet weak var albumReleaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let album = album {
            configure(with: album)
        }
        tableView.dataSource = dataSource
    }
    
    func configure(with album: Album) {
        let viewModel = AlbumDetailViewModel(album: album)
        artworkView.image = viewModel.artwork
        albumTitleLabel.text = viewModel.title
        albumGenreLabel.text = viewModel.genre
        albumReleaseDateLabel.text = viewModel.releaseDate
    }
}
