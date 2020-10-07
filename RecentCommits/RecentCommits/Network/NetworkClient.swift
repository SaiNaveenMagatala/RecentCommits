//
//  NetworkClient.swift
//  RecentCommits
//
//  Created by Naveen Magatala on 10/7/20.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case backEndError
    case decodingError
}

protocol NetworkClient {
    func get<T>(from urlStr: String,
                completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable
}

class NetworkClientImpl: NetworkClient {
    func get<T>(from urlStr: String,
                 completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        guard let url = URL(string: urlStr) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completion(.failure(.backEndError))
                return
            }
            
            guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(object))
        }.resume()
    }
}
