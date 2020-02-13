//
//  PendingOperations.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/13/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import Foundation

class PendingOperations {
    var downloadsInProgress = [IndexPath: Operation]()
    let downloadQueue = OperationQueue()
}
