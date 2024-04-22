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
        stackView.addArrangedSubview(middleStackView)
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
    
    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(ratingStackView)
        stackView.addArrangedSubview(developerStackView)
        return stackView
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.addArrangedSubview(ratingStarView)
        stackView.addArrangedSubview(ratingCountLabel)
        return stackView
    }()
    
    private let ratingStarView: RatingStarView = {
        let starView = RatingStarView(size: 15, color: .gray)
        return starView
    }()
    
    private let ratingCountLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    private lazy var developerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.addArrangedSubview(developerImageView)
        stackView.addArrangedSubview(developerNameLabel)
        return stackView
    }()
    
    private let developerImageView: UIImageView = {
        let imageView = UIImageView(image: .init(systemName: "person.crop.square"))
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let developerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 13)
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
        headerStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        middleStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        developerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(15)
        }
    }
    
    func configureCell(_ model: SearchThumbnailModel) {
        appNameLabel.text = model.appName
        appGenreLabel.text = model.genre
        ratingStarView.ratingScore = model.ratingScore
        ratingCountLabel.text = countCutting(model.userRatingCount)
        developerNameLabel.text = model.developerName
    }
    
    private func countCutting(_ count: Int) -> String {
        if count<1000 {
            return "\(count)"
        } else if count<10000 {
            let cuttingNum = Double(count)/1000
            return String(format:"%.1f천", cuttingNum)
        } else {
            let cuttingNum = Double(count)/10000
            return String(format:"%.1f만", cuttingNum)
        }
    }
}
