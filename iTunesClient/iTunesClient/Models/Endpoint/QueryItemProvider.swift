//
//  QueryItemProvider.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import Foundation

protocol QueryItemProvider {
    var queryItem: URLQueryItem { get }
}
