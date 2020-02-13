//
//  SongCell.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    static let reuseIdentifier = "SongCell"
    
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var songRuntimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: SongCellViewModel) {
        songLabel.text = viewModel.songTitle
        songRuntimeLabel.text = viewModel.runtime
    }

}
