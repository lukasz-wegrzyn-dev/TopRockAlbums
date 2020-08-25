//
//  TracksViewPresenterTests.swift
//  TopRockAlbumsTests
//
//  Created by acon on 23/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest
@testable import TopRockAlbums

class TracksViewPresenterTests: XCTestCase {
    var tracksViewPresenter: TracksViewPresenter!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TracksViewController") as! TracksViewController
        let interactor = TracksViewInteractor(networkService: MockNetworkService(), dataBaseService: MockDataBaseService())
        let router = TracksViewRouter(vc: vc)
        let presenter = TracksViewPresenter(router: router,
                                      interactor: interactor,
                                      vc: vc)
        presenter.viewModel = TracksViewController.ViewModel()
        vc.presenter = presenter
        self.tracksViewPresenter = presenter
    }
    
    func testAlbumTracks() {
        self.tracksViewPresenter.viewModel = TracksViewController.ViewModel(albumId: "1")
        tracksViewPresenter.viewDidLoad()
        XCTAssertEqual(tracksViewPresenter.viewModel.cells.count, 6)
    }
    
    func testArtistTracks() {
        self.tracksViewPresenter.viewModel = TracksViewController.ViewModel(artistId: "1")
        tracksViewPresenter.viewDidLoad()
        XCTAssertEqual(tracksViewPresenter.viewModel.cells.count, 3)
    }
}
