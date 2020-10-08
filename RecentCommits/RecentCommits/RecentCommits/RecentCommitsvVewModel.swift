//
//  RecentCommitsvVewModel.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation

class RecentCommitsViewModel {
    
    let commitsService: CommitsService
    
    init(commitsService: CommitsService = CommitsServiceImpl()) {
        self.commitsService = commitsService
    }
    
    func fetchCommits(segment: Segment,
                      completion: @escaping (Result<[CommitsDisplayModel], NetworkError>) -> Void) {
        commitsService.fetchRecentCommits(segment: segment) { result in
            switch result {
            case let .success(models):
                completion(.success(models.map { CommitsDisplayModel(authorName: $0.commit.author.name,
                                                                     hash: $0.sha,
                                                                     message: $0.commit.message)}))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
}
