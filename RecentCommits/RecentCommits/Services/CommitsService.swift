//
//  CommitsService.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation

protocol CommitsService {
    func fetchRecentCommits(segment: Segment,
                            completion: @escaping (Result<[CommitsModel], NetworkError>) -> Void)
}

class CommitsServiceImpl: CommitsService {
    
    let networkClient = NetworkClientImpl()
    private let rawURLStr = "https://api.github.com/repos/%@/%@/commits"
    
    func fetchRecentCommits(segment: Segment,
                            completion: @escaping (Result<[CommitsModel], NetworkError>) -> Void) {
        let urlStr = String(format: rawURLStr, segment.user, segment.repo)
        networkClient.get(from: urlStr, completion: completion)
    }
}
