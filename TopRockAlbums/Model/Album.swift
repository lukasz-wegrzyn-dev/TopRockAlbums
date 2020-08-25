//
//  Album.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class Album: Parsable {
    enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case url
        case artist
        case images = "image"
        case rank
    }
    let name: String
    let mbid: String
    let url: String
    let artist: Artist
    let images: [Image]
    var largeImageUrl: String? {
        return images.filter { (image) -> Bool in
            return image.size == "extralarge"
        }.first?.url
    }
    var albumId: String {
        return mbid
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.mbid = try container.decode(String.self, forKey: .mbid)
        self.url = try container.decode(String.self, forKey: .url)
        self.artist = try container.decode(Artist.self, forKey: .artist)
        self.images = try container.decode([Image].self, forKey: .images)
        try super.init(from: decoder)
    }
    
    init(name: String, mbid: String, url: String, artist: Artist, images: [Image]) {
        self.name = name
        self.mbid = mbid
        self.url = url
        self.artist = artist
        self.images = images
        super.init()
    }
}

class Albums: Parsable {
    enum RootCodingKeys: String, CodingKey {
        case albums
    }
    enum AlbumsListCodingKeys: String, CodingKey {
        case album
    }
    let albums: [Album]
    
    required init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: RootCodingKeys.self)
        let albumsContainer = try root.nestedContainer(keyedBy: AlbumsListCodingKeys.self, forKey: .albums)
        self.albums = try albumsContainer.decode([Album].self, forKey: .album)
        try super.init(from: decoder)
    }
    
    init(albums: [Album]) {
        self.albums = albums
        super.init()
    }
}
