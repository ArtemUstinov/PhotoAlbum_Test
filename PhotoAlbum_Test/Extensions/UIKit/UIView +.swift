//
//  UIView +.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 02.02.2021.
//

import UIKit

extension UIView {
    
    func addConstraintWithFormat(format: String, views: [UIView]) {
        
        var viewDictionary: [String: UIView] = [:]
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(
                withVisualFormat: format,
                metrics: nil,
                views: viewDictionary
            )
        )
    }
}
