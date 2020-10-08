//
//  FakeCommitsService.swift
//  RecentCommitsTests
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation

@testable import RecentCommits

class FakeCommitsService: CommitsService {
    
    var fakeCompletion: ((Result<[CommitsModel], NetworkError>) -> Void)!
    var isFetchRecentCommitsCalled = false
    
    func fetchRecentCommits(segment: Segment,
                            completion: @escaping (Result<[CommitsModel], NetworkError>) -> Void) {
        fakeCompletion = completion
        isFetchRecentCommitsCalled = true
    }
}
