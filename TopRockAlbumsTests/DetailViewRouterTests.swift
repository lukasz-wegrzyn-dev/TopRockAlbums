//
//  DetailViewRouterTests.swift
//  TopRockAlbumsTests
//
//  Created by acon on 23/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest
@testable import TopRockAlbums

class DetailViewRouterTests: XCTestCase {
    var detailViewRouter: DetailViewRouter!
    
    override func setUp() {
        super.setUp()
        let detailModule = DetailViewRouter.build(viewModel: DetailViewController.ViewModel())
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = detailModule.viewController
        self.detailViewRouter = detailModule
        
    }
    
    func testNavigateToTracksView() {
        self.detailViewRouter.navigateToTracksView(albumId: "1", animated: false)
        XCTAssertTrue(self.detailViewRouter.viewController?.presentedViewController is TracksViewController)
    }
    
    func testNavigateToTopTracksView() {
        self.detailViewRouter.navigateToTopTracksView(artistId: "1", animated: false)
        XCTAssertTrue(self.detailViewRouter.viewController?.presentedViewController is TracksViewController)
    }

}
