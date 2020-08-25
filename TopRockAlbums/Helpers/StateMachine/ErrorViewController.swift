//
//  ErrorViewController.swift
//  TopRockAlbums
//
//  Created by acon on 22/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit


class ErrorViewController: UIViewController {
    class ViewModel {
        let errorMessage: String
        init(errorMessage: String) {
            self.errorMessage = errorMessage
        }
    }
    var viewModel: ViewModel? {
        didSet {
            if isViewLoaded {
                update()
            }
        }
    }
    var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let infoLabel = UILabel()
        view.addSubview(infoLabel)
        infoLabel.textColor = UIColor.red
        infoLabel.backgroundColor = .white
        infoLabel.font = UIFont.boldSystemFont(ofSize: 25)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            infoLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
        self.infoLabel = infoLabel
        update()
    }
    
    func update() {
        infoLabel.text = "\(NSLocalizedString(NSLocalizedString("Following error occurred:", comment: ""), comment: ""))\n\n\(viewModel?.errorMessage ?? "")"
    }
}
