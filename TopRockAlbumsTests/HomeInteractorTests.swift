//
//  HomeInteractorTests.swift
//  TopRockAlbumsTests
//
//  Created by acon on 23/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest
@testable import TopRockAlbums

class HomeInteractorTests: XCTestCase {
    
    var homeInteractor: HomeInteractor!
    
    override func setUp() {
        super.setUp()
        self.homeInteractor = HomeInteractor(networkService: MockNetworkService(), dataBaseService: MockDataBaseService())
    }
    
    func testFetchTopAlbums() {
        self.homeInteractor.fetchTopAlbums { (albums, error) in
            XCTAssertEqual(albums.count, 5)
        }
    }
    
    func testIsFavouriteAlbum() {
        XCTAssertEqual(self.homeInteractor.isFavouriteAlbum(albumId: "1"), true)
        XCTAssertEqual(self.homeInteractor.isFavouriteAlbum(albumId: "2"), false)
    }
    
    func testFavouriteAlbums() {
        self.homeInteractor.fetchTopAlbums { _, _ in }
        let albums = self.homeInteractor.favouriteAlbums()
        XCTAssertEqual(albums.count, 3)
    }
    
    func testAllAlbums(){
        self.homeInteractor.fetchTopAlbums { _, _ in }
        let albums = self.homeInteractor.allAlbums()
        XCTAssertEqual(albums.count, 5)
    }
}
