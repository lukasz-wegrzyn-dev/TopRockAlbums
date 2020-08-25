//
//  LoadingViewController.swift
//  TopRockAlbums
//
//  Created by acon on 22/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = UIColor.black
        activity.startAnimating()
        view.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])
        let infoLabel = UILabel()
        view.addSubview(infoLabel)
        infoLabel.textColor = UIColor.black
        infoLabel.backgroundColor = .white
        infoLabel.font = UIFont.boldSystemFont(ofSize: 25)
        infoLabel.text = NSLocalizedString("Loading...", comment: "")
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: activity.topAnchor, constant: -10),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
}
