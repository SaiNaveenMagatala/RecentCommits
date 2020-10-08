//
//  Segment.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation

enum Segment: Int {
    case thisApp
    case pythonAlgos
    
    var title: String {
        switch self {
        case .thisApp:
            return "This App"
        case .pythonAlgos:
            return "Algorithms in Python"
        }
    }
    
    var user: String {
        switch self {
        case .thisApp:
            return "sainaveenmagatala"
        case .pythonAlgos:
            return "TheAlgorithms"
        }
    }
    
    var repo: String {
        switch self {
        case .thisApp:
            return "recentcommits"
        case .pythonAlgos:
            return "Python"
        }
    }
}
