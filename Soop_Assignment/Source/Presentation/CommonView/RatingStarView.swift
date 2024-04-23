//
//  RatingStarView.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/22.
//

import UIKit

class RatingStarView: UIView {

    private lazy var starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        return stackView
    }()
    
    var ratingScore: Double = 0 {
        didSet {
            bind()
        }
    }
    
    private var stars: [UIImageView] = []
    let starSize: CGFloat
    let starColor: UIColor

    init(size: CGFloat, color: UIColor) {
        self.starSize = size
        self.starColor = color
        super.init(frame: .zero)
        setStars()
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(starStackView)
    }
    
    private func setConstraints() {
        starStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setStars() {
        for _ in 0..<5 {
            let imageView = UIImageView()
            stars.append(imageView)
            starStackView.addArrangedSubview(imageView)
            setStarImageConstraints(imageView: imageView)
        }
    }
    
    private func setStarImageConstraints(imageView: UIImageView) {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(starSize)
        }
        imageView.tintColor = starColor
    }
    
    private func bind() {
        var roundedNum = (ratingScore * 2).rounded()/2
        for i in 0..<5 {
            let imageView = stars[i]
            if roundedNum >= 1 {
                imageView.image = UIImage(systemName: "star.fill")
            } else if roundedNum == 0.5 {
                imageView.image = UIImage(systemName: "star.leadinghalf.filled")
            } else {
                imageView.image = UIImage(systemName: "star")
            }
            roundedNum -= 1
        }
    }
    
}
