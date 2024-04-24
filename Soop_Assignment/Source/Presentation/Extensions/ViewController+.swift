//
//  ViewController+.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import UIKit

extension UIViewController {
    func errorAlert(error: Error) {
        let controller = UIAlertController(title: "에러", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        controller.addAction(ok)
        self.present(controller, animated: true)
    }
}
