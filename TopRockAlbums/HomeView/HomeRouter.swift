//
//  HomeRouter.swift
//  TopRockAlbums
//
//  Created by acon on 18/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter {
    private weak var vc: UIViewController?
    var viewController: UIViewController? {
        return self.vc
    }
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    static func build() -> HomeRouter {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor(networkService: NetworkService(), dataBaseService: DataBaseService.shared)
        let router = HomeRouter(vc: vc)
        let presenter = HomePresenter(router: router,
                                      interactor: interactor,
                                      vc: vc)
        vc.presenter = presenter
        return router
    }
}

//MARK: Interface
protocol HomeRouting: class {
    func navigateToDetail(albumId: String, animated: Bool)
}

extension HomeRouter: HomeRouting {
    func navigateToDetail(albumId: String, animated: Bool = true) {
        let detailModule = DetailViewRouter.build(viewModel: DetailViewController.ViewModel(id: albumId))
        if let detailVc = detailModule.viewController {
            vc?.navigationController?.pushViewController(detailVc, animated: animated)
        }
    }
}
