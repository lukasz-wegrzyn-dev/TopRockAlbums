//
//  DetailViewInteractor.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class DetailViewInteractor {
    private let networkService: NetworkServiceInterface
    private let dataBaseService: DataBaseServiceInterface
    
    init(networkService: NetworkServiceInterface, dataBaseService: DataBaseServiceInterface) {
        self.networkService = networkService
        self.dataBaseService = dataBaseService
    }
}

//MARK: Interface
protocol DetailViewInteracting: class {
    func setFavouriteStatus(albumId: String, status: Bool)
    func isFavouriteAlbum(albumId: String) -> Bool
    func albumForId(albumId: String) -> Album?
    func fetchArtistTopTags(artistId: String, completion: @escaping (_ tags: [Tag], _ error: Error?)->Void)
    func fetchSimilarArtists(artistId: String, completion: @escaping (_ artists: [Artist], _ error: Error?)->Void)
}

extension DetailViewInteractor: DetailViewInteracting {
    func setFavouriteStatus(albumId: String, status: Bool) {
        dataBaseService.setFavouriteStatus(albumId: albumId, status: status)
    }
    
    func isFavouriteAlbum(albumId: String) -> Bool {
        return self.dataBaseService.isInFavourites(albumId: albumId)
    }
    
    func albumForId(albumId: String) -> Album? {
        return dataBaseService.albumForId(albumId: albumId)
    }
    
    func fetchArtistTopTags(artistId: String, completion: @escaping (_ tags: [Tag], _ error: Error?)->Void) {
        networkService.getTopTagsForArtist(artistId: artistId) { (tags, error) in
            completion(tags, error)
        }
    }
    
    func fetchSimilarArtists(artistId: String, completion: @escaping (_ artists: [Artist], _ error: Error?)->Void) {
        networkService.getSimilarArtists(artistId: artistId) { (artists, error) in
            completion(artists, error)
        }
    }
    
}
