//
//  HomeInteractor.swift
//  TopRockAlbums
//
//  Created by acon on 18/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class HomeInteractor {
    private var networkService: NetworkServiceInterface
    private var dataBaseService: DataBaseServiceInterface
    
    init(networkService: NetworkServiceInterface, dataBaseService: DataBaseServiceInterface) {
        self.networkService = networkService
        self.dataBaseService = dataBaseService
    }
}

//MARK: Interface
protocol HomeInteracting: class {
    func fetchTopAlbums(completion: ((_ tracks: [Album], _ error: Error?)->Void)?)
    func isFavouriteAlbum(albumId: String) -> Bool
    func favouriteAlbums() -> [Album]
    func allAlbums() -> [Album]
}

extension HomeInteractor: HomeInteracting {
    func fetchTopAlbums(completion: ((_ tracks: [Album], _ error: Error?)->Void)?){
        self.networkService.getTopAlbums(tag: "rock") {[weak self] (albums, error) in
            let validAlbums = albums.filter { (album) -> Bool in
                return !album.mbid.isEmpty
            }
            self?.dataBaseService.albums = validAlbums
            completion?(validAlbums, error)
        }
    }
    func isFavouriteAlbum(albumId: String) -> Bool {
        return self.dataBaseService.isInFavourites(albumId: albumId)
    }
    
    func favouriteAlbums() -> [Album] {
        return dataBaseService.albums.filter { (album) -> Bool in
            return isFavouriteAlbum(albumId: album.albumId)
        }
    }
    
    func allAlbums() -> [Album] {
        return dataBaseService.albums
    }
}
