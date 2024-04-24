//
//  DetailViewController.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/23.
//

import UIKit
import RxCocoa
import RxSwift

class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    private let detailView = DetailView(frame: .zero)
    private let disposeBag = DisposeBag()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bind()
    }
    
    private func bind() {
        let viewDidLoadDriver = Driver<Void>.just(Void())
        let input = DetailViewModel.Input(viewDidLoad: viewDidLoadDriver)
        let output = viewModel.transform(input: input)
        output.isLoading.emit(with: self) { owner, isLoading in
            if isLoading {
                LoadingView.show()
            } else {
                LoadingView.hide()
            }
        }
        .disposed(by: disposeBag)
        
        output.detailInfo
            .drive(with: self) { owner, result in
                switch result {
                case .success(let fetchData):
                    owner.detailView.configureDetailInfo(detailInfo: fetchData)
                case .failure(let error):
                    owner.errorAlert(error: error)
                }
            }
            .disposed(by: disposeBag)
    }

}
