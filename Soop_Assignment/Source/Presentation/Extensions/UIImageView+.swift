//
//  UIImageView+.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromImagePath(imagePath: String) {
        if let image = ImageCacheManager.shared.checkProfileImageInCache(imageURL: imagePath) {
            self.image = image
            return
        }
        guard let url = URL(string: imagePath) else { return }
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10.0
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            let fetchImage: UIImage?
            if error != nil {
                fetchImage = UIImage(systemName: "xmark")
            } else {
                guard let data, let safeImage = UIImage(data: data) else { return }
                fetchImage = UIImage(data: data)
                DispatchQueue.main.async {
                    ImageCacheManager.shared.cache.setObject(safeImage, forKey: imagePath as NSString)
                    self.image = fetchImage
                }
            }
        }.resume()
    }
}
