//
//  ErrorAlertController.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 03.02.2021.
//

import UIKit

class ErrorAlertController: UIAlertController {
    
    func show(with title: Error,
              completion: @escaping (UIAlertController) -> Void) {
        let alertController = UIAlertController(
            title: "No data",
            message: title.localizedDescription,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            completion(alertController)
        }
    }
}
