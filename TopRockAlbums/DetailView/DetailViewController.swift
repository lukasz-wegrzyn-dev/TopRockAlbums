//
//  DetailViewController.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var showTracksButton: UIButton!
    @IBOutlet weak var topTracksButton: UIButton!
    var favouriteButton: UIButton!
    var presenter: DetailViewPresenting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter.viewDidLoad()
    }
    
    func setupLayout() {
        imageView.layer.cornerRadius = 5.0
        imageView.image = UIImage(named: "noimage")
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1.0
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "favourite")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonClicked), for: .touchUpInside)
        self.favouriteButton = button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(albumImageTapped))
        imageView.addGestureRecognizer(recognizer)
        topTracksButton.titleLabel?.numberOfLines = 0
        topTracksButton.titleLabel?.textAlignment = .center
    }
}

//MARK: Actions
extension DetailViewController {
    @objc func favouriteButtonClicked(_ button: UIButton) {
        presenter.favouriteButtonClicked(isSelected: !presenter.viewModel.isFavourite)
        updateData(viewModel: presenter.viewModel)
    }
    
    @IBAction func showTracksButtonClicked(_ sender: UIButton) {
        presenter.showTracksClicked()
    }
    
    @IBAction func topTracksButtonClicked(_ sender: UIButton) {
        presenter.showTopTracksClicked()
    }
    
    @objc func albumImageTapped(_ recognizer: UITapGestureRecognizer) {
        presenter.albumImageClicked()
    }
}

//MARK: View model
extension DetailViewController {
    class ViewModel {
        let id: String
        var albumId: String?
        var imageStr: String?
        var title: String?
        var artistName: String?
        var artistUrl: String?
        var artistId: String?
        var isFavourite: Bool
        var artistTopTags: String? = nil
        var similarArtists: String? = nil
        
        init(id: String = "", albumId: String = "",
             imageStr: String? = nil,
             isFavourite: Bool = false,
             artistName: String? = "",
             artistUrl: String? = "",
             artistId: String? = "") {
            
            self.id = id
            self.imageStr = imageStr
            self.isFavourite = isFavourite
            self.albumId = albumId
            self.artistName = artistName
            self.artistUrl = artistUrl
            self.artistId = artistId
        }
    }
}

//MARK: Interface
protocol DetailViewing: class {
    func updateData(viewModel: DetailViewController.ViewModel)
}

extension DetailViewController: DetailViewing {
    func updateData(viewModel: DetailViewController.ViewModel) {
        if let urlStr = viewModel.imageStr, let url = URL(string: urlStr) {
            self.imageView.load(url: url)
            let attrStr = NSAttributedString.concat([
                NSAttributedString.normal(str: "\(NSLocalizedString("ALBUM", comment: ""))\n", fontSize: 15.0, color: .gray),
                NSAttributedString.bold(str: "\(viewModel.title ?? "")\n\n", fontSize: 20.0),
                NSAttributedString.normal(str: "\(NSLocalizedString("ARTIST", comment: ""))\n", fontSize: 15.0, color: .gray),
                NSAttributedString.bold(str: "\(viewModel.artistName ?? "")\n\n", fontSize: 20.0),
                NSAttributedString.normal(str: "\(NSLocalizedString("TAGS", comment: ""))\n", fontSize: 15.0, color: .gray),
                NSAttributedString.normal(str: "\(viewModel.artistTopTags ?? "")\n\n", fontSize: 20.0, color: UIColor(named: "cBlue")!),
                NSAttributedString.normal(str: "\(NSLocalizedString("SIMILAR ARTISTS", comment: ""))\n", fontSize: 15.0, color: .gray),
                NSAttributedString.normal(str: "\(viewModel.similarArtists ?? "")\n", fontSize: 20.0, color: UIColor(named: "cBlue")!),
            ])
            self.titleLabel.attributedText = attrStr
            favouriteButton.tintColor = viewModel.isFavourite ? UIColor(named: "cGold") : UIColor(named: "cGray")
            topTracksButton.setTitle(
                "\(NSLocalizedString("Top", comment: "")) \(viewModel.artistName ?? "") \(NSLocalizedString("Tracks", comment: ""))",
                for: .normal
            )
        }
    }
}
