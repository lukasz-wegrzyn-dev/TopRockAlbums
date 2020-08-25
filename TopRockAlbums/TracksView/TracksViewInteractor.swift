//
//  TracksViewInteractor.swift
//  TopRockAlbums
//
//  Created by acon on 21/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class TracksViewInteractor {
    private let networkService: NetworkServiceInterface
    private let dataBaseService: DataBaseServiceInterface
    
    init(networkService: NetworkServiceInterface, dataBaseService: DataBaseServiceInterface) {
        self.networkService = networkService
        self.dataBaseService = dataBaseService
    }
}

//MARK: Interface
protocol TracksViewInteracting: class {
    func fetchTracks(albumId: String, completion: @escaping (_ tracks: [Track], _ error: Error?)->Void)
    func fetchTopTracks(artistId: String, completion: @escaping (_ tracks: [Track], _ error: Error?) -> Void)
    func albumTitleForId(albumId: String) -> String
}

extension TracksViewInteractor: TracksViewInteracting {
    func fetchTracks(albumId: String, completion: @escaping ( _ tracks: [Track], _ error: Error?) -> Void) {
        networkService.getTracks(albumId: albumId) { tracks, error in
            completion(tracks, error)
        }
    }
    func fetchTopTracks(artistId: String, completion: @escaping (_ tracks: [Track], _ error: Error?) -> Void) {
        networkService.getTopTracks(artistId: artistId) { tracks, error in
            completion(tracks, error)
        }
    }
    func albumTitleForId(albumId: String) -> String {
        return dataBaseService.albumForId(albumId: albumId)?.name ?? ""
    }
}
