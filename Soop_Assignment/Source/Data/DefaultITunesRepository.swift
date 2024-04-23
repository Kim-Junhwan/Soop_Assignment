//
//  DefaultITunesRepository.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

final class DefaultITunesRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultITunesRepository: ITunesRepository {
    func fetchSearchResultList(query: SearchQuery, completion: @escaping (Result<[SearchResultThumbnailEntity], Error>) -> Void) -> Cancellable? {
        let requestDTO = SearchRequestDTO(term: query.searchWord, offset: query.offset)
        return dataTransferService.request(endPoint: ITunesRouter.search(requestDTO)) { (result: Result<SearchResponseDTO, Error>) in
            switch result {
            case .success(let searchResult):
                completion(.success(searchResult.toDomain()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchDetailInfo(query: FetchDetailInfoQuery, completion: @escaping (Result<DetailInfoEntity, Error>) -> Void) -> Cancellable? {
        let requestDTO = FetchDetailInfoRequestDTO(id: query.appId)
        return dataTransferService.request(endPoint: ITunesRouter.fetchDetailInfo(requestDTO)) { (result: Result<DetailResponseDTO, Error>) in
            switch result {
            case .success(let searchResult):
                do {
                    let entity = try searchResult.toDomain()
                    completion(.success(entity))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
}
