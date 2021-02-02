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

    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        setupTableView()
        setupLayouts()
    }
    
    //MARK: - Setup TableView:
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserCell.self)
    }
    
    //MARK: - Setup Layouts:
    private func setupLayouts() {
        view.addSubview(tableView)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: [tableView])
        view.addConstraintWithFormat(format: "V:|[v0]|", views: [tableView])
    }
    
    
}

    //MARK: - TableViewDelegate, DataSource:
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserCell = tableView.dequeueReusableCell(for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = "FDAFD"
        
        cell.contentConfiguration = content
        return cell
    }
}

