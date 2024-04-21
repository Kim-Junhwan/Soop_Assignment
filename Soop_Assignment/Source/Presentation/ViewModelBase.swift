//
//  ViewModel.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/22.
//

import RxSwift

protocol ViewModelBase {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set}

    func transform(input: Input) -> Output
}
