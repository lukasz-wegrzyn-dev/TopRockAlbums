//
//  HomeCell.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class HomeCell: UITableViewCell {
    static let identifier: String = "HomeCell"
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var favouriteIndicator: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.clipsToBounds = true
        self.iconImageView.layer.cornerRadius = 5.0
        self.favouriteIndicator.image = UIImage(named: "favourite")?.withRenderingMode(.alwaysTemplate)
    }
    
    func update(viewModel: ViewModel) {
        self.titleLabel.text = "\(viewModel.rank). \(viewModel.title)"
        self.iconImageView.image = UIImage(named: "noimage")
        if let imageUrl = viewModel.imageUrl {
            self.iconImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "noimage"))
        }
        
        self.favouriteIndicator.tintColor = viewModel.isFavourite ? UIColor(named: "cGold") : UIColor(named: "cGray")
    }
}

//MARK: View model
extension HomeCell {
    class ViewModel {
        var rank: Int
        let albumId: String
        let title: String
        let imageUrl: String?
        var isFavourite: Bool
        
        init(albumId: String, title: String, image: String?, isFavourite: Bool, rank: Int = 0) {
            self.albumId = albumId
            self.title = title
            self.imageUrl = image
            self.isFavourite = isFavourite
            self.rank = rank
        }
        
        convenience init(album: Album, isFavourite: Bool) {
            self.init(albumId: album.albumId, title: album.name,
                      image: album.largeImageUrl, isFavourite: isFavourite)
        }
    }
}
