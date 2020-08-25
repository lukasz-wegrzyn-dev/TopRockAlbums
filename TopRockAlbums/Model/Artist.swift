//
//  Artist.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class Artist: Parsable {
    enum CodingKeys: CodingKey {
        case name
        case mbid
        case url
    }
    let name: String
    let mbid: String?
    let url: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.mbid = try container.decodeIfPresent(String.self, forKey: .mbid)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        try super.init(from: decoder)
    }
    
    init(name: String, mbid: String, url: String) {
        self.name = name
        self.mbid = mbid
        self.url = url
        super.init()
    }
}

class SimilarArtists: Parsable {
    enum RootCodingKeys: CodingKey {
        case similarartists
    }
    enum ArtistListCodingKeys: CodingKey {
        case artist
    }
    let artists: [Artist]
    
    required init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: RootCodingKeys.self)
        let artistListContainer = try root.nestedContainer(keyedBy: ArtistListCodingKeys.self, forKey: .similarartists)
        self.artists = try artistListContainer.decode([Artist].self, forKey: .artist)
        try super.init(from: decoder)
    }
    
    init(artists: [Artist]) {
        self.artists = artists
        super.init()
    }
}
