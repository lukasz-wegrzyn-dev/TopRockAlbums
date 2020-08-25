//
//  Image.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class Image: Parsable {
    enum CodingKeys: String, CodingKey {
        case url = "#text"
        case size
    }
    let url: String
    let size: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.size = try container.decode(String.self, forKey: .size)
        try super.init(from: decoder)
    }
    
    init(url: String, size: String) {
        self.url = url
        self.size = size
        super.init()
    }
}
