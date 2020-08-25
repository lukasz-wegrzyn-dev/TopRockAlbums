//
//  HomePresenterTests.swift
//  TopRockAlbumsTests
//
//  Created by acon on 22/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest
@testable import TopRockAlbums

class HomePresenterTests: XCTestCase {
    var homePresenter: HomePresenter!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor(networkService: MockNetworkService(), dataBaseService: MockDataBaseService())
        let router = HomeRouter(vc: vc)
        let presenter = HomePresenter(router: router,
                                      interactor: interactor,
                                      vc: vc)
        vc.presenter = presenter
        self.homePresenter = presenter
    }
    
    func testInitialViewModel() {
        homePresenter.viewDidLoad()
        XCTAssertEqual(homePresenter.viewModel.cells.count, 5)
    }
    func testFavouritesSelected() {
        homePresenter.viewDidLoad()
        homePresenter.favouriteButtonClicked(isSelected: true)
        XCTAssertEqual(homePresenter.viewModel.cells.count, 3)
    }
    
    func testFavouritesUnselected() {
        homePresenter.viewDidLoad()
        homePresenter.favouriteButtonClicked(isSelected: true)
        homePresenter.favouriteButtonClicked(isSelected: false)
        XCTAssertEqual(homePresenter.viewModel.cells.count, 5)
    }
}
