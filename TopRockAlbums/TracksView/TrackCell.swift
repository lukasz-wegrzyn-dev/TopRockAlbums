//
//  TrackCell.swift
//  TopRockAlbums
//
//  Created by acon on 21/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class TrackCell: UITableViewCell {
    static let identifier: String = "TrackCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    func update(viewModel: ViewModel) {
        let attrStr = NSAttributedString.concat([
            NSAttributedString.bold(str: "\(viewModel.number).  ", fontSize: 17.0, color: .black),
            NSAttributedString.normal(str: "\(viewModel.title)", fontSize: 15.0, color: UIColor(named: "cBlue")!),
        ])
        self.titleLabel.attributedText = attrStr
        self.durationLabel.attributedText = NSAttributedString.bold(str: viewModel.duration ?? "", fontSize: 15.0)
    }
}

//MARK: View model
extension TrackCell {
    class ViewModel {
        var number: Int
        let title: String
        var duration: String? = nil
        let trackUrl: String
        
        init(number: Int = 0, title: String, duration: String, trackUrl: String) {
            let durationVal = Int(duration) ?? 0
            if durationVal > 0 {
                self.duration = TimeInterval(durationVal).formatted
            }
            self.number = number
            self.title = title
            self.trackUrl = trackUrl
        }
        
        convenience init(track: Track) {
            self.init(title: track.name, duration: track.duration ?? "", trackUrl: track.url)
        }
    }
}
