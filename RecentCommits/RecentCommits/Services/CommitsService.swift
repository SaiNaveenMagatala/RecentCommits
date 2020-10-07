//
//  CommitsService.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation

protocol CommitsService {
    func fetchRecentCommits(completion: @escaping (Result<CommitsModel, NetworkError>) -> Void)
}

class CommitsServiceImpl {
    let networkClient = NetworkClientImpl()
    private let fetchUrlStr = "https://api.github.com/repos/sainaveenmagatala/recentcommits/commits"
    
    func fetchRecentCommits(completion: @escaping (Result<CommitsModel, NetworkError>) -> Void) {
        networkClient.get(from: fetchUrlStr, completion: completion)
    }
}
