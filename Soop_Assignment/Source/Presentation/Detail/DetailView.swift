//
//  DetailView.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/23.
//

import UIKit

final class DetailView: UIView {
    
    enum Metric {
        static let appNameLabelFontSize: CGFloat = 20
        static let defaultPadding: CGFloat = 20
    }

    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.addSubview(contentStackView)
        return scrollView
    }()
    
    private lazy var contentStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(headerStackView)
        stackView.addArrangedSubview(middleStackView)
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: - header
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .red
        stackView.spacing = 10
        stackView.alignment = .top
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
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: Metric.appNameLabelFontSize)
        return label
    }()
    
    private let appGenreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "액션"
         return label
    }()
    
    //MARK: - middle
    
    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(ratingStackView)
        stackView.addArrangedSubview(ageSubInfoView)
        return stackView
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(ratingStarView)
        stackView.addArrangedSubview(ratingInfoLabel)
        return stackView
    }()
    
    private let ratingStarView: RatingStarView = {
        let starView = RatingStarView(size: 15, color: .gray)
        return starView
    }()
    
    private let ratingInfoLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let ageSubInfoView: SubInfoView = {
       let view = SubInfoView()
        view.title = "연령"
        view.footerText = "세"
        return view
    }()
    
    private let screenshotCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDetailInfo(detailInfo: DetailInfoModel) {
        appNameLabel.text = detailInfo.appName
        ratingStarView.ratingScore = detailInfo.ratingScore
        ratingInfoLabel.text = String(format: "%.1f, ", detailInfo.ratingScore) + detailInfo.userRatingCount.countCutting() + "개의 평가"
        ageSubInfoView.middleText = detailInfo.age
    }
    
    private func configureView() {
        addSubview(scrollView)
    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        contentStackView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.top.bottom.equalToSuperview()
        }
        appLogoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(120)
        }
        headerStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(Metric.defaultPadding)
        }
    }
}
