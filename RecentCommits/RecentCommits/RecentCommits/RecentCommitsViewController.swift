//
//  RecentCommitsViewController.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import UIKit

class RecentCommitsViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    private let viewModel = RecentCommitsViewModel()
    private let activityIndicator = UIActivityIndicatorView()
    private var displayModels: [CommitsDisplayModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.hideLoadingIndicator()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Recent Commits"
    }
    
    private func bindView() {
        tableView.dataSource = self
        tableView.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    private func bindViewModel() {
        showLoadingIndicator()
        viewModel.fetchCommits { [weak self] result in
            if case let .success(models) = result {
                self?.displayModels = models
            }
        }
    }
    
    private func showLoadingIndicator() {
        tableView.alpha = 0.7
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        tableView.alpha = 1
        activityIndicator.stopAnimating()
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
        cell.textLabel?.text = displayModels[indexPath.row].authorName.capitalized
        let shortHash = "#\(displayModels[indexPath.row].hash.lastFourChars)"
        cell.detailTextLabel?.text = displayModels[indexPath.row].message + shortHash
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}

private extension String {
    var lastFourChars: String {
        String(self.suffix(4))
    }
}

