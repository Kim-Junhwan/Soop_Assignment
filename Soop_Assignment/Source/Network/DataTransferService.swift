//
//  DataTransferService.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/23.
//

import Foundation

enum DataTransferServiceError: Error {
    case parsing(error: Error)
    case noData
    case networkError(error: NetworkServiceError)
    case unknownStatusCode(statusCode: Int)
}

final class DataTransferService {
    private let networkService: NetworkService
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func request<T: Decodable> (endPoint: URLRequestConvertable, completion: @escaping (Result<T, Error>)-> Void) {
        networkService.request(endPoint: endPoint) { result in
            switch result {
            case .success(let data):
                completion(self.decode(data: data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?) -> Result<T, Error> {
        guard let data = data else { return .failure(DataTransferServiceError.noData) }
        do {
            let decoding = try jsonDecoder.decode(T.self, from: data)
            return .success(decoding)
        } catch {
            return .failure(DataTransferServiceError.parsing(error: error))
        }
    }
}
