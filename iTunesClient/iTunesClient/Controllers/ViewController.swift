//
//  ViewController.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 Stephen Wall. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //testEnpoints()
    }

    func testEndpoints() {
        let searchEndpoint = Itunes.search(term: "Taylor Swift", media: .music(entity: .musicArtist, attribute: .artistTerm))
        print(searchEndpoint.request)
        print("*********************")
        let lookupEndpoint = Itunes.lookup(id: 159260351, entity: MusicEntity.album)
        print(lookupEndpoint.request)
    }
}

