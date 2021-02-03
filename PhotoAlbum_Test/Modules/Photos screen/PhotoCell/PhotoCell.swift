//
//  PhotoCell.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 03.02.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    //MARK: - UI elements:
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .green
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    //MARK: - Override methods:
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        nameLabel.text = "HELLO!"
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 0.2
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath =
            UIBezierPath(roundedRect: contentView.bounds,
                         cornerRadius: contentView.layer.cornerRadius).cgPath
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Layout:
    private func setupLayout() {
        contentView.addSubview(mainView)
        mainView.addSubview(image)
        mainView.addSubview(titleView)
        titleView.addSubview(nameLabel)
        
        // H and V: mainView lines
        contentView.addConstraintWithFormat(format: "H:|[v0]|",
                                            views: [mainView])
        contentView.addConstraintWithFormat(format: "V:|[v0]|",
                                            views: [mainView])
        
        // H and V: image lines
        mainView.addConstraintWithFormat(format: "H:|[v0]|",
                                         views: [image])
        mainView.addConstraintWithFormat(format: "V:|[v0][v1]|",
                                         views: [image, titleView])

        // H: titleView lines
        mainView.addConstraintWithFormat(format: "H:|[v0]|",
                                         views: [titleView])
        
        // H and V: nameLabel lines
        titleView.addConstraintWithFormat(format: "H:|[v0]|",
                                          views: [nameLabel])
        titleView.addConstraintWithFormat(format: "V:|[v0]|",
                                          views: [nameLabel])
    }
}
