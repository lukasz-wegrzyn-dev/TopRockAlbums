//
//  TracksViewController.swift
//  TopRockAlbums
//
//  Created by acon on 21/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

class TracksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var presenter: TracksViewPresenting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        presenter.viewDidLoad()
    }
}

//MARK: View model
extension TracksViewController {
    class ViewModel {
        let artistId: String?
        let albumId: String?
        var albumTitle: String?
        var cells: [TrackCell.ViewModel]
        
        init(albumId: String? = nil, artistId: String? = nil, albumTitle: String? = nil, cells: [TrackCell.ViewModel] = []) {
            self.cells = cells
            self.albumId = albumId
            self.albumTitle = albumTitle
            self.artistId = artistId
        }
    }
}

//MARK: Table view
extension TracksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.identifier, for: indexPath)
        if let cell = cell as? TrackCell {
            let viewModel = presenter.viewModel.cells[indexPath.row]
            viewModel.number = indexPath.row + 1
            cell.update(viewModel: viewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(index: indexPath)
    }
}

//MARK: Interface
protocol TracksViewing: class {
    func updateData(viewModel: TracksViewController.ViewModel)
}

extension TracksViewController: TracksViewing {
    func updateData(viewModel: TracksViewController.ViewModel) {
        tableView.reloadData()
        titleLabel.attributedText = NSAttributedString.bold(str: "\(viewModel.albumTitle ?? NSLocalizedString("Top Tracks", comment: ""))", fontSize: 25)
    }
}
