//
//  HomeRouterTests.swift
//  TopRockAlbumsTests
//
//  Created by acon on 23/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest
@testable import TopRockAlbums

class HomeRouterTests: XCTestCase {
    var homeRouter: HomeRouter!
    
    override func setUp() {
        super.setUp()
        let nvc = UINavigationController()
        let homeModule = HomeRouter.build()
        if let homeVc = homeModule.viewController {
            nvc.pushViewController(homeVc, animated: false)
        }
        self.homeRouter = homeModule
    }
    
    func testNavigateToDetail() {
        self.homeRouter.navigateToDetail(albumId: "1", animated: false)
        XCTAssertTrue(self.homeRouter.viewController?.navigationController?.viewControllers.last is DetailViewController)
    }
}
