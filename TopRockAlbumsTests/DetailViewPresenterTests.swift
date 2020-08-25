//
//  DetailViewPresenterTests.swift
//  TopRockAlbumsTests
//
//  Created by acon on 23/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest
@testable import TopRockAlbums

class DetailViewPresenterTests: XCTestCase {
    var detailViewPresenter: DetailViewPresenter!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        let interactor = DetailViewInteractor(networkService: MockNetworkService(), dataBaseService: MockDataBaseService())
        let router = DetailViewRouter(vc: vc)
        let presenter = DetailViewPresenter(router: router,
                                      interactor: interactor,
                                      vc: vc)
        presenter.viewModel = DetailViewController.ViewModel(id: "1")
        vc.presenter = presenter
        self.detailViewPresenter = presenter
    }
    
    func testFavouriteClicked() {
        self.detailViewPresenter.favouriteButtonClicked(isSelected: true)
        XCTAssertEqual(self.detailViewPresenter.viewModel.isFavourite, true)
        self.detailViewPresenter.favouriteButtonClicked(isSelected: false)
        XCTAssertEqual(self.detailViewPresenter.viewModel.isFavourite, false)
    }
}
