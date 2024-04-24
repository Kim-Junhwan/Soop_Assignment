//
//  EmptyView.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import UIKit

final class EmptyView : UIView {
    
    private lazy var contentStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(emptyLabel)
        stackView.addArrangedSubview(searchTextLabel)
        return stackView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "결과 없음"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let searchTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    var searchWord: String = "" {
        didSet { searchTextLabel.text = searchWord }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        addSubview(contentStackView)
    }
    
    private func setConstraints() {
        backgroundColor = .systemBackground
        contentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
