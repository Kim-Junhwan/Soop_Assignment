//
//  SearchView.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import UIKit
import SnapKit

class SearchView: UIView {

    private let searchResultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(searchResultCollectionView)
    }
    
    private func setConstraints() {
        searchResultCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}
