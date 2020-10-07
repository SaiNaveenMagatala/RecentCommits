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
    private var displayModel = [CommitsDisplayModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func bindView() {
        
    }
    
    private func bindViewModel() {
        
    }


}

extension RecentCommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCommitsTableViewCell") else {
            return UITableViewCell()
        }
        return cell
    }
}

