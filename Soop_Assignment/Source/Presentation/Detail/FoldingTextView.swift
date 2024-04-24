//
//  FoldingTextView.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import UIKit

class FoldingTextView: UIView {
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.textContainer.maximumNumberOfLines = 3
        textView.font = .systemFont(ofSize: 15)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textContainer.lineBreakMode = .byTruncatingTail
        return textView
    }()
    
    private lazy var foldButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .systemBlue
        config.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let button = UIButton(configuration: config)
        button.setTitle("더보기", for: .normal)
        button.setTitle("접기", for: .selected)
        button.addTarget(self, action: #selector(tapFoldButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    func insertText(_ text: String) {
        textView.text = text
    }
    
    private func configureView() {
        addSubview(textView)
        addSubview(foldButton)
    }
    
    private func setConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        foldButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapFoldButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        if foldButton.isSelected{
            textView.textContainer.maximumNumberOfLines = 0
        } else {
            textView.textContainer.maximumNumberOfLines = 3
        }
        self.textView.invalidateIntrinsicContentSize()
    }
}
