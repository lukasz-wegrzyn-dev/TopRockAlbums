//
//  TracksViewPresenter.swift
//  TopRockAlbums
//
//  Created by acon on 21/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class TracksViewPresenter {
    private let router: TracksViewRouting
    private let interactor: TracksViewInteracting
    weak var vc: TracksViewing?
    var viewModel: TracksViewController.ViewModel = TracksViewController.ViewModel()
    private var stateMachine: StateMachine!
    
    init(router: TracksViewRouting, interactor: TracksViewInteracting, vc: TracksViewing) {
        self.router = router
        self.interactor = interactor
        self.vc = vc
        stateMachine = StateMachine(vc: vc as! UIViewController)
        stateMachine.didChanged = {[weak self] state in
            guard let weakSelf = self else { return }
            if state == .ready {
                weakSelf.vc?.updateData(viewModel: weakSelf.viewModel)
            }
        }
    }
    
    func loadData(completion: @escaping (_ trackCells: [TrackCell.ViewModel], _ error: Error?)->Void) {
        stateMachine.state = .loading
        if let albumId = viewModel.albumId {
            viewModel.albumTitle = interactor.albumTitleForId(albumId: albumId)
            interactor.fetchTracks(albumId: albumId) {(tracks, error) in
                let trackCells: [TrackCell.ViewModel] = tracks.map { track in
                    return TrackCell.ViewModel(track: track)
                }
                completion(trackCells, error)
            }
        }
        else if let artistId = viewModel.artistId {
            interactor.fetchTopTracks(artistId: artistId) {(tracks, error) in
                let trackCells: [TrackCell.ViewModel] = tracks.map { track in
                    return TrackCell.ViewModel(track: track)
                }
                completion(trackCells, error)
            }
        }
    }
}

//MARK: Interface
protocol TracksViewPresenting: class {
    var viewModel: TracksViewController.ViewModel { get }
    func viewDidLoad()
    func didSelectRow(index: IndexPath)
}

extension TracksViewPresenter: TracksViewPresenting {
    func viewDidLoad() {
        stateMachine.state = .loading
        loadData {[weak self] (trackCells, error) in
            self?.viewModel.cells = trackCells
            if let error = error {
                self?.stateMachine.state = .error(error: error)
            } else {
                self?.stateMachine.state = .ready
            }
        }
    }
    
    func didSelectRow(index: IndexPath) {
        let trackUrl = viewModel.cells[index.row].trackUrl
        self.router.openTrackPage(trackUrl: trackUrl)
    }
}
