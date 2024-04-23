//
//  ITunesRouter.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

enum ITunesRouter: URLRequestConvertable {
    
    case search(SearchRequestDTO)
    case fetchDetailInfo(FetchDetailInfoRequestDTO)
    
    var baseURL: String {
        guard let baseURL = Bundle.main.infoDictionary?["ITUNES_BASE_API"] as? String else { fatalError("cannot found api base url") }
        return baseURL
    }
    
    var httpHeader: [String: String] {
        return ["Content-type": "application/json", "Accept": "application/json"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .search(_):
            return .get
        case .fetchDetailInfo(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search(_):
            return "/search"
        case .fetchDetailInfo(_):
            return "/lookup"
        }
    }
    
    private func makeURL() throws -> URL {
        guard var urlComponents = URLComponents(string: baseURL+path) else { fatalError("Cannot create api url") }
        switch self {
        case .search(let searchRequestDTO):
            urlComponents.queryItems = try makeQueryItem(searchRequestDTO)
        case .fetchDetailInfo(let fetchDetailInfoDTO):
            urlComponents.queryItems = try makeQueryItem(fetchDetailInfoDTO)
        }
        guard let url = urlComponents.url else { fatalError("cannot make query items") }
        return url
    }
    
    private func makeQueryItem(_ encode: Encodable) throws -> [URLQueryItem] {
        let data = try JSONEncoder().encode(encode)
        guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { fatalError() }
        var queryItems: [URLQueryItem] = []
        queryItems += dict.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        return queryItems
    }
    
    func makeURLRequest() throws -> URLRequest {
        var request = URLRequest(url: try makeURL())
        request.httpMethod = method.value
        request.allHTTPHeaderFields = httpHeader
        return request
    }
}
