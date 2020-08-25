//
//  DataBaseService.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class DataBaseService: DataBaseServiceInterface {
    static let shared = DataBaseService()
    var albums: [Album] = []
    
    private init() {}
    
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
            UserDefaults.standard.set(true, forKey: albumId)
        } else {
            UserDefaults.standard.removeObject(forKey: albumId)
        }
    }
    
    func isInFavourites(albumId: String) -> Bool {
        UserDefaults.standard.object(forKey: albumId) != nil
    }
}

//MARK: Database Interface
protocol DataBaseServiceInterface {
    var albums: [Album] { get set }
    func albumForId(albumId: String) -> Album?
    func setFavouriteStatus(albumId: String, status: Bool)
    func isInFavourites(albumId: String) -> Bool
}
