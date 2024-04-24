//
//  DetailCollectionViewCell.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        contentView.addSubview(imageView)
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func configureCell(imagePath: String) {
        imageView.setImageFromImagePath(imagePath: imagePath)
    }
}
