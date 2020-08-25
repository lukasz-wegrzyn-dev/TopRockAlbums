//
//  HomePresenter.swift
//  TopRockAlbums
//
//  Created by acon on 18/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter {
    private let router: HomeRouting
    private let interactor: HomeInteracting
    weak var vc: HomeViewing?
    var viewModel: HomeViewController.ViewModel = HomeViewController.ViewModel(title: NSLocalizedString("Top Rock Albums", comment: ""))
    private var stateMachine: StateMachine!
    
    init(router: HomeRouting, interactor: HomeInteracting, vc: HomeViewing) {
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
    
    func updateViewModel() {
        var albums: [Album] = []
        if viewModel.isFavouriteFilterEnabled {
            albums = interactor.favouriteAlbums()
        } else {
            albums = interactor.allAlbums()
        }
        self.viewModel.cells = albums.map { album in
            return HomeCell.ViewModel(album: album, isFavourite: self.interactor.isFavouriteAlbum(albumId: album.albumId))
        }
        vc?.updateData(viewModel: self.viewModel)
    }
}

//MARK: Interface
protocol HomePresenting: class {
    var viewModel: HomeViewController.ViewModel { get set }
    func viewDidLoad()
    func viewWillAppear()
    func didSelectRow(index: IndexPath)
    func favouriteButtonClicked(isSelected: Bool)
}

extension HomePresenter: HomePresenting {
    func viewDidLoad() {
        stateMachine.state = .loading
        interactor.fetchTopAlbums {[weak self] _, error in
            self?.updateViewModel()
            if let error = error {
                self?.stateMachine.state = .error(error: error)
            } else {
                self?.stateMachine.state = .ready
            }
        }
    }
    
    func viewWillAppear() {
        updateViewModel()
    }
    
    func didSelectRow(index: IndexPath) {
        let model = viewModel.cells[index.row]
        router.navigateToDetail(albumId: model.albumId, animated: true)
    }
    
    func favouriteButtonClicked(isSelected: Bool) {
        viewModel.isFavouriteFilterEnabled = isSelected
        updateViewModel()
    }
}
