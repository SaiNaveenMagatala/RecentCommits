//
//  RecentCommitsViewController.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import UIKit

class RecentCommitsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private let viewModel = RecentCommitsViewModel()
    private var displayModels: [CommitsDisplayModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
    }
    
    private func bindView() {
        tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.fetchCommits { [weak self] result in
            if case let .success(models) = result {
                self?.displayModels = models
            }
        }
    }


}

extension RecentCommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCommitsTableViewCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = displayModels[indexPath.row].message
        cell.textLabel?.numberOfLines = 2
        cell.detailTextLabel?.text = displayModels[indexPath.row].hash
        return cell
    }
}

