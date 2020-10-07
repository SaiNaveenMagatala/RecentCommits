//
//  CommitsService.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation

protocol CommitsService {
    func fetchRecentCommits(completion: @escaping (Result<[CommitsModel], NetworkError>) -> Void)
}

class CommitsServiceImpl: CommitsService {
    
    let networkClient = NetworkClientImpl()
    private let fetchUrlStr = "https://api.github.com/repos/sainaveenmagatala/recentcommits/commits"
    private let newComms = "https://api.github.com/repos/TheAlgorithms/Python/commits"
    
    func fetchRecentCommits(completion: @escaping (Result<[CommitsModel], NetworkError>) -> Void) {
        networkClient.get(from: newComms, completion: completion)
    }
}
