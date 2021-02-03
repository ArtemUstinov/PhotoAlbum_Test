//
//  UsersViewController.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 02.02.2021.
//

import UIKit

class UsersViewController: UIViewController {
    
    //MARK: - Private properties:
    private let tableView = UITableView()
    
    private let networkManager = NetworkManager()
    
    private var userData = [User]()
    
    lazy private var errorAlertController = ErrorAlertController()

    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
                
        getData()
        setupTableView()
        setupLayouts()
    }
    
    //MARK: - Setup TableView:
    private func setupTableView() {
        title = "Users"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self)
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - Get data:
    private func getData() {
        networkManager.fetchDataUser {
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userData = data ?? []
                self.tableView.reloadData()
            case .failure(let error):
                self.errorAlertController.show(with: error) {
                    [weak self] alert in
                    self?.present(alert, animated: true)
                }
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Setup Layouts:
    private func setupLayouts() {
        view.addSubview(tableView)
        
        view.addConstraintWithFormat(format: "H:|[v0]|",
                                     views: [tableView])
        view.addConstraintWithFormat(format: "V:|[v0]|",
                                     views: [tableView])
    }
}

//MARK: - TableViewDelegate, DataSource:
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        userData.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UserCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configuraton(from: userData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let photosVC = PhotosViewController(with: userData[indexPath.row])
        show(photosVC, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

