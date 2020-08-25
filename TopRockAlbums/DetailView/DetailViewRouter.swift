//
//  DetailViewRouter.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class DetailViewRouter {
    private weak var vc: UIViewController?
    var viewController: UIViewController? {
        return self.vc
    }
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    static func build(viewModel: DetailViewController.ViewModel) -> DetailViewRouter {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        let interactor = DetailViewInteractor(networkService: NetworkService(), dataBaseService: DataBaseService.shared)
        let router = DetailViewRouter(vc: vc)
        let presenter = DetailViewPresenter(router: router,
                                      interactor: interactor,
                                      vc: vc)
        presenter.viewModel = viewModel
        vc.presenter = presenter
        return router
    }
}

//MARK: Interface
protocol DetailViewRouting: class {
    func navigateToTracksView(albumId: String, animated: Bool)
    func navigateToTopTracksView(artistId: String, animated: Bool)
    func openArtistPage(artistUrl: String)
}

extension DetailViewRouter: DetailViewRouting {
    func navigateToTracksView(albumId: String, animated: Bool = true) {
        let tracksModule = TracksViewRouter.build(viewModel: TracksViewController.ViewModel(albumId: albumId))
        if let tracksVc = tracksModule.viewController {
            vc?.present(tracksVc, animated: animated, completion: nil)
        }
    }
    
    func navigateToTopTracksView(artistId: String, animated: Bool = true) {
        let tracksModule = TracksViewRouter.build(viewModel: TracksViewController.ViewModel(artistId: artistId))
        if let tracksVc = tracksModule.viewController {
            vc?.present(tracksVc, animated: animated, completion: nil)
        }
    }
    
    func openArtistPage(artistUrl: String) {
        if let url = URL(string: artistUrl) {
            UIApplication.shared.open(url)
        }
    }
}
