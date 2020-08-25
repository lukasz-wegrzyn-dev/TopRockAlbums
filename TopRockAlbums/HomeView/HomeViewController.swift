//
//  ViewController.swift
//  TopRockAlbums
//
//  Created by acon on 18/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var favouriteButton: UIButton!
    var presenter: HomePresenting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    func setupLayout() {
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "favourite")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonClicked), for: .touchUpInside)
        self.favouriteButton = button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
}

//MARK: Actions
extension HomeViewController {
    @objc func favouriteButtonClicked(_ button: UIButton) {
        presenter.favouriteButtonClicked(isSelected: !presenter.viewModel.isFavouriteFilterEnabled)
        updateData(viewModel: presenter.viewModel)
    }
}

//MARK: View model
extension HomeViewController {
    class ViewModel {
        let title: String
        var isFavouriteFilterEnabled: Bool
        var cells: [HomeCell.ViewModel]
        init(title: String, cells: [HomeCell.ViewModel] = [], isFavouriteFilterEnabled: Bool = false) {
            self.cells = cells
            self.isFavouriteFilterEnabled = isFavouriteFilterEnabled
            self.title = title
        }
    }
}

//MARK: Table view
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath)
        if let cell = cell as? HomeCell {
            let viewModel = presenter.viewModel.cells[indexPath.row]
            viewModel.rank = indexPath.row + 1
            cell.update(viewModel: viewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(index: indexPath)
    }
}

//MARK: Interface
protocol HomeViewing: class {
    func updateData(viewModel: HomeViewController.ViewModel)
}

extension HomeViewController: HomeViewing {
    func updateData(viewModel: HomeViewController.ViewModel) {
        guard isViewLoaded else { return }
        self.title = viewModel.title
        tableView.reloadData()
        favouriteButton.tintColor = viewModel.isFavouriteFilterEnabled ? UIColor(named: "cGold") : UIColor(named: "cGray")
    }
}
