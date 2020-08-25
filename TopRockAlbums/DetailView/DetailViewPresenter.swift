//
//  DetailViewPresenter.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class DetailViewPresenter {
    private let router: DetailViewRouting
    private let interactor: DetailViewInteracting
    weak var vc: DetailViewing?
    var viewModel: DetailViewController.ViewModel = DetailViewController.ViewModel()
    
    init(router: DetailViewRouting, interactor: DetailViewInteracting, vc: DetailViewing) {
        self.router = router
        self.interactor = interactor
        self.vc = vc
    }
    
    func updateViewModel() {
        if let album = interactor.albumForId(albumId: viewModel.id) {
            viewModel.imageStr = album.largeImageUrl
            viewModel.title = album.name
            viewModel.isFavourite = self.interactor.isFavouriteAlbum(albumId: album.albumId)
            viewModel.albumId = album.mbid
            viewModel.artistName = album.artist.name
            viewModel.artistUrl = album.artist.url
            viewModel.artistId = album.artist.mbid
        }
        vc?.updateData(viewModel: self.viewModel)
    }
}

//MARK: Interface
protocol DetailViewPresenting: class {
    var viewModel: DetailViewController.ViewModel { get }
    func viewDidLoad()
    func favouriteButtonClicked(isSelected: Bool)
    func showTracksClicked()
    func showTopTracksClicked()
    func albumImageClicked()
}

extension DetailViewPresenter: DetailViewPresenting {
    func viewDidLoad() {
        updateViewModel()
        if let artistId = viewModel.artistId {
            self.interactor.fetchArtistTopTags(artistId: artistId) {[weak self] (tags, error) in
                self?.viewModel.artistTopTags = tags.map { $0.name }.prefix(3).joined(separator: ", ")
                self?.updateViewModel()
            }
            
            self.interactor.fetchSimilarArtists(artistId: artistId) {[weak self] (artists, error) in
                self?.viewModel.similarArtists = artists.map{ $0.name }.prefix(3).joined(separator: ", ")
                self?.updateViewModel()
            }
        }
    }
    
    func favouriteButtonClicked(isSelected: Bool) {
        viewModel.isFavourite = isSelected
        self.interactor.setFavouriteStatus(albumId: viewModel.id, status: isSelected)
        updateViewModel()
    }
    
    func showTracksClicked() {
        if let albumId = viewModel.albumId {
            router.navigateToTracksView(albumId: albumId, animated: true)
        }
    }
    
    func showTopTracksClicked() {
        if let artistId = viewModel.artistId {
            self.router.navigateToTopTracksView(artistId: artistId, animated: true)
        }
    }
    
    func albumImageClicked() {
        if let artistUrl = viewModel.artistUrl {
            self.router.openArtistPage(artistUrl: artistUrl)
        }
    }
}
