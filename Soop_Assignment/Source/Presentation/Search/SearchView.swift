//
//  SearchView.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    enum Metric {
        static let collectionViewInset = 20.0
    }

    lazy var searchResultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchResultCollectionView.collectionViewLayout = makeCollectionViewLayout()
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
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: bounds.width-2*(Metric.collectionViewInset), height: 300)
        return layout
    }
}
