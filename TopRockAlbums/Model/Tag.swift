//
//  Tag.swift
//  TopRockAlbums
//
//  Created by acon on 23/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class Tag: Parsable {
    enum CodingKeys: CodingKey {
        case count
        case name
        case url
    }
    
    let count: Int
    let name: String
    let url: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
        try super.init(from: decoder)
    }
    
    init(count: Int, name: String, url: String) {
        self.count = count
        self.name = name
        self.url = url
        super.init()
    }
}

class TopTags: Parsable {
    enum RootCodingKeys: CodingKey {
        case toptags
    }
    enum TagListCodingKeys: CodingKey {
        case tag
    }
    let tags: [Tag]
    
    required init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: RootCodingKeys.self)
        let tagListContainer = try root.nestedContainer(keyedBy: TagListCodingKeys.self, forKey: .toptags)
        self.tags = try tagListContainer.decode([Tag].self, forKey: .tag)
        try super.init(from: decoder)
    }
    
    init(tags: [Tag]) {
        self.tags = tags
        super.init()
    }
}
