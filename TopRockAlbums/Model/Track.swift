//
//  Track.swift
//  TopRockAlbums
//
//  Created by acon on 21/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class Track: Parsable {
    enum CodingKeys: CodingKey {
        case name
        case url
        case duration
        case artist
    }
    
    let name: String
    let url: String
    let duration: String?
    let artist: Artist
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.artist = try container.decode(Artist.self, forKey: .artist)
        try super.init(from: decoder)
    }
    
    init(name: String, url: String, duration: String, artist: Artist) {
        self.name = name
        self.url = url
        self.duration = duration
        self.artist = artist
        super.init()
    }
}

class Tracks: Parsable {
    enum RootCodingKeys: CodingKey {
        case album
    }
    enum TracksCodingKeys: CodingKey {
        case tracks
    }
    enum TracksListCodingKeys: CodingKey {
        case track
    }
    
    let tracks: [Track]
    required init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: RootCodingKeys.self)
        let tracksContainer = try root.nestedContainer(keyedBy: TracksCodingKeys.self, forKey: .album)
        let tracksList = try tracksContainer.nestedContainer(keyedBy: TracksListCodingKeys.self, forKey: .tracks)
        self.tracks = try tracksList.decode([Track].self, forKey: .track)
        try super.init(from: decoder)
    }
    
    init(tracks: [Track]) {
        self.tracks = tracks
        super.init()
    }
}

class TopTracks: Parsable {
    enum RootCodingKeys: CodingKey {
        case toptracks
    }
    enum TracksListCodingKeys: CodingKey {
        case track
    }
    
    let tracks: [Track]
    required init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: RootCodingKeys.self)
        let tracksList = try root.nestedContainer(keyedBy: TracksListCodingKeys.self, forKey: .toptracks)
        self.tracks = try tracksList.decode([Track].self, forKey: .track)
        try super.init(from: decoder)
    }
    
    init(tracks: [Track]) {
        self.tracks = tracks
        super.init()
    }
}
