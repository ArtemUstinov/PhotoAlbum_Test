//
//  PhotosViewController.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 02.02.2021.
//

import UIKit

class PhotosViewController: UIViewController {
    
    //MARK: - UI elements:
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView =
            UICollectionView(frame: .zero,
                             collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    private let networkManager = NetworkManager()
    private var albumData: [Album]?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupLayout()
    }
    
    //MARK: - Setup CollectionView:
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCell.self)
    }
    
    //MARK: - GetData:
    func getData(for user: User?) {
        networkManager.fetchDataAlbum {
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let data = data?.filter ({ $0.userId == user?.id })
                self.albumData = data
            case .failure(let error):
                print(error.localizedDescription) //!
            }
        }
    }
    
    //MARK: - Setup layout:
    private func setupLayout() {
        view.addSubview(collectionView)
        
        view.addConstraintWithFormat(format: "H:|[v0]|",
                                     views: [collectionView])
        view.addConstraintWithFormat(format: "V:|[v0]|",
                                     views: [collectionView])
    }
}

//MARK: - CollectionViewDelegate, DataSource:
extension PhotosViewController: UICollectionViewDelegate,
                                UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell: PhotoCell =
            collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

//MARK: - CollectionView FlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 1
        let paddingWidth = 13 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem * 1.1)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
