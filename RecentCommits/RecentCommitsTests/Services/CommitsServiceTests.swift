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
    
    func testWhenSuccessResponseReceived() {
        subject.fetchRecentCommits { result in
            
        }
    }
}
