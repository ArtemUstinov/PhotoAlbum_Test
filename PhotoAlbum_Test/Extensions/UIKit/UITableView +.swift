//
//  UITableView +.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 02.02.2021.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(
            withIdentifier: T.identifier,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier \(T.identifier)")
        }
        return cell
    }
    
    func register(_ cellType: UITableViewCell.Type) {
        register(cellType.self,
                 forCellReuseIdentifier: cellType.identifier)
    }
}
