//
//  RecentCommitsViewController.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import UIKit

enum Segment: Int {
    case thisApp
    case pythonAlgos
    
    var title: String {
        switch self {
        case .thisApp:
            return "This App"
        case .pythonAlgos:
            return "Algorithms in Python"
        }
    }
    
    var user: String {
        switch self {
        case .thisApp:
            return "sainaveenmagatala"
        case .pythonAlgos:
            return "TheAlgorithms"
        }
    }
    
    var repo: String {
        switch self {
        case .thisApp:
            return "recentcommits"
        case .pythonAlgos:
            return "Python"
        }
    }
}

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
        fetchCommits(segment: .thisApp)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Recent Commits"
    }
    
    private func bindView() {
        tableView.dataSource = self
        tableView.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        segmentControl.setTitle(Segment.thisApp.title, forSegmentAt: 0)
        segmentControl.setTitle(Segment.pythonAlgos.title, forSegmentAt: 1)
    }
    
    private func fetchCommits(segment: Segment) {
        showLoadingIndicator()
        viewModel.fetchCommits(segment: segment) { [weak self] result in
            if case let .success(models) = result {
                self?.displayModels = models
            }
        }
    }
    
    private func showLoadingIndicator() {
        tableView.alpha = 0.7
        activityIndicator.startAnimating()
    }
    
    @IBAction func valueChangedForSegment(_ sender: UISegmentedControl) {
        fetchCommits(segment: Segment(rawValue: sender.selectedSegmentIndex) ?? .thisApp)
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
        let hash = "\n\(displayModels[indexPath.row].hash)"
        cell.detailTextLabel?.text = displayModels[indexPath.row].message + hash
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}

