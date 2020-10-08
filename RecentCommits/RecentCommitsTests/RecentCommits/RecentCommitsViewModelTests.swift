//
//  RecentCommitsViewModelTests.swift
//  RecentCommitsTests
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation
import XCTest

@testable import RecentCommits

class RecentCommitsViewModelTests: XCTestCase {
    
    var subject: RecentCommitsViewModel!
    var fakeCommitsService: FakeCommitsService!
    
    override func setUp() {
        super.setUp()
        fakeCommitsService = FakeCommitsService()
        subject = RecentCommitsViewModel(commitsService: fakeCommitsService)
    }
    
    func testWhenFetchCommitsCalled() {
        // Given // When
        subject.fetchCommits(segment: .thisApp) { _ in }
        // Then
        XCTAssertTrue(fakeCommitsService.isFetchRecentCommitsCalled)
    }
    
    func testWhenfetchCommitsSucceeds() {
        // Given
        let model = CommitsModel(sha: "1234",
                                 commit: CommitsModel.Commit(author: CommitsModel.Commit.Author(name: "Name"),
                                                             message: "A message"))
        // When
        var receivedModels: [CommitsDisplayModel]?
        subject.fetchCommits(segment: .thisApp) { result in
            if case let .success(models) = result {
                receivedModels = models
            }
        }
        fakeCommitsService.fakeCompletion(.success([model]))
        // Then
        XCTAssertEqual(receivedModels?.first?.hash, "1234")
        XCTAssertEqual(receivedModels?.first?.authorName, "Name")
        XCTAssertEqual(receivedModels?.first?.message, "A message")
        
    }
}
