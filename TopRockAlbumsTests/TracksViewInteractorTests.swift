//
//  TracksViewInteractorTests.swift
//  TopRockAlbumsTests
//
//  Created by acon on 23/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest
@testable import TopRockAlbums

class TracksViewInteractorTests: XCTestCase {
    var tracksViewInteractor: TracksViewInteractor!
    
    override func setUp() {
        super.setUp()
        self.tracksViewInteractor = TracksViewInteractor(networkService: MockNetworkService(), dataBaseService: MockDataBaseService())
    }
   
    func testFetchTracks() {
        self.tracksViewInteractor.fetchTracks(albumId: "1") { (tracks, error) in
            XCTAssertEqual(tracks.count, 6)
        }
    }
    
    func testFetchTopTracks() {
        self.tracksViewInteractor.fetchTopTracks(artistId: "1") { (tracks, error) in
            XCTAssertEqual(tracks.count, 3)
        }
    }

}
