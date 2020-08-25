//
//  Mocks.swift
//  TopRockAlbumsTests
//
//  Created by acon on 23/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
@testable import TopRockAlbums

class MockDataBaseService: DataBaseServiceInterface {
    var albums: [Album] = []
    var favDict: [String: Bool] = ["1": true, "4": true, "5": true]
    
    func albumForId(albumId: String) -> Album? {
        if albumId == "" {
            return nil
        }
        return self.albums.filter { (album) -> Bool in
            return album.albumId == albumId
        }.first
    }
    
    func setFavouriteStatus(albumId: String, status: Bool) {
        if status == true {
            favDict[albumId] = true
        } else {
            favDict.removeValue(forKey: albumId)
        }
    }
    
    func isInFavourites(albumId: String) -> Bool {
        return favDict[albumId] != nil
    }
}

class MockNetworkService: NetworkServiceInterface {
    
    let albums = [
        Album(name: "aa", mbid: "1", url: "", artist: Artist(name: "a", mbid: "1", url: ""), images: []),
        Album(name: "bb", mbid: "2", url: "", artist: Artist(name: "b", mbid: "2", url: ""), images: []),
        Album(name: "cc", mbid: "3", url: "", artist: Artist(name: "c", mbid: "3", url: ""), images: []),
        Album(name: "dd", mbid: "4", url: "", artist: Artist(name: "d", mbid: "4", url: ""), images: []),
        Album(name: "ff", mbid: "5", url: "", artist: Artist(name: "f", mbid: "5", url: ""), images: [])
    ]
    
    let tracks = [
        Track(name: "aa", url: "", duration: "", artist: Artist(name: "a", mbid: "1", url: "")),
        Track(name: "bb", url: "", duration: "", artist: Artist(name: "a", mbid: "1", url: "")),
        Track(name: "cc", url: "", duration: "", artist: Artist(name: "a", mbid: "1", url: "")),
        Track(name: "dd", url: "", duration: "", artist: Artist(name: "a", mbid: "1", url: "")),
        Track(name: "ee", url: "", duration: "", artist: Artist(name: "a", mbid: "1", url: "")),
        Track(name: "ff", url: "", duration: "", artist: Artist(name: "a", mbid: "1", url: "")),
    ]
    
    let topTracks = [
        Track(name: "aa", url: "", duration: "", artist: Artist(name: "a", mbid: "1", url: "")),
        Track(name: "bb", url: "", duration: "", artist: Artist(name: "a", mbid: "1", url: "")),
        Track(name: "cc", url: "", duration: "", artist: Artist(name: "a", mbid: "1", url: "")),
    ]
    
    func getTopAlbums(tag: String, completion: @escaping ([Album], Error?) -> Void) {
        completion(albums, nil)
    }
    
    func getTracks(albumId: String, completion: @escaping ([Track], Error?) -> Void) {
        completion(tracks, nil)
    }
    
    func getTopTracks(artistId: String, completion: @escaping ([Track], Error?) -> Void) {
        completion(topTracks, nil)
    }
    
    func getTopTagsForArtist(artistId: String, completion: @escaping ([Tag], Error?) -> Void) {
        
    }
    
    func getSimilarArtists(artistId: String, completion: @escaping (_ tags: [Artist], _ error: Error?)->Void) {
        
    }
}
