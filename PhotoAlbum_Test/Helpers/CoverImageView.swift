//
//  CoverImageView.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 03.02.2021.
//

import UIKit

class CoverImageView: UIImageView {
    
    private let coverImageViewModel = CoverImageViewModel()
    
    //MARK: - Initializers:
    convenience init (
        contentMode: UIView.ContentMode
    ) {
        self.init()
        self.contentMode = contentMode
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    //MARK: - Public methods:
    func fetchImage(from url: String) {
        
        guard let url = URL(string: url) else {
            image = #imageLiteral(resourceName: "album-art-empty")
            return
        }
        
        if let cachedImage = coverImageViewModel.getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        coverImageViewModel.fetchImageData(from: url) {
            [weak self] imageData in
            DispatchQueue.main.async {
                self?.image = UIImage(data: imageData)
            }
        }
    }
}

