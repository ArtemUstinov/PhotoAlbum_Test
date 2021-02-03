//
//  PhotoCell.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 03.02.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    //MARK: - UI elements:
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
    
    private var photoImage =
        CoverImageView(contentMode: .scaleToFill)
    
    //MARK: - Override methods:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        activityIndicator.startAnimating()
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = nil
        nameLabel.text = nil
    }
    
    //MARK: - Configuration:
    func configuration(photo: Photo) {
        DispatchQueue.main.async {
            self.photoImage.fetchImage(from: photo.photo ?? "")
            self.nameLabel.text = photo.title
            self.activityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Setup Layout:
    private func setupLayout() {
        contentView.addSubview(mainView)
        mainView.addSubview(photoImage)
        mainView.addSubview(titleView)
        titleView.addSubview(nameLabel)
        mainView.addSubview(activityIndicator)
        
        // H and V: mainView lines
        contentView.addConstraintWithFormat(format: "H:|[v0]|",
                                            views: [mainView])
        contentView.addConstraintWithFormat(format: "V:|[v0]|",
                                            views: [mainView])
        
        // H and V: image lines
        mainView.addConstraintWithFormat(format: "H:|[v0]|",
                                         views: [photoImage])
        mainView.addConstraintWithFormat(format: "V:|[v0][v1]|",
                                         views: [photoImage, titleView])
        
        // H: titleView lines
        mainView.addConstraintWithFormat(format: "H:|[v0]|",
                                         views: [titleView])
        
        // H and V: nameLabel lines
        titleView.addConstraintWithFormat(format: "H:|[v0]|",
                                          views: [nameLabel])
        titleView.addConstraintWithFormat(format: "V:|[v0]|",
                                          views: [nameLabel])
        
        // activityIndicator
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(
                equalTo: centerXAnchor,
                constant: 0
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: 0
            )
        ])
    }
}
