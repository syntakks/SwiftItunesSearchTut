//
//  AlbumListController.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import UIKit

class AlbumListController: UITableViewController {
    
    private struct Contstants {
        static let AlbumCellHeight: CGFloat = 80
    }
    
     let client = ItunesAPIClient()
    
    var artist: Artist? {
        didSet {
            if let artist = artist {
                self.title = artist.name
                dataSource.update(with: artist.albums)
                tableView.reloadData()
            }
        }
    }
    
    lazy var dataSource: AlbumListDataSource = {
        return AlbumListDataSource(albums: [], tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Contstants.AlbumCellHeight
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbum" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedAlbum = dataSource.album(at: indexPath)
                let albumDetailController = segue.destination as! AlbumDetailController
                client.lookupAlbum(withId: selectedAlbum.id) { album, error in
                    album?.artwork = selectedAlbum.artwork
                    albumDetailController.album = album
                }
            }
        }
    }

}
