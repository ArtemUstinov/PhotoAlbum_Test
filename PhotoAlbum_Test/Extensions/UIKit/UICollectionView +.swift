//
//  UICollectionView +.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 02.02.2021.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: T.identifier,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier \(T.identifier)")
        }
        return cell
    }
    
    func register(_ cellType: UICollectionViewCell.Type) {
        register(cellType.self,
                 forCellWithReuseIdentifier: cellType.identifier)
    }
}
