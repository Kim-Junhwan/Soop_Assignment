//
//  ScreenshotCollectionViewDatasource.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import UIKit

class ScreenshotCollectionViewDatasource: NSObject {
    var imagePath: [String] = []
}

extension ScreenshotCollectionViewDatasource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagePath.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else { fatalError() }
        cell.configureCell(imagePath: imagePath[indexPath.row])
        return cell
    }
    
    
}
