//
//  CommitsModel.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation

struct CommitsModel: Decodable {
    let sha: String
    let commit: Commit
    
    struct Commit: Decodable {
        let author: Author
        let message: String
        struct Author: Decodable {
            let name: String
        }
    }
}
