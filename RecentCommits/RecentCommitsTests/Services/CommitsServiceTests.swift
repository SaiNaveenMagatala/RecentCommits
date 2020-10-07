//
//  CommitsServiceTests.swift
//  RecentCommitsTests
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation
import XCTest

@testable import RecentCommits

class CommitsServiceTests: XCTestCase {
    
    var subject: CommitsServiceImpl!
    
    override func setUp() {
        super.setUp()
        subject = CommitsServiceImpl()
    }
    
    func testWhenFetchingCommitsFromAPI() {
        let expectation = XCTestExpectation(description: "waiting to fetch commits")
        subject.fetchRecentCommits { result in
            switch result {
            case let .success(models):
                XCTAssertTrue(!models.isEmpty)
            case let .failure(error):
                XCTFail("fetch commits API failed with error \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
