//
//  NetworkService.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class NetworkService: NetworkServiceInterface {
    private let baseUrl = "http://ws.audioscrobbler.com/2.0/"
    private let apiKey = "1861abf33ad87d9e48f29097d491e149"
    private let sharedSecret = "39f73522073b722fbbc8c5e7f6b2d70c"
    
    func getTopAlbums(tag: String, completion: @escaping (_ albums: [Album], _ error: Error?)->Void) {
        let url = "\(baseUrl)?method=tag.gettopalbums&tag=\(tag)&api_key=\(apiKey)&format=json"
        GET(urlString: url) { (response, error) in
            if let error = error {
                completion([], error)
                return
            }
            
            if let response = response, let json = response.data(using: .utf8) {
                Albums.parse(json: json) { (albumsContainer, error) in
                    if let error = error {
                        completion([], error)
                    } else {
                        completion((albumsContainer as? Albums)?.albums ?? [], nil)
                    }
                }
                return
            }
            completion([], nil)
        }
    }
    
    func getTracks(albumId: String, completion: @escaping (_ tracks: [Track], _ error: Error?)->Void) {
        let url = "\(baseUrl)?method=album.getinfo&api_key=\(apiKey)&mbid=\(albumId)&format=json"
        GET(urlString: url) { (response, error) in
            if let error = error {
                completion([], error)
                return
            }
            if let response = response, let json = response.data(using: .utf8) {
                Tracks.parse(json: json) { (tracksContainer, error) in
                    if let error = error {
                        completion([], error)
                    } else {
                        completion((tracksContainer as? Tracks)?.tracks ?? [], nil)
                    }
                }
                return
            }
            completion([], nil)
        }
    }
    
    func getTopTracks(artistId: String, completion: @escaping (_ tracks: [Track], _ error: Error?)->Void) {
        let url = "\(baseUrl)?method=artist.gettoptracks&api_key=\(apiKey)&mbid=\(artistId)&format=json"
        GET(urlString: url) { (response, error) in
            if let error = error {
                completion([], error)
                return
            }
            if let response = response, let json = response.data(using: .utf8) {
                TopTracks.parse(json: json) { (tracksContainer, error) in
                    if let error = error {
                        completion([], error)
                    } else {
                        completion((tracksContainer as? TopTracks)?.tracks ?? [], nil)
                    }
                }
                return
            }
            completion([], nil)
        }
    }
    
    func getTopTagsForArtist(artistId: String, completion: @escaping (_ tags: [Tag], _ error: Error?)->Void) {
        let url = "\(baseUrl)?method=artist.gettoptags&api_key=\(apiKey)&mbid=\(artistId)&format=json"
        GET(urlString: url) { (response, error) in
            if let error = error {
                completion([], error)
                return
            }
            if let response = response, let json = response.data(using: .utf8) {
                TopTags.parse(json: json) { (tags, error) in
                    if let error = error {
                        completion([], error)
                    } else {
                        completion((tags as? TopTags)?.tags ?? [], nil)
                    }
                }
                return
            }
            completion([], nil)
        }
    }
    
    func getSimilarArtists(artistId: String, completion: @escaping (_ tags: [Artist], _ error: Error?)->Void) {
        let url = "\(baseUrl)?method=artist.getsimilar&api_key=\(apiKey)&mbid=\(artistId)&format=json"
        GET(urlString: url) { (response, error) in
            if let error = error {
                completion([], error)
                return
            }
            if let response = response, let json = response.data(using: .utf8) {
                SimilarArtists.parse(json: json) { (artists, error) in
                    if let error = error {
                        completion([], error)
                    } else {
                        completion((artists as? SimilarArtists)?.artists ?? [], nil)
                    }
                }
                return
            }
            completion([], nil)
        }
    }
    
    
}

//MARK: Base requests
extension NetworkService {
    func GET(urlString: String, completion: @escaping (String?, Error?)->Void) {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil, nil)
            }
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    
                    completion(dataString, nil)
                }
            }
        }
        task.resume()
    }
}

//MARK: NetworkService Interface
protocol NetworkServiceInterface {
    func getTopAlbums(tag: String, completion: @escaping (_ albums: [Album], _ error: Error?)->Void)
    func getTracks(albumId: String, completion: @escaping (_ tracks: [Track], _ error: Error?)->Void)
    func getTopTracks(artistId: String, completion: @escaping (_ tracks: [Track], _ error: Error?)->Void)
    func getTopTagsForArtist(artistId: String, completion: @escaping (_ tags: [Tag], _ error: Error?)->Void)
    func getSimilarArtists(artistId: String, completion: @escaping (_ tags: [Artist], _ error: Error?)->Void)
}
