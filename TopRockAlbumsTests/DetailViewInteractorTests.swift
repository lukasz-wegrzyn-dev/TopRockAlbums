//
//  DetailViewInteractorTests.swift
//  TopRockAlbumsTests
//
//  Created by acon on 23/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest
@testable import TopRockAlbums

class DetailViewInteractorTests: XCTestCase {
    var detailViewInteractor: DetailViewInteractor!
    
    override func setUp() {
        super.setUp()
        self.detailViewInteractor = DetailViewInteractor(networkService: MockNetworkService(), dataBaseService: MockDataBaseService())
    }
    
    func testSetFavouriteStatus() {
        self.detailViewInteractor.setFavouriteStatus(albumId: "1", status: false)
        XCTAssertEqual(self.detailViewInteractor.isFavouriteAlbum(albumId: "1"), false)
        
        self.detailViewInteractor.setFavouriteStatus(albumId: "1", status: true)
        XCTAssertEqual(self.detailViewInteractor.isFavouriteAlbum(albumId: "1"), true)
    }
}
