//
//  NetworkService.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/23.
//

import Foundation

enum NetworkServiceError: Error {
    case responseError(statusCode: Int, data: Data?)
    case networkError(error: Error)
    case url
    
    var title: String {
        return "네트워크 에러"
    }
}

protocol NetworkService {
    func request(endPoint: URLRequestConvertable ,completion: @escaping (Result<Data?, NetworkServiceError>) -> Void) -> Cancellable?
}

final class DefaultNetworkService: NetworkService {
    func request(endPoint: URLRequestConvertable ,completion: @escaping (Result<Data?, NetworkServiceError>) -> Void) -> Cancellable? {
        do {
            let request = try endPoint.makeURLRequest()
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.networkError(error: error)))
                } else {
                    if let response = response as? HTTPURLResponse {
                        if (200..<300) ~= response.statusCode {
                            completion(.success(data))
                        } else {
                            completion(.failure(.responseError(statusCode: response.statusCode, data: data)))
                        }
                    }
                    
                }
            }
            task.resume()
            return task
        } catch {
            completion(.failure(.url))
            return nil
        }
    }
}

extension URLSessionTask: Cancellable {
    
}
