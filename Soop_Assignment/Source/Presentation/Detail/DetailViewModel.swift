//
//  DetailViewModel.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/23.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: ViewModelBase {
    
    struct Input {
        let viewDidLoad: Driver<Void>
    }
    
    struct Output {
        let detailInfo: Driver<Result<DetailInfoModel, Error>>
        let isLoading: Signal<Bool>
    }
    
    private let appThumbnailModel: SearchThumbnailModel
    private let fetchDetailInfoUsecase: FetchDetailInfoUsecase
    private let isLoading: PublishRelay<Bool> = .init()
    var disposeBag: DisposeBag = DisposeBag()
    
    init(appThumbnailModel: SearchThumbnailModel, fetchDetailInfoUsecase: FetchDetailInfoUsecase) {
        self.appThumbnailModel = appThumbnailModel
        self.fetchDetailInfoUsecase = fetchDetailInfoUsecase
    }
    
    func transform(input: Input) -> Output {
        let load = input.viewDidLoad
            .do(onNext: { _ in
                self.isLoading.accept(true)
            })
            .flatMap { _ in
                self.fetchDetailInfoUsecase.excute(appId: self.appThumbnailModel.appId)
                    .map { (result) -> Result<DetailInfoEntity, Error> in
                        return Result.success(result)
                    }
                    .asDriver(onErrorRecover: { Driver.just(Result.failure($0))} )
            }
            .do(onNext: { _ in
                self.isLoading.accept(false)
            })
            .map { result -> Result<DetailInfoModel, Error> in
                switch result {
                case .success(let success):
                    let model = DetailInfoModel(detailEntity: success)
                    return Result.success(model)
                case .failure(let failure):
                    return Result.failure(failure)
                }
            }
            
        return .init(detailInfo: load, isLoading: isLoading.asSignal())
    }
}
