//
//  ItunesApiClient.swift
//  iTunesClient
//
//  Created by Stephen Wall on 2/12/20.
//  Copyright © 2020 syntaks.io. All rights reserved.
//

import Foundation
// Search for list of artists
// Search for selected artist's albums
// Search for selected album's songs
class ItunesAPIClient {
    let downloader = JSONDownloader()
    
    typealias ArtistCompletion = ([Artist], ItunesError?) -> Void
    
    // Search for artist by keyword in searchbar
    func searchForArtists(withTerm term: String, completion: @escaping ArtistCompletion) {
        let endpoint = Itunes.search(term: term, media: .music(entity: .musicArtist, attribute: .artistTerm))
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            let artists = results.compactMap { Artist(json: $0) }
            completion(artists, nil)
        }
    }
    
    // Get albums for artist
    func lookupArtist(withId id: Int, completion: @escaping (Artist?, ItunesError?) -> Void) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.album)
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion(nil, error)
                return
            }
            guard let artistInfo = results.first else {
                completion(nil, .jsonParsingFailure(message: "Results does not contain artist info!"))
                return
            }
            guard let artist = Artist(json: artistInfo) else {
                completion(nil, .jsonParsingFailure(message: "Could not parse artist information"))
                return
            }
            // First result is artist info so ignore it.
            let albumResults = results[1..<results.count]
            let albums = albumResults.compactMap { Album(json: $0) }
            // Add albums to artist before passing it back.
            artist.albums = albums
            completion(artist, nil)
        }
    }
    
    // Get songs for album
    func lookupAlbum(withId id: Int, completion: @escaping (Album?, ItunesError?) -> Void) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.song)
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion(nil, error)
                return
            }
            guard let albumInfo = results.first else {
                completion(nil, .jsonParsingFailure(message: "Results does not contain album info!"))
                return
            }
            guard let album = Album(json: albumInfo) else {
                completion(nil, .jsonParsingFailure(message: "Could not parse album information"))
                return
            }
            // First result is artist info so ignore it.
            let songResults = results[1..<results.count]
            let songs = songResults.compactMap { Song(json: $0) }
            // Add albums to artist before passing it back.
            album.songs = songs
            completion(album, nil)
        }
    }
    
    // MARK: - Helper
    typealias Results = [[String: Any]]
    private func performRequest(with endpoint: EndPoint, completion: @escaping (Results?, ItunesError?) -> Void) {
        let task = downloader.jsonTask(with: endpoint.request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                guard let results = json["results"] as? Results else {
                    completion(nil, .jsonParsingFailure(message: "JSON data does not contain results"))
                    return
                }
                completion(results, nil)
            }
        }
        task.resume() // Execute task
    }
}
