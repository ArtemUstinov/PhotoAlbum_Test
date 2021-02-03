//
//  UserCell.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 02.02.2021.
//

import UIKit

class UserCell: UITableViewCell {
    
    func configuraton(from user: User?) {
        textLabel?.text = user?.name
    }

}
