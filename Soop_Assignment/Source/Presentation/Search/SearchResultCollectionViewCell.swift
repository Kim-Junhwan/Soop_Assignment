//
//  SearchResultCollectionViewCell.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/22.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchResultCollectionViewCell"
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(headerStackView)
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(appLogoImageView)
        stackView.addArrangedSubview(headerMiddleStackView)
        return stackView
    }()
    
    private lazy var headerMiddleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(appNameLabel)
        stackView.addArrangedSubview(appGenreLabel)
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let appGenreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13)
         return label
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
        contentView.addSubview(contentStackView)
    }
    
    private func setConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        appLogoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
    }
    
    func configureCell(_ model: SearchThumbnailModel) {
        appNameLabel.text = model.appName
        appGenreLabel.text = model.genre
    }
}
