//
//  TracksViewRouter.swift
//  TopRockAlbums
//
//  Created by acon on 21/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class TracksViewRouter {
    private weak var vc: UIViewController?
    var viewController: UIViewController? {
        return self.vc
    }
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    static func build(viewModel: TracksViewController.ViewModel) -> TracksViewRouter {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TracksViewController") as! TracksViewController
        let interactor = TracksViewInteractor(networkService: NetworkService(), dataBaseService: DataBaseService.shared)
        let router = TracksViewRouter(vc: vc)
        let presenter = TracksViewPresenter(router: router,
                                      interactor: interactor,
                                      vc: vc)
        presenter.viewModel = viewModel
        vc.presenter = presenter
        return router
    }
}

//MARK: Interface
protocol TracksViewRouting: class {
    func openTrackPage(trackUrl: String)
}

extension TracksViewRouter: TracksViewRouting {
    func openTrackPage(trackUrl: String) {
        if let url = URL(string: trackUrl) {
            UIApplication.shared.open(url)
        }
    }
}
