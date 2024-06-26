//
//  SceneDIContainer.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

final class SceneDIContainer {
    
    private let domainDIContainer = DomainDIContainer()
    
    func makeSearchViewController() -> SearchViewController {
        let searchViewController = SearchViewController(viewModel: SearchViewModel(searchUsecase: domainDIContainer.searchUsecase), diContainer: self)
        return searchViewController
    }
    
    func makeDetailViewController(selectedThumbnail: SearchThumbnailModel) -> DetailViewController {
        let detailViewController = DetailViewController(viewModel: DetailViewModel(appThumbnailModel: selectedThumbnail, fetchDetailInfoUsecase: domainDIContainer.fetchDetailInfoUsecase))
        return detailViewController
    }
}
