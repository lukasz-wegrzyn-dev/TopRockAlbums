//
//  TimeInterval+Extensions.swift
//  TopRockAlbums
//
//  Created by acon on 22/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

extension TimeInterval {
    var formatted: String {
        var durationString = "00:00"
        let seconds = Int(self) % 60
        let minutes = Int(self) / 60
        durationString = "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        return durationString
    }
}
