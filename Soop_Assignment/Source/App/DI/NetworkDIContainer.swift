//
//  NetworkDIContainer.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

final class NetworkDIContainer {
    lazy var itunesRepository: ITunesRepository = {
        let repository = DefaultITunesRepository(dataTransferService: dataTransferService)
        return repository
    }()
    
    private lazy var dataTransferService = DataTransferService(networkService: networkService)
    
    private let networkService: NetworkService = {
       let networkService = DefaultNetworkService()
        return networkService
    }()
}
