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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: - Properties:
    private let networkManager = NetworkManager()
    private var user: User?
    private var albumData = [Album]()
    private var photo = [Photo]()
    
    lazy private var errorAlertController = ErrorAlertController()
    
    //MARK: - Initializer:
    init(with user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        getPhotos()
        setupCollectionView()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.stopAnimating()
    }
    
    //MARK: - Setup CollectionView:
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCell.self)
    }
    
    //MARK: - Get Data:
    func getPhotos() {
        networkManager.fetchDataAlbum() {
            [weak self] dataAlbum in
            guard let self = self else { return }
            
            let data = dataAlbum?.filter { $0.userId == self.user?.id }
            self.albumData = data ?? []
            self.getPhotoData()
        }
    }
    
    
    func getPhotoData() {
        networkManager.fetchDataPhoto() {
            [weak self] dataPhoto in
            guard let self = self,
                  let dataPhoto = dataPhoto else { return }
            
            for photo in self.albumData {
                self.photo =
                    dataPhoto.filter { $0.albumId == photo.userId }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - Setup layout:
    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        view.addConstraintWithFormat(format: "H:|[v0]|",
                                     views: [collectionView])
        view.addConstraintWithFormat(format: "V:|[v0]|",
                                     views: [collectionView])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor, constant: 0
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor, constant: 0
            )
        ])
    }
}

//MARK: - CollectionViewDelegate, DataSource:
extension PhotosViewController: UICollectionViewDelegate,
                                UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        photo.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell: PhotoCell =
            collectionView.dequeueReusableCell(for: indexPath)
        
        cell.configuration(photo: photo[indexPath.row])
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
