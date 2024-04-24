//
//  SubInfoView.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import UIKit

class SubInfoView: UIView {
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(middleLabel)
        stackView.addArrangedSubview(footerLabel)
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    private let middleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var middleText: String = "" {
        didSet {
            middleLabel.text = middleText
        }
    }
    
    var footerText: String = "" {
        didSet {
            footerLabel.text = footerText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(contentStackView)
    }
    
    private func setConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
